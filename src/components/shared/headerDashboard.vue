<template>
  <header>
    <div class="header-logo">
      <img src="/images/LOGO.png" alt="logo">
    </div>
    <div class="header-titulo-centro">
      {{ titulo_centro }}
    </div>
    <div class="header-logar">
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
