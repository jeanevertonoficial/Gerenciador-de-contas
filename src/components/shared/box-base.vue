<template>
  <div class="boxs">
  <div class="box-base cartoes">
    <div class="box-base-titulo">
      <div class="titulo_base">
        {{ titulo_cartao }}
      </div>
      <card/>
    </div>

  </div>
    {{ dados_salvos }}
    <div class="box-base boletos">
      <div class="box-base-titulo">
        <div class="titulo_base">
          {{ titulo_boleto }}
        </div>
        <card/>
      </div>
    </div>
    <FormularioDeRegistro/>
  </div>
</template>

<script>
import Card from "@/components/shared/card.vue";
import FormularioDeRegistro from "@/components/shared/formulario-de-registro.vue";

export default {
  name: "box-base",
  components: { FormularioDeRegistro, Card },
  props: ["titulo_cartao", "titulo_boleto", 'dados_salvos'],
  mounted() {
    console.log(this.dados_salvos)
  }
};
</script>
