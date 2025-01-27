<?php

namespace App\Http\Controllers;
use App\Models\Employee;
use App\Models\Position;
use App\Models\Shift;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;

class EmployeeCrudController extends Controller
{
    public function store() {
        
        $validated = request()->validate([
            'first_name' => 'required|max:25',
            'last_name' => 'required|max:25',
            'phone' => 'required|numeric|digits_between:9,10',
            'shift' => 'required|exists:shifts,id',
            'position' => 'required|exists:positions,id'
        ]);

        $employee = Employee::create([
            'first_name' => ucfirst($validated['first_name']),
            'last_name' => ucfirst($validated['last_name']),
            'phone' => $validated['phone'],
            'password' => Hash::make('AttendIn2024@!'),
            'email' => strtolower($validated['first_name']) . '.' . strtolower($validated['last_name']) . '.' . date('Y') .'@attendin.com',
            'shift_id' => $validated['shift'],
            'position_id' => $validated['position'],
            'others' => request()->get('others')
        ]);
        $employee->save();

        return redirect()->back()->with('success','Employee Created!');
    }
    public function destroy(Employee $employee) {
        $employee->delete();

        return redirect()->back()->with('danger','Employee Deleted!');
    }

    public function show(Employee $employee) {
        return view('employee.show_employee', compact('employee'));
    }

    public function edit(Employee $employee) {
        $editting = true;
        $shifts = Shift::orderBy('id')->get();
        $positions = Position::orderBy('id')->get();
        return view('employee.show_employee', compact('employee', 'editting', 'shifts', 'positions'));
    }

    public function update(Employee $employee) {
        $validated = request()->validate([
            'first_name' => 'required|max:25',
            'last_name' => 'required|max:25',
            'phone' => 'required|numeric|digits_between:9,10',
            'email' => 'required|email',
            'shift' => 'required|exists:shifts,id',
            'position' => 'required|exists:positions,id'
        ]);
        
        $employee->update([$validated, 'position_id' => $validated['position'], 'shift_id' => $validated['shift'], 'others' => request()->get('others')]);
    
        return redirect()->route('employee.show', $employee->id)->with('success', 'Employee Updated');
    }
    
    public function reset(Employee $employee) {
        $employee->update([
            'password' => Hash::make('AttendIn2024@!')
        ]);

        return redirect()->route('employee.show', $employee->id)->with('success', 'Employee Password Reset');
    }
}

// use Illuminate\Support\Facades\Hash;
// Hash::check($userInputPassword, $hashedPassword)