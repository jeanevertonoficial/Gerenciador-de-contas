<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Models\Usuario;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UsuarioController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request, $id)
    {
        //pegar dados cadastrado com id = email como parametro vindo do front
        $dados = DB::table('clientes')
            ->join('usuarios', 'clientes.id', '=', 'usuarios.cliente_id')
            ->select('*')
            ->where('email', $id)
            ->orderBy('usuarios.valor', 'ASC')
            ->get();

        return response()->json($dados, 201);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'titulo' => 'required',
            'valor' => 'required|numeric',
            'tipo' => 'required',
            'mes_referente' => 'required'
        ]);

        try {
            // salvar email na tabela clientes
            $cliente = new Cliente();
            $cliente->email = $request->email;
            $cliente->senha = Hash::make($request->senha);
            $cliente->save();

            // salvar dados na tabela usuarios
            $cliente = Cliente::firstOrCreate(['email' => $request->email]);
            $usuario = new Usuario;
            $usuario->titulo = $request->titulo;
            $usuario->valor = $request->valor;
            $usuario->tipo = $request->tipo;
            $usuario->mes_referente = $request->mes_referente;
            $usuario->cliente()->associate($cliente);
            $usuario->save();

            return response()->json(['message' => 'Usuário criado com sucesso'], 201);

        } catch (\InvalidArgumentException $e) {
            return response()->json(['message' => 'Erro ao tentar cadastrar'], 400);
        }

    }

    public function criarCliente(Request $request): JsonResponse
    {
        $cliente = new Cliente();

        $cliente->email = $request->email;
        $cliente->senha = Hash::make($request->senha);

        $cliente->save();

        return response()->json($cliente);
    }

    public function verificarSenha(Request $request): JsonResponse
    {
        $cliente = Cliente::where('email', $request->email)->first();

        if (!$cliente || !Hash::check($request->senha, $cliente->senha)) {
            return response()->json(['message' => 'Email ou senha inválidos.'], 401);
        }

        return response()->json($cliente);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $usuario = Usuario::find($id);
        if ($usuario) {
            $usuario->delete();
            return response()->json(['message' => 'Deletado com sucesso.'], 201);
        } else {
            return response()->json(['message' => 'Usuário não encontrado.'], 400);
        }
    }

}
