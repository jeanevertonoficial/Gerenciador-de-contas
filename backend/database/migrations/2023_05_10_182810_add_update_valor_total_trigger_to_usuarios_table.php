<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        $sql = "CREATE TRIGGER usuarios_after_update
            AFTER UPDATE ON usuarios
            FOR EACH ROW
            BEGIN
                UPDATE valor_total
                SET valorTotal = (
                    SELECT SUM(valor)
                    FROM usuarios
                    WHERE cliente_id = NEW.cliente_id
                )
                WHERE cliente_id = NEW.cliente_id;
            END";
        DB::statement($sql);
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        $sql = "DROP TRIGGER usuarios_after_update";
        DB::statement($sql);
    }

};
