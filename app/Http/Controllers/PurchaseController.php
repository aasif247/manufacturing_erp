<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Models\Inventory;
use App\Models\InventoryLog;
use App\Models\Product;
use Carbon\Carbon;
use Ramsey\Uuid\Uuid;
use Illuminate\Http\Request;
use App\Models\PurchaseOrder;
use App\Models\TransactionLog;
use App\Models\PurchaseInventory;
use App\Models\PurchaseInventoryLog;
use App\Models\PurchaseOrderProduct;
use Yajra\DataTables\Facades\DataTables;

class PurchaseController extends Controller
{
    public function purchaseOrder() {
        $suppliers = Client::where('type',2)->where('status', 1)->orderBy('name')->get();
        $products = Product::where('product_type',2)->where('status',1)->orderBy('name')->get();
        return view('purchase.purchase_order.create', compact('suppliers', 'products'));
    }

    public function purchaseOrderPost(Request $request)
    {

        $rules = [
            'supplier' => 'required',
            'date' => 'required|date',
            'product.*' => 'required|numeric|min:0',
            'quantity.*' => 'required|numeric|min:0',
            'unit_price.*' => 'required|numeric|min:0',
            'notes' => 'nullable',
            'supporting_document' => 'nullable',
            'paid' => 'required|numeric|min:0',
            'discount' => 'required|numeric|min:0',
        ];


        if ($request->payment_type == '2') {
            $rules['cheque_no'] = 'required|string|max:255';
        }
        if ($request->paid > 0){
            $rules['payment_type'] = 'required';
        }

        $request->validate($rules);

        $order = new PurchaseOrder();
        $order->supplier_id = $request->supplier;
        $order->date = Carbon::parse($request->date)->format('Y-m-d');
        $order->vat_percentage = $request->vat;
        $order->vat = 0;
        $order->discount_percentage = $request->discount_percentage;
        $order->discount = $request->discount;
        $order->paid = $request->paid;
        $order->total = 0;
        $order->due = 0;
        $order->save();
        $order->order_no = 'PO'.str_pad($order->id, 8, 0, STR_PAD_LEFT);
        $order->save();
        $counter = 0;
        $subTotal = 0;

        foreach ($request->product as $reqProduct) {
            $product = Product::where('id', $reqProduct)->first();
            if($product->quantity==0){
                $product->update([
                    'quantity' => $request->quantity[$counter],
                    'unit_price' => $request->unit_price[$counter],
                    'purchase_order_id' => $order->id,
                ]);
            }

            $productPurchaseOrder = PurchaseOrderProduct::create([
                'purchase_order_id' => $order->id,
                'supplier_id' => $request->supplier,
                'product_id' => $product->id,
                'name' => $product->name,
                'quantity' => $request->quantity[$counter],
                'unit_price' => $request->unit_price[$counter],
                'total' => ($request->quantity[$counter] * $request->unit_price[$counter]),
            ]);


            $subTotal += ($request->quantity[$counter] * $request->unit_price[$counter]);

            $inventory = Inventory::where('product_id',$product->id)
                ->first();
                if ($inventory){
                    $inventory->update([
                        'quantity' => $inventory->quantity + $request->quantity[$counter],
                        'unit_price' => $request->unit_price[$counter],
                    ]);
                }else{
                    $inventory = Inventory::create([
                        'product_id' => $product->id,
                        'product_type' => 2, //raw Material
                        'quantity' => $request->quantity[$counter],
                        'unit_price' => $request->unit_price[$counter],
                    ]);
                }

            // Inventory Log
            $log = InventoryLog::create([
                'purchase_order_id' => $order->id,
                'product_id' => $product->id,
                'type' => 1,
                'quantity' => $request->quantity[$counter],
                'unit_price' => $request->unit_price[$counter],
                'total' => $request->quantity[$counter] * $request->unit_price[$counter],
                'supplier_id' => $request->supplier,
                'date' => Carbon::parse($request->date)->format('Y-m-d'),
                'note' => 'Purchase Product',
            ]);

            $log->update([
                'inventory_id' => $inventory->id,
                'serial' => str_pad($inventory->id, 8, 0, STR_PAD_LEFT),
            ]);

            $productPurchaseOrder->update(['purchase_inventory_id' => $inventory->id]);
            $inventory->update([
                'serial' => str_pad($inventory->id, 8, 0, STR_PAD_LEFT),
            ]);

            $productPurchaseOrder->update(['serial' => $inventory->serial]);

            $counter++;
        }


        $total = $subTotal;
        $order->sub_total = $total;
        $order->total = $subTotal-$request->discount;
        $order->due =$subTotal-$request->discount - $request->paid;
        $order->save();

        $request['financial_year'] = convertDateToFiscalYear($request->date);

        $financialYear = financialYear($request->financial_year);


        $log = new TransactionLog();
        $log->date = Carbon::parse($request->date)->format('Y-m-d');
        $log->financial_year = financialYear($request->financial_year);
        $log->amount = $order->total;
        $log->notes = $request->note;
        $log->save();

        if($request->discount > 0){
            $log = new TransactionLog();
            $log->date = Carbon::parse($request->date)->format('Y-m-d');
            $log->financial_year = financialYear($request->financial_year);
            $log->amount = $request->discount;
            $log->notes = $request->note;
            $log->save();
        }

        ///Start from here

        if ($request->supporting_document) {
            // Upload Image
            $file = $request->file('supporting_document');

            $filename = Uuid::uuid1()->toString().'.'.$file->getClientOriginalExtension();
            $destinationPath = 'uploads/supporting_document';
            $file->move($destinationPath, $filename);
            $path = 'uploads/supporting_document/' . $filename;
        }

        if ($request->paid > 0){
            if ($request->payment_type == 1){
                $transactionType = 2;
                $financialYear = $request->financial_year;

                //Cash Credit
                $log = new TransactionLog();
                $log->payment_type = 2;//Cash
                $log->amount = $request->paid;
                $log->save();

                $log = new TransactionLog();
                $log->financial_year = financialYear($request->financial_year);
                $log->date = Carbon::parse($request->date)->format('Y-m-d');
                $log->transaction_type = 2;
                $log->payment_type = 2;
                $log->amount = $request->paid;
                $log->notes = $request->note;
                $log->save();
            }elseif ($request->payment_type == 2){
                
                //Bank Credit
                $log = new TransactionLog();
                $log->cheque_date = Carbon::parse($request->date)->format('Y-m-d');
                $log->cheque_no = $request->cheque_no;
                $log->payment_type = 1;
                $log->amount = $request->paid;
                $log->save();

                $log = new TransactionLog();
                $log->financial_year = financialYear($request->financial_year);
                $log->date = Carbon::parse($request->date)->format('Y-m-d');
                $log->transaction_type = 2;
                $log->payment_type = 1;
                $log->cheque_no = $request->cheque_no;
                $log->cheque_date = Carbon::parse($request->date)->format('Y-m-d');
                $log->amount = $request->paid;
                $log->notes = $request->note;
                $log->save();
            }
        }

        return redirect()->route('purchase_receipt.details', ['order' => $order->id]);
    }

