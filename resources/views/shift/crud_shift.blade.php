@extends('layout.layout')

@section('content')
    @include('shift.create_shift')
    <table class="table">
        <thead>
            <tr class="text-center">
                <th scope="col">#</th>
                <th scope="col">Shift Name</th>
                <th scope="col">Start Time</th>
                <th scope="col">End Time</th>
                <th scope="col">Late Policy</th>
                <th scope="col">Actions</th>
            </tr>
        </thead>
        <tbody class="align-middle">
            @foreach ((new App\Models\Shift())->paginate(10) as $shift)
                <tr class="text-center">
                    <th scope="row">{{ $shift->id }}</th>
                    <td scope="row">{{ $shift->shift_name }}</td>
                    <td scope="row">{{ $shift->shift_start_time }}</td>
                    <td scope="row">{{ $shift->shift_end_time }}</td>
                    <td scope="row">{{ $shift->late_policy }}</td>
                    <td scope="row">
                        <div class="d-flex align-items-center justify-content-center">
                            @include('shift.edit_shift')
                            @include('shift.delete_shift')
                        </div>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
    {{ (new App\Models\Shift())->paginate(10) -> links() }}
@endsection