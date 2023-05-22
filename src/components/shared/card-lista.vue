<template>
  <div class="selecionar-meses">
    <div class="meses">
      <label class="label-busca" for="meses">MÊS</label>
      <select id="meses" @change="buscarDados()">
        <option v-for="mes in meses"
                :key="mes.valor"
                :selected="mes.selected"
                :value="mes.valor">
          {{ mes.mes }}
        </option>
      </select>
    </div>
    <div class="selecionar-periodo">
      <div class="periodo">
        <label class="label-busca" for="periodo">SELECIONAR PERIODO</label>
        <div class="periodo-intervalo">
          <select name="periodo-inicio" id="periodo-inicio" @change="buscarDados()">
            <option v-for="periodo_id in periodo"
                    :key="periodo_id.valor"
                    :selected="periodo_id.selected"
                    :value="periodo_id.valor">
              {{ periodo_id.valor }}
            </option>
          </select>
          <p>INTERVALO</p>
          <select name="periodo-fim" id="periodo-fim">
            <option v-for="periodo_id in periodo_fim"
                    :key="periodo_id.valor"
                    :selected="periodo_id.selected"
                    :value="periodo_id.valor">
              {{ periodo_id.valor }}
            </option>
          </select>
        </div>
      </div>
    </div>
    <div class="selecionar-ano" v-show="mostrarDivAposFiltro">
      <label class="label-busca" for="valorFiltrado">BUSCAR POR VALOR</label>
      <div class="slider-container">
        <input type="range" :min="minValue" id="valorFiltrado" :max="maxValue" @change="buscarDados()" :step="stepValue"
               v-model="selectedValue" class="slider">
        <span class="slider-value">{{ selectedValue }}</span>
      </div>
    </div>
    <div class="selecionar-ano valorTotal">
      <div class="ano">
        <label class="label-busca" for="ano">ANO</label>
        <select name="ano" id="ano" @change="buscarDados()">
          <option value="2023">2023</option>
        </select>
      </div>
    </div>
    <div class="selecionar-ano">
      <div class="total">
        <label class="label-busca">VALOR TOTAL</label>
        <span class="valor-total">{{ formatCurrency(valorTotal) }}</span>
      </div>
    </div>
  </div>

  <div class="base-card-lista" v-for="(dados, index) in dadosFiltrados.sort(compararPorId)" :key="index">
    <div class="overlay">
      <div class="overlay-info">
        <label>EXLUIR</label>
        <span @click="exluirDados(dados.id)">
          <img src="/images/excluir.png">
        </span>
      </div>
    </div>
    <div class="base-img">
      <div class="base-id">
        <h1>{{ dados.id }}</h1>
      </div>
      <img :src="tipoImagem(dados)">
    </div>
    <div class="base-info">
      <div class="base-titulo">
        <div class="titulo-lista">{{ dados.titulo }}</div>
        <div class="base-valor">
          <img class="img-valor" src="/images/cartoes-com-cifrao.png">
          <p class="p-valor">Valor</p>
          <h2>{{ formatCurrency(dados.valor) }}</h2>
        </div>
      </div>
      <div class="base-titulo-info">
        <div class="data-info">{{ dados.created_at }}</div>
        <div class="titulo-info">
          <span v-if="dados.tipo === 'cartao'">
           CARTÕES DE CRÉDITOS/DÉBITOS
          </span>
          <span v-else>
           BOLETOS BANCÁRIOS
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import rotaApi from "@/controllers/rota-api";

