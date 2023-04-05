<template>
  <div class="container">>
    <div class="container-corpo">
      <div class="texto-info">
        <p>APROVEITE A MELHOR E MAIS <strong>SIMPLIFICADA</strong> <br>
          <strong>PRATAFORMA</strong> DE ORGANIZAÇÃO DE CONTAS</p>
      </div>
    </div>
    <div class="container-login">
      <div class="conteudo-login">
        <img src="/images/LOGO.png" alt="logo">
        <h1>ENTRAR</h1>
        <form>
          <div class="campos-inputs">
            <label>
              Email:
              <input type="email" v-model="email" required placeholder="Digite seu email">
            </label>
            <label>
              Senha:
              <input type="password" v-model="password" required placeholder="Digite sua senha">
            </label>
          </div>
          <div class="botoes-login">
            <button type="submit" @click.prevent="loginWithEmail">CONTINUAR COM E-MAIL</button>
            <button type="button" @click.prevent="loginWithFacebook">CONTINUAR COM FACEBOOK</button>
          </div>
        </form>
      </div>
      <div class="rodape-login">
        <p class="by-descricao">by vida sempre organizado</p>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import { signInWithEmailAndPassword, signInWithPopup, FacebookAuthProvider } from "firebase/auth";
import { auth } from "@/main";

export default {
  name: "LoginAutomatico",
  setup() {
    const email = ref("");
    const password = ref("");

    const loginWithEmail = () => {
      signInWithEmailAndPassword(auth, email.value, password.value)
        .then(() => {
          console.log("Logged in with email and password");
        })
        .catch((error) => {
          console.error(error);
        });
    };

    const loginWithFacebook = () => {
      const provider = new FacebookAuthProvider();

      signInWithPopup(auth, provider)
        .then(() => {
          console.log("Logged in with Facebook");
        })
        .catch((error) => {
          console.error(error);
        });
    };

    return {
      email,
      password,
      loginWithEmail,
      loginWithFacebook
    };
  }
};
</script>

<style scoped>

</style>