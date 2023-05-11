<template>
  <div class="container-header">
    <header-dashboard  :titulo_centro="titulo_central"/>
  </div>
  <div class="container-main">
    <card-lista/>
  </div>
</template>

<script>
import HeaderDashboard from "@/components/shared/headerDashboard.vue";
import CardLista from "@/components/shared/card-lista";

export default {
  name: "ListaDadosGerais",
  components: {CardLista, HeaderDashboard },
  data () {
    return {
      titulo_central: "VIVA SEMPRE ORGANIZADO",
      titulo_cartao: "CARTÕES DE CRÉDITOS",
      titulo_boleto: "BOLETOS BANCÁRIOS"
    }
  }
};
</script>
