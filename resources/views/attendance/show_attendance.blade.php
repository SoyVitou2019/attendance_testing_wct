@extends('layout.layout')

@section('content')
    <table class="table">
        <thead>
            <tr class="text-center">
                <th scope="col">#</th>
                <th scope="col">Employee ID</th>
                <th scope="col">Action</th>
            </tr>
        </thead>
        <tbody class="align-middle">
            <tr class="text-center">
                <th scope="row">{{ $attendance->id }}</th>
                <td scope="row">{{ $attendance->employee_id }}</td>
                
            </tr>
            
        </tbody>
    </table>
@endsection
