<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    use HasFactory;

    protected $fillable = [
        'email'
    ];

    public function usuarios()
    {
        return $this->hasMany(Usuario::class, 'cliente_id');
    }
}
