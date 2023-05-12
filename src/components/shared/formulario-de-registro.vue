<template>
  <div class="formulario-corpo" ref="formulario">
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
          <h1>MÊS REFENTE</h1>
          <select id="meses" v-model.trim="dados.mes_referente">
            <option v-for="mes in meses"
                    :key="mes.valor"
                    :selected="mes.selected"
                    :value="mes.valor">
              {{ mes.mes }}
            </option>
          </select>
        </div>
        <div class="check-tipo valor">
          <h1>VALOR A PAGAR</h1>
          <input type="text" v-model.trim="dados.valor" placeholder="DIGITE O VALOR">
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
import makeCalculatorDraggable from "@/model/draggable";
import axios from "axios"
import rotaApi from "@/controllers/rota-api";

export default {
  name: "formulario-de-registro",
  data() {
    return {
      dados: {
        tipo: "",
        valor: "",
        titulo: "",
        mes_referente: "",
      },
      dadosSalvos: [],
      valorTotal: 0,
      rota: new rotaApi().rota_api,
      meses: [
        {mes: 'JANEIRO', valor: '00', selected: "selected"},
        {mes: 'FEVEREIRO', valor: '01'},
        {mes: 'MARÇO', valor: '02'},
        {mes: 'ABRIL', valor: '03'},
        {mes: 'MAIO', valor: '04'},
        {mes: 'JUNHO', valor: '05'},
        {mes: 'JULHO', valor: '06'},
        {mes: 'AGOSTO', valor: '07'},
        {mes: 'SETEMBRO', valor: '08'},
        {mes: 'OUTUBRO', valor: '9'},
        {mes: 'NOVEMBRO', valor: '10'},
        {mes: 'DEZEMBRO', valor: '11'}
      ],
    };
  },
  computed: {
    formatoValor() {
      return new Intl.NumberFormat("pt-BR", {style: "currency", currency: "BRL"}).format(this.valorTotal);
    },
  },
  methods: {
    salvar() {
      const {titulo, valor, tipo, mes_referente} = this.dados;
      axios.post(`${this.rota}`, {
        titulo: titulo,
        valor: valor,
        tipo: tipo,
        mes_referente: mes_referente,
        email: 'jeanever39@gmail.com'
      })
          .then(response => {
            console.log(response.data.message);
            alert(response.data.message)
          })
          .catch(error => {
            console.log(error.message);
          });

      this.somarSaldo();
      this.resetDados();
    },
    somarSaldo() {
      axios.get(`${this.rota}/dados/jeanever39@gmail.com`)
          .then((querySnapshot) => {
            this.dadosSalvos = querySnapshot.data
            const valores = this.dadosSalvos.map(({valor}) => parseFloat(valor));
            const soma = valores.reduce((total, valor) => total + valor, 0);
            this.valorTotal = soma;
          })
          .catch((error) => {
            console.log("Erro ao consultar documentos: ", error);
            alert("Erro ao consultar documentos: ", error.message);
          });

    },
    resetDados() {
      this.dados.tipo = "";
      this.dados.valor = "";
      this.dados.titulo = "";
    },
    atualizar() {
      location.reload()
    }
  },
  mounted() {
    this.somarSaldo()
    makeCalculatorDraggable(this.$refs.formulario)
    this.valorTotal = parseFloat(localStorage.getItem("valorTotal")) || 0;
  },
};
</script>