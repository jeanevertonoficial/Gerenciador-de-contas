<template>
  <div class="container-cards overflow-hidden" ref="carousel">
    <span class="prev" @click="scrollCarousel(-1)">&lt;</span>
    <div class="card" v-for="(dados, index) in dadosSalvos" :key="index">
      <div class="card-img">
        <img :src="tipoImagem(dados)">
      </div>
      <div class="card-desc">
        <p class="titulo">{{ dados.titulo }}</p>
        <p class="valor">
          <img src="/images/cartoes-com-cifrao.png" width="16" alt="icone valor">
          {{ formatCurrency(dados.valor) }}
        </p>
        <div class="botoes-cards">
          <div @click="excluirDado(index, dados.valor)"><img width="16" src="/images/excluir-padrao.png"></div>
          <div @click="openModal(dados)"><img width="16" src="/images/editar.png"></div>
        </div>
      </div>
    </div>
    <span class="next" @click="scrollCarousel(1)">&gt;</span>
    <modal-open v-if="modalData" :valor="modalData.valor" :titulo="modalData.titulo" :abrir-mode="modalOpen"
                @close="closeModal" @save="saveModalData" />
  </div>
</template>
<script>
import ModalOpen from "@/components/shared/modalOpen.vue";

export default {
  name: "cardCartao",
  components: { ModalOpen },
  data() {
    return {
      dadosSalvos: [],
      modalData: null,
      modalOpen: false,
      imagens: {
        'nubank':'/images/nu.png',
        'bb':'/images/bb.jpeg',
        'boleto':'/images/boleto.png',
        'c6':'/images/c6.jpg',
        'renner':'/images/renner.jpg',
        'caixa':'/images/caixa.png',
        'itau':'/images/itau.png',
        'cartoes':'/images/cartoes.jpeg',
      },
      imagensTipo: '/images/cartoes.jpeg',
    };
  },
  methods: {
    tipoImagem(dados) {
      const chaveImagem = Object.keys(this.imagens).find(chave => dados.titulo.toLowerCase().includes(chave.toLowerCase()));
      return chaveImagem ? this.imagens[chaveImagem] : this.imagensTipo;
    },
    getDadosSalvos() {
      const dados = localStorage.getItem("dados");
      if (dados) {
        try {
          const parsedData = JSON.parse(dados);
          this.dadosSalvos = parsedData.filter(dado => dado.tipo === "cartao");
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
    excluirDado(index, valor) {
      const valorTot = localStorage.getItem('valorTotal')
      const valoratotalAtt = valorTot - valor

      localStorage.setItem('valorTotal', valoratotalAtt)
      this.dadosSalvos.splice(index, 1);
      localStorage.setItem("dados", JSON.stringify(this.dadosSalvos));
      this.atualizar();
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
    },
    atualizar() {
      location.reload()
    }
  },
  mounted() {
    this.getDadosSalvos();
  }
};
</script>