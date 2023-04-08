<template>
  <div class="formulario-corpo">
    <div class="base-formulario">
      <form method="post" @submit.prevent="salvar($event)">
        <div class="check-tipo selecione">
          <h1> SELECIONE TIPO DE CADASTRO </h1>
          <div class="check-label">
            <label for="tipo-cartao" class="tipo-cartao">
              <img class="input-tipo-cartao" src="/images/cartoes-com-cifrao.png">
              Cartão
            </label>
            <label for="tipo-boleto" class="tipo-cartao">
              <img class="input-tipo-boleto" src="/images/fatura.png">
              Boleto
            </label>
          </div>
        </div>
        <div class="check-tipo titulo">
          <h1>TITULO DO CADASTRO</h1>
          <input
              type="text"
              name="titulo"
              v-model.trim="dados.titulo"
              placeholder="DIGITE AQUI O TITULO">
        </div>
        <div class="check-tipo valor">
          <h1>VALOR A PAGAR</h1>
          <input
              type="text"
              v-model.trim="dados.valor"
              name="valor"
              placeholder="R$ DIGITE AQUI O VALOR A PAGAR">
        </div>
        <input type="radio"
               v-model.trim="dados.tipo"
               value="cartao"
               name="tipo-cartao"
               id="tipo-cartao">
        <input type="radio"
               v-model.trim="dados.tipo"
               value="boleto"
               name="tipo-boleto"
               id="tipo-boleto">
        <button type="submit" class="btn-salvar">SALVAR</button>
      </form>
    </div>
    <div class="rodape-formulario">
      <p class="titulo-valor">valor total</p>
      <div class="preco-total">
        <img src="/images/total-dolar.png">
        <span class="preco-total">{{ this.valor_total  }}</span>
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
        titulo: ""
      },
      valor_total: [],
      dados_salvos: []
    }
  },
  methods: {
    salvar() {
      const { titulo, valor, tipo } = this.dados
      const data = { titulo, valor, tipo }

      this.dados_salvos.push(data)
      localStorage.setItem("dados", JSON.stringify(this.dados_salvos))
      this.somarSaldo()
      this.resetDados()
    },
    converterValor(valor) {
     this.valor_total = valor.toLocaleString("pt-BR", { style: "currency", currency: "BRL" })
    },
    somarSaldo() {
      this.valor_total = this.dados_salvos.reduce((total, { valor }) => total + parseFloat(valor), 0)
      this.converterValor(this.valor_total)
      localStorage.setItem('valor_total', this.valor_total)
    },

    resetDados() {
      this.dados = {
        tipo: "",
        valor: "",
        titulo: ""
      }
    }
  },
  mounted() {
    this.valor_total = localStorage.getItem('valor_total')
  }
}
</script>