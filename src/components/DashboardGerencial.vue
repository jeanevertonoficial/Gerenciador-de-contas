<template>
  <div class="container-header">
    <header-dashboard  :titulo_centro="titulo_central"/>
  </div>
  <div class="container-main">
    <calculadora/>
    <box-base :titulo_cartao="titulo_cartao" :titulo_boleto="titulo_boleto"/>
  </div>
</template>

<script>
import HeaderDashboard from "@/components/shared/headerDashboard.vue";
import BoxBase from "@/components/shared/box-base.vue";
import FormularioDeRegistro from "@/components/shared/formulario-de-registro.vue";
import Calculadora from "@/components/shared/calculadora.vue";

export default {
  name: "DashboardGerencial",
  components: { Calculadora, BoxBase, HeaderDashboard },
  data () {
    return {
      titulo_central: "VIVA SEMPRE ORGANIZADO",
      titulo_cartao: "CARTÕES DE CRÉDITOS/DÉBITOS",
      titulo_boleto: "BOLETOS BANCÁRIOS"
    }
  }
};
</script>