    public function purchaseReceipt() {
        return view('purchase.receipt.all');
    }

    public function purchaseReceiptDetails(PurchaseOrder $order) {
        return view('purchase.receipt.details', compact('order'));
    }

    public function purchaseReceiptPrint(PurchaseOrder $order) {
        return view('purchase.receipt.print', compact('order'));
    }

    public function purchaseReceiptDatatable() {
        $query = PurchaseOrder::with('supplier');

        return DataTables::eloquent($query)
            ->addIndexColumn()
            ->addColumn('supplier', function(PurchaseOrder $order) {
                return $order->supplier->name ?? '';
            })
            ->addColumn('action', function(PurchaseOrder $order) {
                $btn  = '<a href="' . route('purchase_receipt.details', ['order' => $order->id]) . '" class="btn btn-primary btn-sm"><i class="fa fa-eye"></i></a> ';
               return $btn;
            })
            ->editColumn('date', function(PurchaseOrder $order) {
                return $order->date;
            })
            ->addColumn('quantity', function (PurchaseOrder $order) {
                return $order->quantity() ?? '';
            })
            ->editColumn('total', function(PurchaseOrder $order) {
                return '৳'.number_format($order->total, 2);
            })
            ->editColumn('paid', function(PurchaseOrder $order) {
                return '৳'.number_format($order->paid, 2);
            })
            ->editColumn('due', function(PurchaseOrder $order) {
                return '৳'.number_format($order->due, 2);
            })
            ->orderColumn('date', function ($query, $order) {
                $query->orderBy('date', $order)->orderBy('created_at', 'desc');
            })
            ->rawColumns(['action'])
            ->toJson();
    }


