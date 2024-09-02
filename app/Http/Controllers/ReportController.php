<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Models\PurchaseOrder;
use Illuminate\Http\Request;
use SakibRahaman\DecimalToWords\DecimalToWords;

class ReportController extends Controller
{

    public function supplierReport(Request $request){
        $suppliers = Client::where('type',2)->orderBy('name')->get();
        $appends = [];
        $query = PurchaseOrder::query();

        if ($request->supplier && $request->supplier != '') {
            $query->where('supplier_id', $request->supplier);
            $appends['supplier'] = $request->supplier;
        }

        $query->selectRaw('supplier_id, SUM(total) as total_sum,SUM(due) as due_sum,
                       SUM(paid) as paid_sum')
            ->groupBy('supplier_id');

        $orders = $query->get();


        return view('report.supplier_ledger',compact('suppliers','orders','appends'));
    }

    public function purchaseReport(Request $request){
        $suppliers = Client::where('type',2)->orderBy('name')->get();
        $appends = [];
        $query = PurchaseOrder::with('supplier');

        $start = date('Y-m-d', strtotime($request->start));
        $end = date('Y-m-d', strtotime($request->end));

        if ($request->start && $request->end) {
            $query->whereBetween('date', [$start, $end]);
            $appends['date'] = $request->date;
        }

        if ($request->supplier && $request->supplier != '') {
            $query->where('supplier_id', $request->supplier);
            $appends['supplier'] = $request->supplier;
        }

        $currentMonth = date('m');
        if ($currentMonth < 7) {
            $currentYear = date('Y') - 1;
            $currentDate = date('01-08-' . $currentYear);
        } else {
            $currentDate = date('01-08-Y');
        }

        $query->orderBy('date', 'desc')->orderBy('created_at', 'desc');

        $data = [
            'total' => $query->sum('total'),
            'due' => $query->sum('due'),
            'paid' => $query->sum('paid'),
        ];

        $orders = $query->paginate(10);


        return view('report.purchase_report', compact('orders', 'suppliers',
            'appends','currentDate'))->with($data);
    }
}
