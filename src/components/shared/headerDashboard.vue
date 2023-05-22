<template>
  <header>
    <div class="header-logo">
      <router-link to="/">
        <img src="/images/LOGO.png" alt="logo">
      </router-link>
    </div>
    <div class="header-titulo-centro">
      {{ titulo_centro }}
    </div>
    <div class="header-logar">
      <div class="busca-input" v-if="listaDados">
        <div class="busca-div">
          <input class="busca-input" id="busca_input" type="text" name="busca-texto" placeholder="Buscar">
          <img class="busca-lupa" src="/images/icones/lupa.png">
        </div>
      </div>
      <div class="burger-menu">
        <img class="menu" src="/images/icones/menu-aberto.png">
        <span class="span-manu none">
            <ul>
              <router-link to="/">
                <li>Inicio</li>
              </router-link>
              <router-link to="/lista-dados-gerais">
                <li>Todos Cadastrados</li>
              </router-link>
              <router-link to="" class="sair-mobile">
              <li @click="signOut">Sair</li>
              </router-link>
            </ul>
        </span>
      </div>
      <div class="header-logo persona">
        <img src="/images/icone-persona.png">
      </div>
      <div class="header-botao-logar">
        <div class="login_info" v-if="userEmail">
          <button @click="signOut">Sair</button>
        </div>
        <div v-else>
          <router-link to="/login">
            Fazer login
          </router-link>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import {signOut} from "firebase/auth";
import {auth} from "@/main";
import listaDadosGerais from "@/components/ListaDadosGerais.vue";

export default {
  name: "headerDashboard",
  props: ["titulo_centro", "listaDados"],
  data() {
    return {
      userEmail: null,
    }
  },
  created() {
    this.usuario()
  },
  mounted() {
    const menu = document.querySelector('.menu')
    const menuOculto = document.querySelector('.span-manu')

    menu.addEventListener('click', () => {
      menuOculto.classList.toggle('none')
    });
  },
  methods: {
    usuario() {
      auth.onAuthStateChanged((user) => {
        this.userEmail = user;
      });
    },
    signOut() {
      signOut(auth)
          .then(() => {
            console.log("User signed out");
            this.$router.push('/login')
            // do something after sign-out
          })
          .catch((error) => {
            console.error("Error signing out:", error);
            // handle the error
          });
    },
  }
};
</script>
<style scoped>
.none {
  display: none;
}

input.busca-input {
  height: 36px;
  width: 256px;
  border-radius: 25px;
  border: none;
  padding-left: 20px;
}

img.busca-lupa {
  position: relative;
  left: -3.5rem;
  top: 7px;
}

.busca-input {
  position: relative;
  right: 15px;
}
</style>
