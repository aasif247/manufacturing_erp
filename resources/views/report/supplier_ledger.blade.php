@extends('layouts.app')
@section('title')
    Supplier Report
@endsection
@section('style')
    <style>
        .img-overlay {
            position: absolute;
            left: 0;
            top: 200px;
            width: 100%;
            height: 100%;
            overflow: hidden;
            text-align: center;
            z-index: 9;
            opacity: 0.2;
        }

        .img-overlay img {
            width: 400px;
            height: auto;
        }
    </style>
@endsection
@section('content')
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <form action="{{ route('supplier.ledger') }}">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Supplier</label>
                                    <select class="form-control select2" name="supplier">
                                        <option value="">All Supplier</option>
                                        @foreach($suppliers as $supplier)
                                            <option
                                                value="{{ $supplier->id }}" {{ request()->get('supplier') == $supplier->id ? 'selected' : '' }}>{{ $supplier->name}}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label> &nbsp;</label>
                                    <input class="btn btn-primary form-control" type="submit" value="Search">
                                </div>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <br><br>
                    <div id="prinarea">
                        <div class="row" id="heading_area" style="margin-bottom: 10px!important;display: none">
                            <div class="col-sm-12 text-center" style="font-size: 16px">
                                <h2 style="margin-bottom: 0 !important;"><img width="75px" src="{{ asset('img/logo.jpeg') }}" alt="">
                                    <strong
                                        style="border-bottom: 2px dotted #000;"><i>{{ config('app.name') }}</i>
                                    </strong>
                                </h2>
                                <strong style="border: 2px solid #000;padding: 1px 10px;font-size: 19px;">Supplier Report</strong>
                                <p class="">Printed by: {{Auth::user()->name}}</p>
                            </div>
                            <div class="col-sm-3 col-sm-offset-9">
                                <span class="date-top">Date: <strong
                                        style="border: 1px solid #000;padding: 1px 10px;font-size: 16px;width: 100%;font-weight: normal;">{{ date('d-m-Y') }}</strong></span>
                            </div>
                        </div>
                        <div style="clear: both">
                            <div class="table-responsive" >
                                <table id="table" class="table table-bordered table-striped" style="z-index: 5;">
                                    <thead>
                                    <tr>
                                        <th class="text-center">Sl</th>
                                        <th class="text-center">Name</th>
                                        <th class="text-center">Total</th>
                                        <th class="text-center">Paid</th>
                                        <th class="text-center">Due</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    @foreach($orders as $order)

                                        <tr>
                                            <td class="text-center">{{$loop->iteration}}</td>
                                            <td>{{$order->supplier->name}}</td>
                                            <td class="text-center">৳ {{number_format($order->total_sum,2)}}</td>
                                            <td class="text-center">৳ {{number_format($order->paid_sum,2)}}</td>
                                            <td class="text-center">৳ {{number_format($order->due_sum,2)}}</td>
                                            <td class="text-center">
                                                <form action="{{ route('purchase.report') }}">
                                                    <div class="">
                                                        <input type="text" hidden class="" name="supplier" value="{{$order->supplier_id}}">
                                                    </div>
                                                    <div class="">
                                                        <input class="btn btn-sm btn-warning" type="submit" value="View Details">
                                                    </div>
                                                </form>
                                            </td>
                                       </tr>
                                    @endforeach
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <th class="text-right" colspan="2">Total</th>
                                        <th class="text-center">৳ {{number_format($orders->sum('total_sum'))}}</th>
                                        <th class="text-center">৳ {{number_format($orders->sum('paid_sum'))}}</th>
                                        <th class="text-center">৳ {{number_format($orders->sum('due_sum'))}}</th>
                                         <th class="text-center"></th>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
@section('script')

    <script>
        $(function () {
            $('#table').DataTable();
            //Date picker
            $('#start, #end').datepicker({
                autoclose: true,
                format: 'yyyy-mm-dd'
            });
        });

    </script>
    <script>
        var APP_URL = '{!! url()->full()  !!}';

        function getprint(prinarea) {
            $('#heading_area').show();
            $('body').html($('#' + prinarea).html());
            window.print();
            window.location.replace(APP_URL)
        }
    </script>
@endsection
