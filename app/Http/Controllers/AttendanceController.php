<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use Illuminate\Http\Request;

class AttendanceController extends Controller
{
    public function show(Attendance $attendance) {
        return view('attendance.show_attendance', compact('attendance'));
    }
    
}
