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
                 @click="clique($event)"
                 v-model.trim="dados.tipo"
                 value="cartao"
                 name="tipo-cartao"
                 id="tipo-cartao">
          <input type="radio"
                 v-model.trim="dados.tipo"
                 @click="clique($event)"
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
        <span class="preco-total">{{ valor_total }}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "formulario-de-registro",
  data () {
    return {
      dados: {
        tipo: "",
        valor: "",
        titulo: ""
      },
      valor_total: 0,
      dados_salvos: []
    }
  },
  methods: {
    clique(e) {
      console.log("Foi clicado em ", e.target.name);
    },
    salvar(e) {
      e.preventDefault()

      const data = {
        titulo: this.dados.titulo,
        valor: this.dados.valor,
        tipo: this.dados.tipo
      }

      this.dados_salvos.push(data)
      localStorage.setItem( "dados" , JSON.stringify(this.dados_salvos))
      console.log(data.valor)
      this.somarSaldo(data.valor)

      this.dados.tipo = ""
      this.dados.valor = ""
      this.dados.titulo = ""
    },
    somarSaldo(valor){
      this.valor_total = this.valor_total + valor;

      let total = 0;
      for (let i = 0; i < this.dados_salvos.length; i++) {
        total += this.dados_salvos[i].valor;
      }
      this.valor_total = total;
    }
  },
  mounted() {
    this.somarSaldo();
  }
};
</script>

<style scoped>
.formulario-corpo {
  position: absolute;
  width: 320px;
  height: 441.62px;
  left: 805px;
  top: 189px;

  background: var(--COLOR-BASE-SEGUNDARIA);
  box-shadow: 0px 3.45013px 3.45013px rgba(0, 0, 0, 0.25);
  border-radius: 21.5633px;
}

.check-tipo h1 {
  text-align: center;
  margin-bottom: 15px;
  font-style: normal;
  font-weight: 900;
  font-size: 15.5256px;
  line-height: 18px;

  color: var(--COLOR-BASE-TEXTO);
}

input[type="radio"]:checked + label {
  background: var(--COLOR-BASE-PRIMARIA);
  /*background-color: green;*/
  color: white;
}

label {
  cursor: pointer;
}
label:active {
  color: var(--COLOR-BASE-TEXTO);
  background: var(--COLOR-BASE-PRIMARIA);
}
.check-tipo {
  display: flex;
  justify-content: center;
  flex-direction: column;
}

.base-formulario {
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  align-items: center;
  width: 90%;
  margin: auto;
  padding: 15px;
}

.check-label {
  display: flex;
  flex-direction: row;
  width: 100%;
  justify-content: space-around;
}

input[type="radio"] {
  opacity: 0;
}

.tipo-cartao {
  width: 97.47px;
  height: 28.46px;
  background: var(--COLOR-BASE-BTN-FORM);
  box-shadow: 0px 3.45013px 3.45013px rgba(0, 0, 0, 0.25);
  border-radius: 21.5633px;
  font-weight: 900;
  font-size: 12.0755px;
  display: flex;
  line-height: 14px;
  text-transform: uppercase;
  color: var(--COLOR-BASE-PRIMARIA);
  align-items: center;
  justify-content: space-evenly;
}

.tipo-cartao img {
  height: 13px;
}

.rodape-formulario {
  position: absolute;
  width: 320px;
  height: 53.48px;
  top: 390px;
  display: flex;
  background: var(--COLOR-BASE-TEXTO);
  border-radius: 0px 0px 21.5633px 21.5633px;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.titulo-valor {
  margin: 0px;
  font-weight: 900;
  font-size: 12px;
  line-height: 12px;
  text-transform: uppercase;
  color: var(--COLOR-BASE-PRIMARIA);
}

.preco-total {
  font-weight: 900;
  font-size: 29.3261px;
  line-height: 34px;
  margin-left: 15px;
  text-transform: uppercase;
  color: var(--COLOR-VALOR-TOTAL);
}

.preco-total img {
  margin-left: -35px;
}

.check-tipo input {
  width: 228.57px;
  height: 27.6px;
  background: var(--COLOR-BASE-TEXTO);
  box-shadow: 0px 3.45013px 3.45013px rgba(0, 0, 0, 0.25);
  border-radius: 21.5633px;
  margin: auto;
  text-align: center;
  border: none;

  text-transform: uppercase;
  font-weight: 700;
  font-size: 8.62534px;
  line-height: 10px;
}
.btn-salvar {
  width: 169.06px;
  height: 45.71px;
  background: var(--COLOR-BASE-PRIMARIA);
  box-shadow: 0px 3.45013px 6.03774px rgba(0, 0, 0, 0.25);
  border-radius: 21.5633px;
  border: none;
  font-weight: 900;
  font-size: 20.7008px;
  margin: auto;
  display: flex;
  line-height: 24px;
  color: var(--COLOR-BASE-TEXTO);
  align-items: center;
  justify-content: center;
  transition: 0.5s;
  cursor: pointer;
}

.btn-salvar:hover {
  transition: 0.5s;
  background: #b6b5b9;
}
.btn-salvar:active {
  background: var(--COLOR-BASE-PRIMARIA);
}
.valor, .titulo, .selecione {
  margin-top: 15px;
}
</style>