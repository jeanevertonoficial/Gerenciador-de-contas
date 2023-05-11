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
          <h1>VALOR A PAGAR</h1>
          <input type="text" v-model.trim="dados.valor" placeholder="DIGITE AQUI O VALOR A PAGAR">
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
import {auth} from "@/main";
import axios from "axios"

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
      return new Intl.NumberFormat("pt-BR", {style: "currency", currency: "BRL"}).format(this.valorTotal);
    },
  },
  methods: {
    salvar() {
      const {titulo, valor, tipo} = this.dados;
      const data = {titulo, valor, tipo};
      this.dadosSalvos.push(data);
      localStorage.setItem("dados", JSON.stringify(this.dadosSalvos));
      console.log(this.dadosSalvos)
      auth.onAuthStateChanged((user) => {
        this.user = user;
      });

      axios.post(`http://127.0.0.1:8000/api/usuarios`, {
        titulo: titulo,
        valor: valor,
        tipo: tipo,
        email: 'jeanever39@gmail.com'
      })
          .then(response => {
            console.log(response.data.message);
            alert(response.data.message)
          })
          .catch(error => {
            console.log(error);
          });

      if (!auth.currentUser) {
        console.error("User is not authenticated");
        alert("User is not authenticated")
        return;
      }
      this.somarSaldo();
      this.resetDados();
    },
    somarSaldo() {
      const valores = this.dadosSalvos.map(({valor}) => parseFloat(valor));
      console.log('Valores: ' + valores)
      const soma = valores.reduce((total, valor) => total + valor, 0);
      console.log('Soma:' + soma)
      this.valorTotal = soma;

      localStorage.setItem("valorTotal", this.valorTotal);
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
    makeCalculatorDraggable(this.$refs.formulario)
    this.valorTotal = parseFloat(localStorage.getItem("valorTotal")) || 0;
  },
};
</script>