export default {
  name: "card-lista",
  data() {
    return {
      listaDados: true,
      dadosSalvos: [],
      valorTotal: 0,
      dadosFiltrados: [],
      imagens: {
        'nubank': '/images/nu.png',
        'bb': '/images/bb.jpeg',
        'boleto': '/images/cartao-vertor.png',
        'c6': '/images/c6.jpg',
        'renner': '/images/renner.jpg',
        'caixa': '/images/caixa.png',
        'itau': '/images/itau.png',
        'cartoes': '/images/cartoes.jpeg',
      },
      imagensTipo: '/images/cartoes.jpeg',
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
      periodo: [
        {periodo: '1', valor: '1', selected: 'selected'},
        {periodo: '2', valor: '2'},
        {periodo: '3', valor: '3'},
        {periodo: '4', valor: '4'},
        {periodo: '5', valor: '5'},
        {periodo: '6', valor: '6'},
        {periodo: '7', valor: '7'},
        {periodo: '8', valor: '8'},
        {periodo: '9', valor: '9'},
        {periodo: '10', valor: '10'},
        {periodo: '11', valor: '11'},
        {periodo: '12', valor: '12'},
        {periodo: '13', valor: '13'},
        {periodo: '14', valor: '14'},
        {periodo: '15', valor: '15'},
        {periodo: '16', valor: '16'},
        {periodo: '17', valor: '17'},
        {periodo: '18', valor: '18'},
        {periodo: '19', valor: '19'},
        {periodo: '20', valor: '20'},
        {periodo: '21', valor: '21'},
        {periodo: '22', valor: '22'},
        {periodo: '23', valor: '23'},
        {periodo: '24', valor: '24'},
        {periodo: '25', valor: '25'},
        {periodo: '26', valor: '26'},
        {periodo: '27', valor: '27'},
        {periodo: '28', valor: '28'},
        {periodo: '29', valor: '29'},
        {periodo: '30', valor: '30'},
      ],
      periodo_fim: [
        {periodo: '1', valor: '1'},
        {periodo: '2', valor: '2'},
        {periodo: '3', valor: '3'},
        {periodo: '4', valor: '4'},
        {periodo: '5', valor: '5'},
        {periodo: '6', valor: '6'},
        {periodo: '7', valor: '7'},
        {periodo: '8', valor: '8'},
        {periodo: '9', valor: '9'},
        {periodo: '10', valor: '10'},
        {periodo: '11', valor: '11'},
        {periodo: '12', valor: '12'},
        {periodo: '13', valor: '13'},
        {periodo: '14', valor: '14'},
        {periodo: '15', valor: '15'},
        {periodo: '16', valor: '16'},
        {periodo: '17', valor: '17'},
        {periodo: '18', valor: '18'},
        {periodo: '19', valor: '19'},
        {periodo: '20', valor: '20'},
        {periodo: '21', valor: '21'},
        {periodo: '22', valor: '22'},
        {periodo: '23', valor: '23'},
        {periodo: '24', valor: '24'},
        {periodo: '25', valor: '25'},
        {periodo: '26', valor: '26'},
        {periodo: '27', valor: '27'},
        {periodo: '28', valor: '28'},
        {periodo: '29', valor: '29'},
        {periodo: '30', valor: '30'},
        {periodo: '31', valor: '31', selected: 'selected'},
      ],
      rota: new rotaApi().rota_api,
      minValue: 0,
      maxValue: 100,
      stepValue: 1,
      selectedValue: 50,
      items: [], // Valores vindos da API,
      mostrarDivAposFiltro: false
    }
  },
  methods: {
    formatCurrency(value) {
      return value.toLocaleString("pt-BR", {style: "currency", currency: "BRL"});
    },
    exluirDados(id) {
      axios.delete(`${this.rota}/deletar/` + id)
          .then((response) => {
            console.log(response.data.message)
            alert(response.data.message)
            this.getDados()
          })
          .catch((error) => {
            console.log(error.data.message)
            alert(error.data.message)
          })
    },
    tipoImagem(dados) {
      const chaveImagem = Object.keys(this.imagens).find(chave => dados.titulo.toLowerCase().includes(chave.toLowerCase()));
      return chaveImagem ? this.imagens[chaveImagem] : this.imagensTipo;
    },
    getDados(mes, inicio, fim, ano) {
      axios.get(`${this.rota}/dados/jeanever39@gmail.com`)
          .then((querySnapshot) => {
            this.dadosSalvos = querySnapshot.data.map(item => {
              const dataCriacao = new Date(item.created_at);
              const anoMes = dataCriacao.toLocaleDateString('pt-BR', {year: 'numeric', month: '2-digit'});
              return {...item, created_at: anoMes};
            });

            const valoresGerais = this.dadosSalvos.map(({valor}) => parseFloat(valor));
            this.minValue = Math.min(...valoresGerais);
            this.maxValue = Math.max(...valoresGerais);
            this.dadosFiltrados = this.dadosSalvos;

            if (mes != null && mes !== "" &&
                inicio != null && inicio !== "" &&
                fim != null && fim !== "" &&
                ano != null && ano !== ""
            ) {
              const dataInicio = new Date(ano, mes, inicio);
              const dataFim = new Date(ano, mes, fim);

              this.dadosFiltrados = querySnapshot.data.filter(registro => {
                const dataCriacao = new Date(registro.created_at);
                const mesReferente = registro.mes_referente;
                const texto = document.getElementById('busca_input').value
                console.log(texto)
                const textoFiltrado = texto.toLowerCase().trim();
                const textoRegistro = registro.texto.toLowerCase(); // Substitua "texto" pelo nome correto do campo que contém o texto no objeto "registro"


                return (
                    dataCriacao.getTime() >= dataInicio.getTime() &&
                    dataCriacao.getTime() <= dataFim.getTime() &&
                    parseFloat(registro.valor) >= this.selectedValue ||
                    (mesReferente === "" || mesReferente === mes) ||
                    textoRegistro.includes(textoFiltrado)
                );
              });
            } else {
              this.dadosFiltrados = querySnapshot.data
            }

            const valoresFiltrados = this.dadosFiltrados.map(({valor}) => parseFloat(valor));
            this.minValue = Math.min(this.minValue, ...valoresFiltrados);
            this.maxValue = Math.max(this.maxValue, ...valoresFiltrados);

            this.valorTotal = valoresFiltrados.reduce((total, valor) => total + valor, 0);

          })
          .catch((error) => {
            console.log("Erro ao consultar documentos: ", error);
          });
    },
    compararPorId(a, b) {
      if (a.id < b.id) {
        return -1;
      } else if (a.id > b.id) {
        return 1;
      } else {
        return 0;
      }
    },
    buscarDados() {
      const mes = document.getElementById('meses').value; // pega o valor selecionado no dropdown de meses
      const inicio = document.getElementById('periodo-inicio').value; // pega o valor selecionado no dropdown de início do período
      const fim = document.getElementById('periodo-fim').value; // pega o valor selecionado no dropdown de fim do período
      const ano = document.getElementById('ano').value; // pega o valor selecionado no dropdown de ano

      this.mostrarDivAposFiltro = true;
      this.getDados(mes, inicio, fim, ano);
    },
    handleScroll() {
      const element = document.querySelector('.selecionar-meses');
      const scrollPosition = window.scrollY || document.documentElement.scrollTop;
      const pageHeight = document.documentElement.scrollHeight - document.documentElement.clientHeight;
      const scrollPercentage = (scrollPosition / pageHeight) * 100;

      if (element) {
        element.classList.remove('selecionar-meses-scroll');
      }

      if (scrollPercentage >= 5) {
        element.classList.add('selecionar-meses-scroll');
      }

    },
    beforeDestroy() {
      window.removeEventListener('scroll', this.handleScroll);
    }
  },
  mounted() {
    // const texto = document.getElementById('busca_input').value
    console.log(texto)
    window.addEventListener('scroll', this.handleScroll);
    this.getDados()
  }
}
</script>

