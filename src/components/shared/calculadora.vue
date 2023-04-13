<template>
  <div class="botao_canto" @click="abrir_calculadora" ref="abrir_calculadora">{{ openCalculadora.txt_calculadora }}
  </div>
  <div v-if="openCalculadora.value" class="calculadora" ref="calculator">
    <input type="text" v-model="display" class="visor" placeholder="0.0" @change="calculate">
    <div class="base-numero">
      <button v-for="button in buttons"
              :key="button.label"
              @click="handleButtonClick(button)"
              :class="button.class">
        {{ button.label }}
      </button>
    </div>
    <div class="ver-historico" v-if="this.ocultar == false && this.history !=''" @click="ocultarHistorico">abrir
      hitórico
    </div>
    <div class="historico-calculadora" v-if="this.history != '' && ocultar">
      <h3>Histórico: <span @click="ocultarHistorico">ocultar</span></h3>
      <ul>
        <li v-for="(calculation, index) in history.slice().reverse()" :key="index">{{ calculation }}</li>
      </ul>
      <div class="base-btn-limpar">
        <button class="btn-salvar btn-limpar" @click="clearHistory">Limpar</button>
      </div>
    </div>
  </div>
</template>

<script>
import makeCalculatorDraggable from "@/model/draggable";

export default {
  name: "calculadora",
  data() {
    return {
      display: "",
      ocultar: true,
      openCalculadora: {
        value: false,
        txt_calculadora: "Calculadora"
      },
      buttons: [
        { label: "+", value: "+", class: "operador" },
        { label: "-", value: "-", class: "operador" },
        { label: "*", value: "*", class: "operador" },
        { label: "/", value: "/", class: "operador" },
        { label: "7", value: "7", class: "numero" },
        { label: "8", value: "8", class: "numero" },
        { label: "9", value: "9", class: "numero" },
        { label: "4", value: "4", class: "numero" },
        { label: "5", value: "5", class: "numero" },
        { label: "6", value: "6", class: "numero" },
        { label: "1", value: "1", class: "numero" },
        { label: "2", value: "2", class: "numero" },
        { label: "3", value: "3", class: "numero" },
        { label: "0", value: "0", class: "numero" },
        { label: ".", value: ".", class: "numero" },
        { label: "C", value: "clear", class: "limpa" },
        { label: "=", value: "equal", class: "igual" }
      ],
      history: []
    };
  },
  mounted() {
    makeCalculatorDraggable(this.$refs.abrir_calculadora);
    this.history = JSON.parse(localStorage.getItem("historico_calculo"));
  },
  methods: {
    handleButtonClick(button) {
      switch (button.value) {
        case "clear":
          this.clear();
          break;
        case "equal":
          this.calculate();
          break;
        case "+":
        case "-":
        case "*":
        case "/":
          this.handleOperation(button.value);
          break;
        default:
          this.display += button.value;
          break;
      }
    },
    calculate() {
      let result = eval(this.display);
      if (result != undefined) {
        this.history.push(this.display + " = " + result);
        this.display = result.toString();
        localStorage.setItem("historico_calculo", JSON.stringify(this.history));
      } else {
        return false;
      }
    },
    handleOperation(operation) {
      let lastIndex = this.display.length - 1;
      let lastChar = this.display.charAt(lastIndex);
      if (lastChar === "+" || lastChar === "-" || lastChar === "*" || lastChar === "/") {
        this.display = this.display.slice(0, lastIndex) + operation;
      } else {
        this.display += operation;
      }
    },
    clear() {
      this.display = "";
    },
    clearHistory() {
      this.history = [];
      localStorage.removeItem("historico_calculo");
    },
    ocultarHistorico() {
      this.ocultar = !this.ocultar;
    },
    abrir_calculadora() {
      this.openCalculadora.value = !this.openCalculadora.value;
    }
  }
};
</script>


<style scoped>
.botao_canto {
  cursor: pointer;
  left: -34px;
  background: var(--COLOR-BASE-PRIMARIA);
  top: 180px;
  transform: rotate(90deg) !important;
  transition: 0.7s;
  position: fixed;
  display: flex;
  color: white;
  padding: 5px;
  border-radius: 5px 5px 0 0;
  flex-direction: column;
}

.botao_canto:hover {
  transition: 0.5s;
  background: var(--COLOR-BASE-SEGUNDARIA);
}

h3 {
  color: var(--COLOR-BASE-PRIMARIA);
  display: flex;
  justify-content: space-between;
  max-width: 308px;
  width: 308px;
  height: 50px;
  background: #f2f2f2;
  position: fixed;
  margin-top: -10px;
  align-items: center;
}

h3 > span {
  color: var(--COLOR-BASE-TEXTO);
  background: var(--COLOR-BASE-PRIMARIA);
  font-size: 12px;
  padding: 5px;
  cursor: pointer;
  border-radius: 12px;
}

ul {
  padding: initial;
  margin-top: 50px;
}

li {
  display: flex;
  font-weight: 700;
  font-size: 1.5rem;
}

.historico-calculadora {
  top: 0;
  right: -170px;
  width: auto;
  height: auto;
  max-height: 300px;
  display: flex;
  padding: 10px;
  background-color: #f2f2f2;
  overflow-y: scroll;
  text-align: right;
  z-index: 1;
  flex-direction: column;
  margin-top: 36px;
  align-items: flex-start;
}

input.visor {
  width: 95%;
  border: none;
  height: 60px;
  border-radius: 15px 15px 0 0;
  font-size: 2rem;
  padding-left: 15px;
}

input:focus {
  outline: none;
}

button[type='button']:checked {
  background: var(--COLOR-VALOR-TOTAL);
}

.calculadora {
  cursor: grab;
  position: absolute;
  width: 100%;
  max-width: 320px;
  height: 485.62px;
  left: 2%;
  z-index: 5;
  top: 16%;
  background: var(--COLOR-BASE-SEGUNDARIA);
  box-shadow: 5px 8px 16px rgba(0, 0, 0, 0.25);
  border-radius: 21.5633px;
}

.calculadora:active {
  cursor: grabbing;
}

button.operador, button.limpa, button.igual {
  display: inline-grid;
  width: 69px;
  height: 50px;
  justify-content: center;
  color: var(--COLOR-BASE-TEXTO);
  font-size: 1.5rem;
  background: var(--COLOR-BASE-PRIMARIA);
  border: none;
  margin-left: 3px;
  margin-bottom: 10px;
  align-items: center;
}

.base-numero {
  padding: 15px;
  height: 320px;
  width: 90%;
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-start;
  align-items: center;
}

button {
  cursor: pointer;
}

button.numero {
  display: inline-grid;
  align-items: center;
  width: 69px;
  height: 50px;
  font-size: 1rem;
  margin: 2px;
  margin-left: 16px;
  border: none;
}

button.limpa, button.igual {
  margin-top: 10px;
  width: 69px !important;
  margin-left: 17px;
}

.ver-historico {
  background: var(--COLOR-BASE-TEXTO);
  color: var(--COLOR-VALOR-TOTAL);
  text-align: center;
  padding: 15px;
  border-radius: 0 0 20px 20px;
  font-weight: 700;
  text-transform: uppercase;
  margin-top: 35px;
}

.base-btn-limpar {
  position: absolute;
  width: 100%;
  top: 45rem;
  left: -1px;
  background: #f2f2f2;
}
</style>
