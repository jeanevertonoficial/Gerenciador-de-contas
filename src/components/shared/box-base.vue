<template>
  <div class="boxs">
    <div class="box-base cartoes" ref="box_cartao">
      <div class="box-base-titulo">
        <div class="titulo_base">
          {{ titulo_cartao }}
        </div>
        <Card />
      </div>
    </div>
    <div class="box-base boletos" ref="box_boleto">
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
import makeCalculatorDraggable from "@/model/draggable";

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
    makeCalculatorDraggable(this.$refs.box_cartao)
    makeCalculatorDraggable(this.$refs.box_boleto)
  }
};
</script>