    public function purchaseInventory() {
        return view('purchase.inventory.all');
    }

    public function purchaseInventoryDetails(PurchaseOrderProduct $product) {
        return view('purchase.inventory.details', compact('product'));
    }

    public function purchaseInventoryDatatable() {
        $query = PurchaseInventory::with('product', 'category', 'subcategory');

        return DataTables::eloquent($query)
            ->addColumn('product', function(PurchaseInventory $inventory) {
                return $inventory->product->name??'';
            })
            ->addColumn('category', function(PurchaseInventory $inventory) {
                return $inventory->product->category->name??'';
            })
            ->addColumn('subcategory', function(PurchaseInventory $inventory) {
                return $inventory->product->subcategory->name??'';
            })
            ->addColumn('action', function(PurchaseInventory $inventory) {
                return '<a href="'.route('purchase_inventory.details', ['product' => $inventory->purchase_product_id]).'" class="btn btn-primary btn-sm">Details</a>';
            })
            ->editColumn('quantity', function(PurchaseInventory $inventory) {
                return number_format($inventory->quantity, 2);
            })
            ->editColumn('total', function(PurchaseInventory $inventory) {
                return number_format($inventory->total, 2);
            })
            ->rawColumns(['action'])
            ->toJson();
    }

    public function purchaseInventoryDetailsDatatable() {
        $query = PurchaseInventoryLog::where('purchase_product_id', request('product_id'))
            ->with('product', 'supplier', 'purchaseOrder');

        return DataTables::eloquent($query)
            ->editColumn('date', function(PurchaseInventoryLog $log) {
                return $log->date;
            })
            ->editColumn('type', function(PurchaseInventoryLog $log) {
                if ($log->type == 1)
                    return '<span class="badge badge-success">In</span>';
                elseif ($log->type == 2)
                    return '<span class="badge badge-danger">Out</span>';
                else
                    return '';
            })
            ->editColumn('quantity', function(PurchaseInventoryLog $log) {
                return number_format($log->quantity, 2);
            })
            ->editColumn('selling_price', function(PurchaseInventoryLog $log) {
                return number_format($log->selling_price, 2);
            })
            ->editColumn('total', function(PurchaseInventoryLog $log) {
                return number_format($log->total, 2);
            })
            ->editColumn('unit_price', function(PurchaseInventoryLog $log) {
                if ($log->unit_price)
                    return '৳'.number_format($log->unit_price, 2);
                else
                    return '';
            })
            ->editColumn('supplier', function(PurchaseInventoryLog $log) {
                if ($log->supplier)
                    return $log->supplier->name;
                else
                    return '';
            })
            ->editColumn('purchase_order', function(PurchaseInventoryLog $log) {
                if ($log->purchaseOrder)
                    return '<a href="'.route('purchase_receipt.details', ['order' => $log->purchaseOrder->id]).'">'.$log->purchaseOrder->order_no.'</a>';
                else
                    return '';
            })
            ->orderColumn('date', function ($query, $order) {
                $query->orderBy('date', $order)->orderBy('created_at', 'desc');
            })
            ->rawColumns(['type', 'order'])
            ->filter(function ($query) {
                if (request()->has('date') && request('date') != '') {
                    $dates = explode(' - ', request('date'));
                    if (count($dates) == 2) {
                        $query->where('date', '>=', $dates[0]);
                        $query->where('date', '<=', $dates[1]);
                    }
                }

                if (request()->has('type') && request('type') != '') {
                    $query->where('type', request('type'));
                }
            })
            ->rawColumns(['action','purchase_order','type'])
            ->toJson();
    }

