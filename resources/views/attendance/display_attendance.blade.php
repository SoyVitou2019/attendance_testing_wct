@extends('layout.layout')

@section('content')
    <table class="table">
        <thead>
            <tr class="text-center">
                <th scope="col">#</th>
                <th scope="col">Employee ID</th>
            </tr>
        </thead>
        <tbody class="align-middle">
            @foreach ((new App\Models\Attendance())->getAttendanceTable() as $position)
                <tr class="text-center">
                    <th scope="row">{{ $position->id }}</th>
                    <td scope="row">{{ $position->employee_id }}</td>
                </tr>
            @endforeach
        </tbody>    
    </table>
@endsection