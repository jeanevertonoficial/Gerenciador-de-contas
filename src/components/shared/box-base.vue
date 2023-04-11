<template>
  <div class="boxs">
    <div class="box-base cartoes">
      <div class="box-base-titulo">
        <div class="titulo_base">
          {{ titulo_cartao }}
        </div>
        <Card />
      </div>
    </div>
    <div class="box-base boletos">
      <div class="box-base-titulo">
        <div class="titulo_base">
          {{ titulo_boleto }}
        </div>
        <Card />
      </div>
    </div>
    <FormularioDeRegistro />
  </div>
</template>

<script>
import Card from "@/components/shared/card.vue";
import FormularioDeRegistro from "@/components/shared/formulario-de-registro.vue";

export default {
  name: "BoxBase",
  components: { FormularioDeRegistro, Card },
  props: ["titulo_cartao", "titulo_boleto"],
  computed: {
    dados_salvos() {
      return localStorage.getItem("dados");
    },
  },
  mounted() {
    console.log(this.dados_salvos)
  }
};
</script>
