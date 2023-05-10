<template>
  <div class="container-cards overflow-hidden" ref="carousel">
    <span class="prev" @click="scrollCarousel(-1)">&lt;</span>
    <div class="card" v-for="(dados, index) in dadosSalvos" :key="index" v-show="dados.tipo === 'boleto'">
      <div class="card-img">
        <img src="/images/boleto-vetor.png">
      </div>
      <div class="card-desc">
        <p class="titulo">{{ dados.titulo }}</p>
        <p class="valor">
          <img src="/images/cartoes-com-cifrao.png" width="16" alt="icone valor">
          {{ formatCurrency(dados.valor) }}
        </p>
        <div class="botoes-cards">
          <div @click="excluirDado(dados.id, dados.valor)"><img width="16" src="/images/excluir-padrao.png"></div>
          <div @click="openModal(dados)"><img width="16" src="/images/editar.png"></div>
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

export default {
  name: "cardBoleto",
  components: {ModalOpen},
  data() {
    return {
      dadosSalvos: [],
      modalData: null,
      modalOpen: false
    };
  },
  methods: {
    getDados() {
      axios.get(`http://127.0.0.1:8000/api/usuarios/dados/jeanever39@gmail.com`)
          .then((querySnapshot) => {
            console.log(querySnapshot.data)
            this.dadosSalvos = querySnapshot.data
          })
          .catch((error) => {
            console.log("Erro ao consultar documentos: ", error);
          });
    },
    getDadosSalvos() {
      const dados = this.dadosSalvos;
      console.log(dados)
      if (dados) {
        try {
          const parsedData = JSON.parse(dados);
          this.dadosSalvos = parsedData.filter(dado => dado.tipo === "boleto");
        } catch (e) {
          console.error("Erro ao parsear dados salvos:", e);
        }
      }
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

      axios.delete('http://127.0.0.1:8000/api/usuarios/deletar/' + id)
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
  mounted() {
    this.getDados();
  }
};
</script>