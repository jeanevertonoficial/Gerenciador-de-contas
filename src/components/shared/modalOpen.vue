<template>
  <div class="container-modal">
    <div class="modal">
      <button class="btn-modal-fecha" @click="abrirMode = false">X</button>
      <div class="corpo-modal">
        <form method="post">
          <div class="check-tipo input">
            <label for="titulo_card">
              <h1>Editar Titulo</h1>
            </label>
            <input type="text" name="titulo_card" id="titulo_card" :placeholder="titulo" :value="titulo">
          </div>
          <div class="check-tipo valor">
            <label for="preco_card">
              <h1>Editar Preço</h1>
            </label>
            <input type="text" name="preco_card" id="preco_card" :placeholder="valor" :value="valor">
          </div>
          <button class="btn-salvar" type="submit" @click.prevent="salvar">SALVAR</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "modalOpen",
  props: ["valor", "titulo", "abrirMode"],
  data() {
    return {

    };
  },
  methods: {
    salvar() {
      this.abrirMode == false;
      console.log(this.abrirMode);
    }
  }
};
</script>

<style scoped>
.btn-modal-fecha {
  border: none;
  background: transparent;
  color: white;
  float: right;
  margin-top: 30px !important;
  margin-left: 413px;
  position: absolute;
  font-weight: 800;
  cursor: pointer;
}
.container-modal {
  z-index: 2;
  position: fixed;
  height: 100vh;
  top: 0px;
  left: 0px;
  width: 100%;
  background: rgba(92, 41, 255, 0.24);
  backdrop-filter: blur(2px);
}
.modal {
  position: fixed;
  z-index: 3;
  top: 20%;
  left: 50%;
  height: 360px;
  border-radius: 25px;
  box-shadow: 2px 9px 15px #2c2c2c29;
  width: 460px;
  margin-left: -150px;
  background: var(--COLOR-BASE-SEGUNDARIA);
}

.modal button {
  margin-top: 50px;
}

.modal form {
  display: flex;
  flex-direction: column;
  margin-top: 45px;
}

.modal h1 {
  text-transform: uppercase;
}

.corpo-modal {
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>