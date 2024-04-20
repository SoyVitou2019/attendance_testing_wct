<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Attendance extends Model
{
    use HasFactory;

    protected $guarded = [
        "id",
        "created_at",
        "updated_at"
    ];
    protected $fillable = [
        'employee_id',
        'check_status',
        'others'
    ];
    function getTotalAttendance() {
        return Attendance::count();
    }
    function getAttendanceTable() {
        return Attendance::all();
    }
}
