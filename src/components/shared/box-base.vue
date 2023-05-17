<template>
  <div class="boxs">
    <div class="box-base cartoes" ref="box_cartao">
      <div class="box-base-titulo">
        <div class="titulo_base">
          {{ titulo_cartao }}
        </div>
        <CardCartao :dadosSalvos="dadosGerais" />
      </div>
    </div>
    <div class="box-base boletos" ref="box_boleto">
      <div class="box-base-titulo">
        <div class="titulo_base">
          {{ titulo_boleto }}
        </div>
        <CardBoleto :dadosSalvos="dadosGerais" />
      </div>
    </div>
    <FormularioDeRegistro :dadosSalvos="dadosGerais" />
  </div>
</template>

<script>
import CardBoleto from "@/components/shared/card-boleto";
import CardCartao from "@/components/shared/card-cartao";
import FormularioDeRegistro from "@/components/shared/formulario-de-registro.vue";
import makeCalculatorDraggable from "@/model/draggable";

export default {
  name: "BoxBase",
  components: { FormularioDeRegistro, CardBoleto, CardCartao },
  props: ["titulo_cartao", "titulo_boleto", "dadosGerais"],
  mounted() {
    makeCalculatorDraggable(this.$refs.box_cartao)
    makeCalculatorDraggable(this.$refs.box_boleto)
  }
};
</script>
