<template>
  <div class="container">
    <div class="container-corpo">
      <div class="texto-info">
        <p>APROVEITE A MELHOR E MAIS <strong>SIMPLIFICADA</strong> <br>
          <strong>PRATAFORMA</strong> DE ORGANIZAÇÃO DE CONTAS</p>
      </div>
    </div>
    <div class="container-login">
      <div class="conteudo-login">
        <img src="/images/LOGO.png" alt="logo">
        <h1 class="logar">ENTRAR</h1>
        <h1 class="criar none">CRIAR LOGIN</h1>
        <form>
          <div class="logar">
            <div class="campos-inputs">
              <label>
                Email
                <input type="email" v-model="email" required placeholder="Digite seu email">
              </label>
              <label>
                Senha
                <input type="password" v-model="password" required placeholder="Digite sua senha">
              </label>
            </div>
            <div class="botoes-login">
              <button type="submit" @click.prevent="loginWithEmail">LOGAR</button>
            </div>
            <label @click.prevent="abrirLogin" class="criarLoginLabel">Criar Login</label>
          </div>

          <div class="criar none">
            <div class="campos-inputs">
              <label for="email_conta">
                Email
              </label>
              <input type="email" name="email_conta" placeholder="Digite seu email">
              <label for="senha_conta">
                Senha
              </label>
              <input type="password" name="senha_conta" placeholder="Digite sua senha">
            </div>
            <div class="botoes-login">
              <button type="submit" @click.prevent="createLogin">SALVAR LOGIN</button>
            </div>
          </div>
        </form>
      </div>
      <div class="rodape-login">
        <router-link to="/login" class="criar none" @click="voltar">Entrar</router-link>
        <p class="by-descricao">by vida sempre organizado</p>
      </div>
    </div>
  </div>
</template>

<script>
import {ref} from "vue";
import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  // signInWithPopup,
  // FacebookAuthProvider
} from "firebase/auth";
import {auth} from "@/main";
import router from "@/router";

export default {
  name: "LoginAutomatico",
  setup() {
    const email = ref("");
    const password = ref("");

    const createLogin = () => {
      createUserWithEmailAndPassword(auth, email.value, password.value)
          .then((response) => {
            console.log('Novo Usuário Criado: ' + response.user.email)
            router.push({name: 'dashboard'})
          })
          .catch((error) => {
            alert('Popup do E-mail fechado sem concluir o login, para logar clique no botão (continuar com E-mail).')
            console.error(error);
          });
    };

    const abrirLogin = () => {
      const log = document.querySelectorAll('.logar')
      const criar = document.querySelectorAll('.criar')

      log.forEach(log => {
        log.classList.add('none');
      });

      criar.forEach(criar => {
        criar.classList.remove('none');
      });
    };

    const voltar = () => {
      const log = document.querySelectorAll('.logar')
      const criar = document.querySelectorAll('.criar')

      log.forEach(log => {
        log.classList.remove('none');
      });

      criar.forEach(criar => {
        criar.classList.add('none');
      });
    };

    const loginWithEmail = () => {
      signInWithEmailAndPassword(auth, email.value, password.value)
          .then((response) => {
            console.log('Usuário Logado: ' + response.user.email)
            router.push({name: 'dashboard'})
          })
          .catch((error) => {
            alert('Popup do E-mail fechado sem concluir o login, para logar clique no botão (continuar com E-mail).')
            console.error(error);
          });
    };

    // const loginWithFacebook = () => {
    //   const provider = new FacebookAuthProvider();
    //
    //   signInWithPopup(auth, provider)
    //       .then(() => {
    //         alert('Login realizado com sucesso.')
    //         console.log("Logged in with Facebook");
    //       })
    //       .catch((error) => {
    //         error
    //         alert('Popup do Facebook fechado sem concluir o login, para logar clique no botão (continuar com Facebook).')
    //       });
    // };

    return {
      email,
      password,
      loginWithEmail,
      // loginWithFacebook,
      createLogin,
      abrirLogin,
      voltar
    };
  }
};
</script>