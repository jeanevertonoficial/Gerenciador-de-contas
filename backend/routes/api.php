<?php

use App\Http\Controllers\UsuarioController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/usuarios', [UsuarioController::class, 'store']);
Route::post('/criar-usuario', [UsuarioController::class, 'salvarUser']);
Route::post('/login-usuario', [UsuarioController::class, 'loginUser']);
Route::get('/usuarios/dados/{id}', [UsuarioController::class, 'index']);
Route::delete('/usuarios/deletar/{id}', [UsuarioController::class, 'destroy']);
Route::get('/usuarios/validar/{id}/{senha}', [UsuarioController::class, 'verificarSenha']);
