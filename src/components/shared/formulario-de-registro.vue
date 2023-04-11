<template>
  <div class="formulario-corpo">
    <div class="base-formulario">
      <form @submit.prevent="salvar">
        <div class="check-tipo selecione">
          <h1> SELECIONE TIPO DE CADASTRO </h1>
          <div class="check-label">
            <label for="tipo-cartao" class="tipo-cartao">
              <img class="input-tipo-cartao" src="/images/cartoes-com-cifrao.png">
              Cartão
              <input type="radio" v-model.trim="dados.tipo" value="cartao" id="tipo-cartao">
            </label>
            <label for="tipo-boleto" class="tipo-cartao">
              <img class="input-tipo-boleto" src="/images/fatura.png">
              Boleto
              <input type="radio" v-model.trim="dados.tipo" value="boleto" id="tipo-boleto">
            </label>
          </div>
        </div>
        <div class="check-tipo titulo">
          <h1>TITULO DO CADASTRO</h1>
          <input type="text" v-model.trim="dados.titulo" placeholder="DIGITE AQUI O TITULO">
        </div>
        <div class="check-tipo valor">
          <h1>VALOR A PAGAR</h1>
          <input type="text" v-model.trim="dados.valor" placeholder="R$ DIGITE AQUI O VALOR A PAGAR">
        </div>
        <button type="submit" class="btn-salvar">SALVAR</button>
      </form>
    </div>
    <div class="rodape-formulario">
      <p class="titulo-valor">valor total</p>
      <div class="preco-total">
        <img src="/images/total-dolar.png">
        <span class="preco-total">{{ formatoValor }}</span>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "formulario-de-registro",
  data() {
    return {
      dados: {
        tipo: "",
        valor: "",
        titulo: "",
      },
      dadosSalvos: [],
      valorTotal: 0,
    };
  },
  computed: {
    formatoValor() {
      return new Intl.NumberFormat("pt-BR", { style: "currency", currency: "BRL" }).format(this.valorTotal);
    },
  },
  methods: {
    salvar() {
      const { titulo, valor, tipo } = this.dados;
      const data = { titulo, valor, tipo };
      this.dadosSalvos.push(data);
      localStorage.setItem("dados", JSON.stringify(this.dadosSalvos));
      this.somarSaldo();
      this.resetDados();
    },
    somarSaldo() {
      this.valorTotal = this.dadosSalvos.reduce((total, { valor }) => total + parseFloat(valor), 0);
      localStorage.setItem("valorTotal", this.valorTotal);
    },
    resetDados() {
      this.dados.tipo = "";
      this.dados.valor = "";
      this.dados.titulo = "";
    },
  },
  mounted() {
    this.dadosSalvos = JSON.parse(localStorage.getItem("dados")) || [];
    this.valorTotal = parseFloat(localStorage.getItem("valorTotal")) || 0;
  },
};
</script>