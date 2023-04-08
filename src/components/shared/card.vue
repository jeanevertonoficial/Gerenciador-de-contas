<template>
  <div class="container-cards overflow-hidden">
    <span class="prev">&lt;</span>
    <div class="card" v-for="(dados, index) in JSON.parse(dados_salvos)" :key="index">
      <div class="card-img">
        <img src="/images/nu.png">
      </div>
      <div class="card-desc">
        <p class="titulo">{{ dados.titulo }}</p>
        <p class="valor">valor</p>
        <div class="div-preco-img">
          <img src="/images/cartoes-com-cifrao.png" alt="icone valor">
          <p class="preco"> {{ dados.valor.toLocaleString("pt-BR", { style: "currency", currency: "BRL" }) }}</p>
        </div>
      </div>
    </div>
    <span class="next">&gt;</span>
  </div>
</template>

<script>
export default {
  name: "card",
  // props: ['dados_salvos'],
  data() {
    return {
      dados_salvos: localStorage.getItem("dados"),
    };
  },
  methods: {
    btnAvancaVolta() {
      const carousel = document.querySelector(".container-cards");
      const prevBtn = document.querySelector(".prev");
      const nextBtn = document.querySelector(".next");

      let scrollPosition = 0;
      let isDown = false;
      let startX;
      let scrollLeft;

      carousel.addEventListener("mousedown", e => {
        isDown = true;
        startX = e.pageX - carousel.offsetLeft;
        scrollLeft = carousel.scrollLeft;
      });
      window.addEventListener("mouseleave", () => {
        isDown = false;
      });
      carousel.addEventListener("mouseup", () => {
        isDown = false;
      });
      carousel.addEventListener("mousemove", e => {
        if (!isDown) return;
        e.preventDefault();
        const x = e.pageX - carousel.offsetLeft;
        const walk = x - startX;
        carousel.scrollLeft = scrollLeft - walk;
      });

      prevBtn.addEventListener("click", () => {
        scrollPosition -= 300; // Defina a quantidade de pixels que deseja mover o carrossel
        carousel.scrollTo({
          top: 0,
          left: scrollPosition,
          behavior: "smooth"
        });
      });

      nextBtn.addEventListener("click", () => {
        scrollPosition += 300; // Defina a quantidade de pixels que deseja mover o carrossel
        carousel.scrollTo({
          top: 0,
          left: scrollPosition,
          behavior: "smooth"
        });
      });
    }

  },
  mounted() {
    this.btnAvancaVolta();
    this.dados_salvos = localStorage.getItem("dados");
  }
};
</script>
