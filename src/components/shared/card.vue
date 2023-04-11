<template>
  <div class="container-cards overflow-hidden" ref="carousel">
    <span class="prev" @click="scrollCarousel(-1)">&lt;</span>
    <div class="card" v-for="(dados, index) in dadosSalvos" :key="index">
      <div class="card-img">
        <img src="/images/nu.png">
      </div>
      <div class="card-desc" @click="openModal(dados)">
        <p class="titulo">{{ dados.titulo }}</p>
        <p class="valor">
          <img src="/images/cartoes-com-cifrao.png" alt="icone valor">
          {{ formatCurrency(dados.valor) }}
        </p>
      </div>
    </div>
    <span class="next" @click="scrollCarousel(1)">&gt;</span>
    <modal-open v-if="modalData" :valor="modalData.valor" :titulo="modalData.titulo" :abrir-mode="modalOpen" @close="closeModal" @save="saveModalData" />
  </div>
</template>
<script>
import ModalOpen from "@/components/shared/modalOpen.vue";

export default {
  name: "card",
  components: { ModalOpen },
  data() {
    return {
      dadosSalvos: [],
      modalData: null,
      modalOpen: false
    };
  },
  methods: {
    getDadosSalvos() {
      const dados = localStorage.getItem("dados");
      if (dados) {
        try {
          this.dadosSalvos = JSON.parse(dados);
        } catch (e) {
          console.error("Erro ao parsear dados salvos:", e);
        }
      }
    },
    formatCurrency(value) {
      return value.toLocaleString("pt-BR", { style: "currency", currency: "BRL" });
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
        this.dadosSalvos[modalDataIndex] = { titulo: this.modalData.titulo, valor: this.modalData.valor };
        localStorage.setItem("dados", JSON.stringify(this.dadosSalvos));
      }
      this.modalOpen = false;
    }
  },
  mounted() {
    this.getDadosSalvos();
  }
};
</script>