<template>
  <div class="container-cards overflow-hidden" ref="carousel">
    <span class="prev" @click="scrollCarousel(-1)">&lt;</span>
    <div class="card" v-for="(dados, index) in dadosSalvos" :key="index" v-show="dados.tipo === 'boleto'">
      <div class="card-img">
        <img src="/images/cartao-vertor.png">
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
import {auth} from "@/main";
import axios from "axios";
import rotaApi from "@/controllers/rota-api";

export default {
  name: "cardBoleto",
  components: {ModalOpen},
  props:['dadosSalvos'],
  data() {
    return {
      modalData: null,
      modalOpen: false,
      rota: new rotaApi().rota_api
    };
  },
  methods: {
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
          .catch((error) => { console.log(error.data.message)
          })

      // this.atualizar();
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
};
</script>
<style scoped>
.card-img {
  display: flex;
  justify-content: center;
  align-items: center;
  background: #FFFFFF;
  border: 1px solid #E9E9E9;
  box-shadow: 2px -6px 20px 0px rgb(0 0 0 / 10%);
  border-radius: 10px 10px 0px 0px;
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