    public function inventory() {
        return view('purchase.inventory.all');
    }

    public function inventoryDatatable() {

        $query = Inventory::with('product')->where('product_type',2);

        return DataTables::eloquent($query)
            ->addIndexColumn()
            ->addColumn('product', function(Inventory $inventory) {
                return $inventory->product->name??'';
            })

            ->addColumn('action', function (Inventory $inventory) {
                return '<a href="' . route('inventory.details', ['product' => $inventory->product_id, 'color' => $inventory->color_id, 'size' => $inventory->size_id]) . '" class="btn btn-primary btn-sm">Details</a>';
            })

            ->editColumn('quantity', function(Inventory $inventory) {
                return number_format($inventory->quantity, 2);
            })
            ->editColumn('total', function(Inventory $inventory) {
                return number_format($inventory->total, 2);
            })
            ->rawColumns(['action'])
            ->toJson();
    }

    public function inventoryDetails(Product $product) {
        return view('purchase.inventory.details', compact('product'));
    }

    public function inventoryDetailsDatatable() {

        $query = InventoryLog::where('product_id', request('product_id'))
            ->with('product', 'supplier', 'purchaseOrder');



        return DataTables::eloquent($query)
            ->editColumn('date', function(InventoryLog $log) {
                return $log->date;
            })
            ->editColumn('type', function(InventoryLog $log) {
                if ($log->type == 1)
                    return '<span class="badge badge-success">In</span>';
                elseif ($log->type == 2)
                    return '<span class="badge badge-danger">Out</span>';
                else
                    return '';
            })
            ->editColumn('quantity', function(InventoryLog $log) {
                return number_format($log->quantity, 2);
            })
            ->editColumn('selling_price', function(InventoryLog $log) {
                return number_format($log->selling_price, 2);
            })
            ->editColumn('total', function(InventoryLog $log) {
                return number_format($log->total, 2);
            })
            ->editColumn('unit_price', function(InventoryLog $log) {
                if ($log->unit_price)
                    return '৳'.number_format($log->unit_price, 2);
                else
                    return '';
            })
            ->editColumn('supplier', function(InventoryLog $log) {
                if ($log->supplier)
                    return $log->supplier->name??'';
                else
                    return '';
            })
            ->editColumn('purchase_order', function(InventoryLog $log) {
                if ($log->purchaseOrder)
                    return '<a href="'.route('purchase_receipt.details', ['order' => $log->purchaseOrder->id]).'">'.$log->purchaseOrder->order_no.'</a>';
                else
                    return '';
            })
            ->orderColumn('date', function ($query, $order) {
                $query->orderBy('date', $order)->orderBy('created_at', 'desc');
            })
            ->rawColumns(['type', 'order'])
            ->filter(function ($query) {
                if (request()->has('date') && request('date') != '') {
                    $dates = explode(' - ', request('date'));
                    if (count($dates) == 2) {
                        $query->where('date', '>=', $dates[0]);
                        $query->where('date', '<=', $dates[1]);
                    }
                }

                if (request()->has('type') && request('type') != '') {
                    $query->where('type', request('type'));
                }
            })
            ->rawColumns(['action','purchase_order','type'])
            ->toJson();
    }
}
