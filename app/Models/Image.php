<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    
    protected $fillable = [
        'name',
        'path',
        'mime_type',
        'size',
    ];
}
