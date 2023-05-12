<template>
  <div class="messege-container" :style="btnFecha" :class="estiloDaMensagem" role="alert">
    <p>{{ msg }}</p>
    <button class="btn-fecha" :style="btnFecha" @click="fecha">x</button>
  </div>
</template>

<script>

export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: "notificacoes-alert",
  props: {
    msg: String,
    estilo: {
      required: false,
      default: 'sucesso',
      type: String
    }
  },
  data() {
    return {
      btnFecha: ''
    }
  },
  methods: {fecha() { return this.btnFecha = 'opacity: 0'; }},
  computed: {
    estiloDaMensagem: function () {
      let estiloDaMensagem;
      if (this.estilo == 'sucesso' || !this.estilo) {
        estiloDaMensagem = 'success';
      } else if (this.estilo == 'erro') {
        estiloDaMensagem = 'danger';
      }
      return estiloDaMensagem;
    }
  }
}
</script>

<style scoped>

.messege-container {
  z-index: 15;
  margin: auto;
  position: absolute;
  border-radius: 5px;
  width: 100%;
  padding: 15px;
  text-align: center;
  animation: mymove;
  animation-duration: 0.7s;
  transition: linear 0.7s;
  display: flex;
  justify-content: space-between;
}

.btn-fecha {
  font-weight: bold;
  background-color: transparent;
  border: none;
  cursor: pointer;
}
@keyframes mymove {
  from {
    top: 0px;
    opacity: 0;
  }
  to {
    opacity:1;
    top: 10px;
  }
}

@media (max-width: 551px) {
  p {
    width: 80%;
  }
  .btn-fecha {
    font-size: 1.5rem;
    cursor: pointer;
  }
  @keyframes mymove {
    from {
      top: 0px;
      opacity: 0;
    }
    to {
      opacity:1;
      top: 20px;
    }
  }
}

p {
  margin: inherit;
  padding: 0;
}

.sucesso {
  background: #d3ecd9;
  color: #025402;
}

.erro {
  background: #f7d6d9;
  color: rgb(112, 9, 9);
}

</style>