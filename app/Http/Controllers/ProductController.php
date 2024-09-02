<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\Unit;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Yajra\DataTables\Facades\DataTables;

class ProductController extends Controller
{
    public function product(){
        return view('purchase.product.all');
    }

    public function productAdd(){
        $categories = ProductCategory::where('status', 1)->orderBy('id', 'asc')->get();
        $units = Unit::where('status', 1)->get();
        return view('purchase.product.add', compact('categories','units'));
    }

    public function productAddPost(Request $request){
        $rules = [
            'product_type' => 'required',
            'name' =>  [
                'required',
                Rule::unique('products')
                    ->where('name', $request->name)
            ],
            'unit' => 'required',
            'description' => 'nullable',
            'warning_quantity' => 'required',
            'warranty' => 'nullable|string|max:255',
            'status' => 'required'
        ];


        if ($request->product_type == 1) {
            $rules['category'] = 'required';
        }

        $request->validate($rules);
        $product = new Product();
        $product->category_id = $request->category ?? null;
        $product->product_type = $request->product_type;
        $product->warning_quantity = $request->warning_quantity;
        $product->warranty = $request->warranty;
        $product->name = $request->name;
        $product->unit_id = $request->unit;
        $product->description = $request->description;
        $product->status = $request->status;
        $product->save();

        return redirect()->route('all_product')->with('message', 'Product Added Successfully.');
    }

    public function productDatatable(){
        $query = Product::with('category','unit')->where('status', 1);
        return DataTables::eloquent($query)
            ->addIndexColumn()
            ->addColumn('action', function(Product $product) {
                return '<a href="'.route('product.edit',['product'=>$product->id]).'" class="btn btn-success btn-sm btn-edit"><i class="fa fa-edit"></i></a>';
            })
            ->addColumn('category', function(Product $product) {
                return $product->category->name?? '';
            })
            ->addColumn('unit', function(Product $product) {
                return $product->unit->name?? '';
            })
            ->addColumn('status', function(Product $product) {
                if ($product->status == 1)
                    return '<span class="badge badge-success">Active</span>';
                else
                    return '<span class="badge badge-danger">Inactive</span>';
            })
            ->addColumn('product_type', function(Product $product) {
                if ($product->product_type == 1)
                    return 'Finish Good';
                else if ($product->product_type == 2)
                    return 'Materials';
            })
            ->rawColumns(['action','status','product_type'])
            ->toJson();
    }

    public function productEdit(Product $product){
        $categories = ProductCategory::where('status', 1)->orderBy('id', 'asc')->get();
        $units = Unit::where('status', 1)->get();
        return view('purchase.product.edit', compact('product','categories','units'));
    }

    public function productEditPost(Product $product, Request $request){
        $rules = [
            'product_type' => 'required',
            'name' =>  [
                'required',
                Rule::unique('products')
                    ->ignore($product->id)
                    ->where('name', $request->name)
            ],
            'unit' => 'required',
            'description' => 'nullable',
            'warning_quantity' => 'required',
            'warranty' => 'nullable|string|max:255',
            'status' => 'required'
        ];

        if ($request->product_type == 1) {
            $rules['category'] = 'required';
        }

        $request->validate($rules);
        $product->category_id = $request->category ?? null;
        $product->name = $request->name;
        $product->unit_id = $request->unit;
        $product->product_type = $request->product_type;
        $product->warning_quantity = $request->warning_quantity;
        $product->warranty = $request->warranty;
        $product->description = $request->description;
        $product->status = $request->status;
        $product->save();

        return redirect()->route('all_product')->with('message', 'Product Edit Successfully.');
    }
}
