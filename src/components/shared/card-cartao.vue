<template>
  <div class="container-cards overflow-hidden" ref="carousel">
    <span class="prev" @click="scrollCarousel(-1)">&lt;</span>
    <div class="card" v-for="(dados, index) in dadosSalvos" :key="index" v-show="dados.tipo === 'cartao'">
      <div class="card-img">
        <img :src="tipoImagem(dados)">
      </div>
      <div class="card-desc">
        <p class="titulo">{{ dados.titulo }}</p>
        <p class="valor">
          <img src="/images/cartoes-com-cifrao.png" width="16" alt="icone valor">
          {{ formatCurrency(dados.valor) }}
        </p>
        <div class="overlay">
          <div class="botoes-cards">
            <div @click="excluirDado(dados.id, dados.valor)">
              <img class="btn-excluir" width="16" src="/images/excluir.png" title="excluir">
            </div>
            <div class="btn-editar" @click="openModal(dados)">
              <img width="16" src="/images/editar-branco.png" title="editar informação">
            </div>
          </div>
        </div>
      </div>
    </div>
    <span class="next" @click="scrollCarousel(1)">&gt;</span>
    <modal-open v-if="modalData" :valor="modalData.valor" :titulo="modalData.titulo" :abrir-mode="modalOpen"
                @close="closeModal" @save="saveModalData"/>
  </div>
</template>
<script>
import ModalOpen from "@/components/shared/modalOpen.vue";
import axios from "axios";
import rotaApi from "@/controllers/rota-api";

export default {
  name: "cardCartao",
  components: {ModalOpen},
  data() {
    return {
      user: null,
      dadosSalvos: [],
      modalData: null,
      modalOpen: false,
      imagens: {
        'nubank': '/images/nu.png',
        'bb': '/images/bb.jpeg',
        'boleto': '/images/boleto.png',
        'c6': '/images/c6.jpg',
        'renner': '/images/renner.jpg',
        'caixa': '/images/caixa.png',
        'itau': '/images/itau.png',
        'cartoes': '/images/cartoes.jpeg',
      },
      imagensTipo: '/images/cartoes.jpeg',
      rota: new rotaApi().rota_api
    };
  },
  methods: {
    getDados() {
      axios.get(`${this.rota}/dados/jeanever39@gmail.com`)
          .then((querySnapshot) => {
            console.log(querySnapshot.data)
            this.dadosSalvos = querySnapshot.data
          })
          .catch((error) => {
            console.log("Erro ao consultar documentos: ", error.message);
          });
    },
    tipoImagem(dados) {
      const chaveImagem = Object.keys(this.imagens).find(chave => dados.titulo.toLowerCase().includes(chave.toLowerCase()));
      return chaveImagem ? this.imagens[chaveImagem] : this.imagensTipo;
    },
    formatCurrency(value) {
      return value.toLocaleString("pt-BR", {style: "currency", currency: "BRL"});
    },
    scrollCarousel(direction) {
      const carousel = this.$refs.carousel;
      const scrollStep = 300; // Defina a quantidade de pixels que deseja mover o carrossel
      carousel.scrollBy({
        top: 0,
        left: scrollStep * direction,
        behavior: "smooth"
      });
    },
    excluirDado(id, valor) {
      const valorTot = localStorage.getItem('valorTotal')
      const valoratotalAtt = valorTot - valor

      localStorage.setItem('valorTotal', valoratotalAtt)
      this.dadosSalvos.splice(id, 1);
      localStorage.setItem("dados", JSON.stringify(this.dadosSalvos));

      axios.delete(`${this.rota}/deletar/` + id)
          .then((response) => {
            console.log(response.data.message)
            alert(response.data.message)
          })
          .catch((error) => {
            console.log(error.data.message)
          })
    },
    openModal(dados) {
      this.modalData = dados;
      this.modalOpen = true;
    },
    closeModal() {
      this.modalOpen = !this.modalOpen;
      this.modalData = null;
    },
    saveModalData() {
      const modalDataIndex = this.dadosSalvos.findIndex(dados => dados.titulo === this.modalData.titulo && dados.valor === this.modalData.valor);
      if (modalDataIndex !== -1) {
        this.dadosSalvos[modalDataIndex] = {titulo: this.modalData.titulo, valor: this.modalData.valor};
        localStorage.setItem("dados", JSON.stringify(this.dadosSalvos));
      }
      this.modalOpen = false;
    },
    atualizar() {
      location.reload()
    }
  },
  mounted() {
    this.getDados();
  },
};
</script>
<style scoped>
.card-img {
  display: flex;
  transform: rotate(90deg);
  width: 85px;
  align-items: center;
  position: relative;
  left: 20px;
  top: 5px;
}

.overlay {
  position: absolute;
  top: 100%;
  bottom: 100%;
  width: 100%;
  height: 100%;
  background-color: #a929ffed;
  transition: all 0.3s ease;
  z-index: 1;
}

.card{
  overflow: hidden;
}

.card:hover .overlay {
  top: 0;
}
</style>