<style scoped>
.selecionar-meses.selecionar-meses-scroll {
  width: 70%;
  display: flex;
  align-items: center;
  justify-content: space-around;
  height: 75px;
  background: #ededed;
  border-radius: 4px;
  box-shadow: 0px 16px 20px 0px #00000054;
  position: fixed;
  z-index: 5;
  top: 61px;
}

.overlay {
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background-color: var(--COLOR-BASE-SEGUNDARIA);
  transition: all 0.5s cubic-bezier(1, -0.04, 0, .12);
  z-index: 1;
}

.overlay-info {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  position: relative;
  z-index: 1;
}

.overlay-info label {
  padding-right: 35px;
  color: white;
  font-weight: 600;
  font-size: 18px;
}

.overlay-info img {
  cursor: pointer;
}

.base-card-lista:hover .overlay {
  left: 0;
}

.base-card-lista {
  overflow: hidden;
}

::-webkit-scrollbar {
  width: 2px !important;
}

::-webkit-scrollbar-track {
  background: var(--COLOR-BASE-PRIMARIA) !important;
}

::-webkit-scrollbar-thumb {
  background: var(--COLOR-BASE-PRIMARIA) !important;
  border-radius: 10px !important;
}

::-webkit-scrollbar-thumb:hover {
  background: var(--COLOR-BASE-SEGUNDARIA) !important;
}

.selecionar-meses {
  width: 70%;
  display: flex;
  align-items: flex-start;
  justify-content: space-around;
  height: 80px;
  background: #ededed;
  border-radius: 4px;
  position: fixed;
  z-index: 1;
}

.selecionar-meses input, select {
  background: #FFFFFF;
  box-shadow: 0px -1px 7px rgba(0, 0, 0, 0.1);
  border-radius: 4px;
}

select#meses, select#ano {
  border: none;
  width: 130px;
  height: 20px;

}

