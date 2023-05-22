<template>
  <div class="container-header">
    <header-dashboard  :titulo_centro="titulo_central" :listaDados="listaDados"/>
  </div>
  <div class="container-main">
    <calculadora/>
    <box-base :dadosGerais="dadosGerais" :titulo_cartao="titulo_cartao" :titulo_boleto="titulo_boleto"/>
  </div>
</template>

<script>
import HeaderDashboard from "@/components/shared/headerDashboard.vue";
import BoxBase from "@/components/shared/box-base.vue";
import Calculadora from "@/components/shared/calculadora.vue";
import axios from "axios";
import rotaApi from "@/controllers/rota-api";

export default {
  name: "DashboardGerencial",
  components: { Calculadora, BoxBase, HeaderDashboard },
  data () {
    return {
      titulo_central: "VIVA SEMPRE ORGANIZADO",
      titulo_cartao: "CARTÕES DE CRÉDITOS",
      titulo_boleto: "BOLETOS BANCÁRIOS",
      dadosGerais: [],
      listaDados: false,
      rota: new rotaApi().rota_api,
    }
  },
  methods: {
    getDados() {
      axios.get(`${this.rota}/dados/jeanever39@gmail.com`)
          .then((querySnapshot) => {
            this.dadosGerais = querySnapshot.data
          })
          .catch((error) => {
            console.log("Erro ao consultar documentos: ", error.message);
          });
    },
  },
  created() {
    this.getDados()
  }
};
</script>
