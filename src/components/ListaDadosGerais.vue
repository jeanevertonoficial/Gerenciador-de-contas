<template>
  <div class="container-header">
    <header-dashboard :titulo_centro="titulo_central" :listaDados="listaDados" @texto-atualizado="atualizarTexto" @palavra-chave="salvarPalavraChave"/>
  </div>
  <div class="container-main">
    <card-lista :texto="texto" :historico-busca="historicoBusca"/>
  </div>
</template>

<script>
import HeaderDashboard from "@/components/shared/headerDashboard.vue";
import CardLista from "@/components/shared/card-lista";

export default {
  name: "ListaDadosGerais",
  components: {CardLista, HeaderDashboard},
  data() {
    return {
      titulo_central: "VIVA SEMPRE ORGANIZADO",
      titulo_cartao: "CARTÕES DE CRÉDITOS",
      titulo_boleto: "BOLETOS BANCÁRIOS",
      listaDados: "listaDados",
      texto: "",
      historicoBusca: "",
    }
  },
  methods: {
    atualizarTexto(novoTexto) {
      this.texto = novoTexto;
    },
    salvarPalavraChave(novoTexto) {
      this.historicoBusca = novoTexto;
    },
  }
};
</script>
<style scoped>
.container-main {
  display: block;
  margin: auto;
  width: 70%;
  height: 75%;
  position: relative;
}
</style>