select#meses, select#ano, select#periodo-fim, select#periodo-inicio {
  text-align: center;
  margin-top: 5px;
}

select#periodo-fim, select#periodo-inicio {
  border: none;
  height: 20px;
}

label.label-busca {
  font-style: normal;
  font-weight: 900;
  font-size: 12px;
  line-height: 14px;
  color: #4616AC;
  text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.15);
}

.meses, .periodo, .ano, .total {
  display: flex;
  flex-direction: column;
  align-items: center;
}

span.valor-total {
  margin-top: 5px;
  font-size: 18px;
  font-weight: bold;
  color: #424242;
}

.periodo-intervalo {
  display: flex;
  flex-direction: row;
  align-items: center;
}

.periodo-intervalo p {
  font-style: normal;
  font-weight: 300;
  font-size: 10px;
  line-height: 12px;
  color: #424242;
  margin: 0px 12px;
  margin-top: 5px;
}

.base-card-lista {
  min-width: 1019px;
  width: 100%;
  height: 160px;
  background: #FFFFFF;
  box-shadow: -10px 10px 19px rgba(0, 0, 0, 0.1);
  border-radius: 18.75px;
  margin-bottom: 30px;
  position: relative;
  top: 100px;
}

.base-img {
  box-sizing: border-box;
  width: 277px;
  height: 160px;
  background: #D7D7D7;
  box-shadow: 4px 1px 3px rgb(0 0 0 / 7%);
  border-radius: 0px 24px 24px 0px;
  float: left;
  margin: auto;
}

.base-id {
  position: relative;
  width: 160px;
  top: 60px;
  left: -58px;
  height: 42px;
  background: #9A34FF;
  box-shadow: 0px 3px 3px rgba(0, 0, 0, 0.25);
  border-radius: 0px 0px 45px 45px;
  transform: rotate(-90deg);

}

.base-id h1 {
  font-size: larger;
  width: 63px;
  position: relative;
  top: 42px;
  left: 0px;
  margin: auto;
  transform: rotate(90deg);
  color: white;
}

.base-img img {
  position: relative;
  transform: rotate(90deg);
  width: 145px;
  height: 100px;
  left: 80px;
  top: -10px;
  object-fit: cover;
  border-radius: 4px;
}

.base-info {
  width: 65%;
  display: flex;
  float: left;
  margin-left: 30px;
  align-items: center;
  justify-content: space-between;
}

.base-titulo {
  position: relative;
  top: 55px;
}

.titulo-lista {
  font-style: normal;
  font-weight: 800;
  font-size: 24px;
  line-height: 28px;
  color: #9A34FF;
  position: relative;
  top: -20px;
  text-transform: uppercase;
}

img.img-valor {
  width: 17px;
  top: -5px;
  position: relative;
}

p.p-valor {
  left: 43px;
  top: -41px;
  position: relative;
  color: blueviolet;
  font-weight: 600;
  text-transform: lowercase;
}

.base-valor h2 {
  position: relative;
  top: -7rem;
  left: 7.5rem;
  font-weight: 800;
  font-size: 40px;
  line-height: 40px;
  color: #9A34FF;
}

.base-titulo-info {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  position: relative;
  top: 20px;
}

.titulo-info {
  font-style: normal;
  font-weight: 900;
  font-size: 24px;
  line-height: 28px;
  color: #4616AC;
  position: relative;
  top: -10px;
}

.data-info {
  font-weight: 900;
  font-size: 12px;
  line-height: 14px;
  color: #424242;
  position: relative;
  top: -10px;
}

@media (max-width: 1019px) {
  .base-info {
    width: 65%;
    display: flex;
    float: left;
    justify-content: space-between;
    flex-direction: column;
    margin-top: 30px;
    align-items: center
  }
}

:root {
  --slider-min: 0;
  --slider-max: 100;
}

.slider-container {
  display: flex;
  align-items: center;
}

.slider {
  -webkit-appearance: none;
  width: 100%;
  height: 8px;
  border-radius: 3px;
  background: #ccc;
  outline: none;
  margin-top: 10px;
  margin-right: 10px;
}

.slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: var(--COLOR-BASE-PRIMARIA);
  cursor: pointer;
}

.slider::-moz-range-thumb {
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: var(--COLOR-BASE-PRIMARIA);
  cursor: pointer;
}

.slider-value {
  margin-left: 10px;
  font-size: 18px;
  font-weight: bold;
  color: var(--COLOR-VALOR-TOTAL);
}
</style>