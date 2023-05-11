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
      <div class="burger-menu">
        <img class="menu" src="/images/icones/menu-aberto.png">
        <span class="span-manu none">
            <ul>
              <router-link to="/lista-dados-gerais">
                <li class="">Todos Cadastrados</li>
                </router-link>
            </ul>
        </span>
      </div>
      <div class="header-logo">
        <img src="/images/icone-persona.png">
      </div>
      <div class="header-botao-logar">
        <div class="login_info" v-if="userEmail">
          <p>{{ userEmail.email }}</p>
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

export default {
  name: "headerDashboard",
  props: ["titulo_centro"],
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

</style>
