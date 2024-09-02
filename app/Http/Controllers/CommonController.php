<?php

namespace App\Http\Controllers;

use App\Models\Inventory;
use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\PurchaseOrderProduct;
use App\Models\Unit;
use Illuminate\Http\Request;


class CommonController extends Controller
{

    public function getSubCategory(Request $request)
    {
        $subcategory = ProductCategory::where('product_category_id', $request->categoryID)
            ->where('status', 1)
            ->orderBy('name')
            ->get()->toArray();

        return response()->json($subcategory);
    }


    public function getUnit(Request $request)
    {
        $product =Product::where('id', $request->productID)->first();

        $unit = Unit::where('id',$product->unit_id)->first();

        $lastPurchasePrice = PurchaseOrderProduct::where('product_id', $request->productID)->latest()->first();

        return response()->json([
            'unit'=>$unit,
            'lastPurchasePrice'=>$lastPurchasePrice,
        ]);
    }


    public function saleProductJson(Request $request)
    {
        if (!$request->searchTerm) {
            $products = Inventory::where('product_type',3)
                ->where('quantity', '>', 0)
                ->where('serial','!=',null)
                ->limit(20)
                ->get();
        } else {

            $products =Inventory::where('product_type',3)
                ->where('quantity', '>', 0)
                ->where('serial','!=',null)
                ->whereHas('product', function ($query) use ($request) {
                    $query->where('name', 'like', '%' . $request->searchTerm . '%');
                })
                ->orWhere('serial', 'like','%'.$request->searchTerm.'%')
                ->limit(20)
                ->get();

        }
        $data = array();

        foreach ($products as $product) {
            $data[] = [
                'id' => $product->id,
                'text' =>$product->product->name.' - '.$product->serial ?? '',
            ];
        }

        echo json_encode($data);
    }

    public function productJson(Request $request)
    {
        if (!$request->searchTerm) {
            $products = Product::where('product_type', 2)
                ->where('status', 1)
                ->where('quantity','>', 0)
                ->orderBy('name')
                ->limit(20)
                ->get();
        } else {
            $products = Product::where('product_type', 2)
                ->where('name', 'like','%'.$request->searchTerm.'%')
                ->where('quantity','>', 0)
                ->orderBy('name')
                ->limit(20)
                ->get();

        }
        $data = array();

        foreach ($products as $product) {
            $data[] = [
                'id' => $product->id,
                'text' =>$product->name.' - '.$product->unit->name ?? '',
            ];
        }

        echo json_encode($data);
    }

}
