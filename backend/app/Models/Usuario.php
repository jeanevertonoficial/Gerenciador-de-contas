<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Usuario extends Model
{
    use HasFactory;

    protected $fillable = [
        'titulo',
        'valor',
        'tipo',
        'email',
    ];

    public function cliente()
    {
        return $this->belongsTo(Cliente::class);
    }
}
