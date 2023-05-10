<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('valor_total', function (Blueprint $table) {
            $table->id();
            $table->float('valorTotal');
            $table->unsignedBigInteger('cliente_id');
            $table->foreign('cliente_id')->references('id')->on('clientes');
            $table->timestamps();
        });

        $sql = "INSERT INTO valor_total (valorTotal, cliente_id, created_at, updated_at)
            SELECT SUM(valor) AS valorTotal, cliente_id, NOW() AS created_at, NOW() AS updated_at
            FROM usuarios
            GROUP BY cliente_id";
        DB::statement($sql);
    }


    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('valor_total');
    }
};
