<?php

use App\Http\Controllers\ProductController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UnitController;
use App\Http\Controllers\CommonController;
use App\Http\Controllers\PurchaseController;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\ProductCategoryController;
use App\Http\Controllers\ManufacturerConfigController;
use App\Http\Controllers\ManufacturerController;
use App\Http\Controllers\ReportController;

Route::get('/', function () {
    return redirect()->route('login');
});

Route::middleware(['auth'])->group(function () {
// Dashboard
    Route::get('dashboard', [DashboardController::class,'index'])->name('dashboard');

// Unit
    Route::get('unit', [UnitController::class,'index'])->name('unit');
    Route::get('unit/add', [UnitController::class,'add'])->name('unit.add');
    Route::post('unit/add', [UnitController::class,'addPost']);
    Route::get('unit/edit/{unit}', [UnitController::class,'edit'])->name('unit.edit');
    Route::post('unit/edit/{unit}', [UnitController::class,'editPost']);


// Product Category
    Route::get('product-category', [ProductCategoryController::class,'index'])->name('product_category');
    Route::get('product-category/add', [ProductCategoryController::class,'add'])->name('product_category.add');
    Route::post('product-category/add', [ProductCategoryController::class,'addPost']);
    Route::get('product-category/edit/{category}', [ProductCategoryController::class,'edit'])->name('product_category.edit');
    Route::post('product-category/edit/{category}', [ProductCategoryController::class,'editPost']);

// Product
    Route::get('all-product', [ProductController::class,'product'])->name('all_product');
    Route::get('product/add', [ProductController::class,'productAdd'])->name('product_add');
    Route::post('product/add', [ProductController::class,'productAddPost']);
    Route::get('product/edit/{product}', [ProductController::class,'productEdit'])->name('product.edit');
    Route::post('product/edit/{product}', [ProductController::class,'productEditPost']);
    Route::get('all-product-datatable', [ProductController::class,'productDatatable'])->name('product.datatable');

// Supplier
    Route::get('supplier', [SupplierController::class,'index'])->name('supplier');
    Route::get('supplier/add', [SupplierController::class,'add'])->name('supplier.add');
    Route::post('supplier/add', [SupplierController::class,'addPost']);
    Route::get('supplier/edit/{supplier}', [SupplierController::class,'edit'])->name('supplier.edit');
    Route::post('supplier/edit/{supplier}', [SupplierController::class,'editPost']);


// Purchase Order
    Route::get('purchase-order', [PurchaseController::class,'purchaseOrder'])->name('purchase_order.create');
    Route::post('purchase-order', [PurchaseController::class,'purchaseOrderPost']);

// Purchase Receipt
    Route::get('purchase-receipt', [PurchaseController::class,'purchaseReceipt'])->name('purchase_receipt.all');
    Route::get('purchase-receipt/details/{order}', [PurchaseController::class,'purchaseReceiptDetails'])->name('purchase_receipt.details');
    Route::get('purchase-receipt/print/{order}', [PurchaseController::class,'purchaseReceiptPrint'])->name('purchase_receipt.print');

    Route::get('purchase-receipt/datatable', [PurchaseController::class,'purchaseReceiptDatatable'])->name('purchase_receipt.datatable');
    Route::post('purchase-payment/make-payment', [PurchaseController::class,'purchaseMakePayment'])->name('purchase_payment.make_payment');
    

// Purchase Inventory
    Route::get('inventory', [PurchaseController::class,'inventory'])->name('inventory.all');
    Route::get('inventory/datatable', [PurchaseController::class,'inventoryDatatable'])->name('inventory.datatable');
    Route::get('inventory/details/{product}', [PurchaseController::class,'inventoryDetails'])->name('inventory.details');
    Route::get('inventory-details/datatable', [PurchaseController::class,'inventoryDetailsDatatable'])->name('inventory.details.datatable');

 // Manufacture template
    Route::get('manufacture-template', [ManufacturerConfigController::class,'index'])->name('manufacture_template');
    Route::get('manufacture-template/create', [ManufacturerConfigController::class,'create'])->name('manufacture_template.create');
    Route::post('manufacture-template/create', [ManufacturerConfigController::class,'store']);
    Route::get('manufacture-template/datatable', [ManufacturerConfigController::class,'datatable'])->name('manufacture_template.datatable');
    Route::get('manufacture-template/edit/{configProduct}', [ManufacturerConfigController::class,'edit'])->name('manufacture_template.edit');
    Route::post('manufacture-template/edit/{configProduct}', [ManufacturerConfigController::class,'update']);
    Route::post('manufacture-template/delete', [ManufacturerConfigController::class,'delete'])->name('manufacture_template.delete');


// Manufacture
    Route::get('manufacture/create', [ManufacturerController::class,'create'])->name('manufacture.create');
    Route::post('manufacture/create', [ManufacturerController::class,'store']);
    Route::get('finished-goods', [ManufacturerController::class,'index'])->name('finished_goods');
    Route::get('finished-goods-details/{finishedGoods}', [ManufacturerController::class,'details'])->name('finished_goods_details');
    Route::get('finished-goods/datatable', [ManufacturerController::class,'datatable'])->name('finished_goods.datatable');
    Route::post('finished-goods/delete', [ManufacturerController::class,'delete'])->name('finished_goods.delete');


// Serial add
    Route::get('serial-add/{finishedGoods}', [ManufacturerController::class,'addSerial'])->name('add_serial');
    Route::post('serial/update', [ManufacturerController::class,'updateSerial'])->name('update_serial');

// Finish inventory
    Route::get('finish-inventory', [ManufacturerController::class,'inventory'])->name('finish_inventory.all');
    Route::get('finish-inventory/datatable', [ManufacturerController::class,'inventoryDatatable'])->name('finish_inventory.datatable');


// Finish stock
    Route::get('finish-stock/{product}', [ManufacturerController::class,'finishStockDetails'])->name('finish_stock.details');
      

// Stock
    Route::get('stock', [ManufacturerController::class,'stock'])->name('all_stock.all');
    Route::get('stock/datatable', [ManufacturerController::class,'stockDatatable'])->name('all_stock.datatable');
    Route::get('stock/{product}', [ManufacturerController::class,'stockDetails'])->name('stock.details');
    Route::get('stock-details/datatable', [ManufacturerController::class,'inventoryDetailsDatatable'])->name('stock.details.datatable');

// Report
    Route::get('supplier-report', [ReportController::class,'supplierReport'])->name('supplier.ledger');
    Route::get('purchase-report', [ReportController::class,'purchaseReport'])->name('purchase.report');
   
    
    Route::get('get-product-details', [ManufacturerConfigController::class,'getProductDetails'])->name('get_product_details');
    Route::get('get_template_details', [ManufacturerConfigController::class,'getTemplateDetails'])->name('get_template_details');


// Common Controller
    Route::get('get-sub-category', [CommonController::class,'getSubCategory'])->name('get_subCategory');
    Route::get('get-unit', [CommonController::class,'getUnit'])->name('get_unit');
    Route::get('account-head-code-json', [CommonController::class, 'accountHeadCodeJson'])->name('account_head_code.json');
    Route::get('sale-product-json', [CommonController::class, 'saleProductJson'])->name('sale_product.json');
    Route::get('product-json', [CommonController::class, 'productJson'])->name('product.json');
});



require __DIR__.'/auth.php';
