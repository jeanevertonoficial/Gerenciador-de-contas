<template>
  <div class="container">
    <notificacoesAlert :msg="msg" v-show="msg" :class="estilo"/>
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
import {
  // createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  // signInWithPopup,
  // FacebookAuthProvider
} from "firebase/auth";
// import {auth} from "@/main";
import router from "@/router";
import notificacoesAlert from "@/components/shared/notificacoes-alert";
import axios from "axios";
import rotaApi from "@/controllers/rota-api";

export default {
  name: "LoginAutomatico",
  components: {notificacoesAlert},
  data() {
    return {
      msg: null,
      estilo: null,
      email: "",
      password: "",
      connection: null,
      rota: new rotaApi().rota_criaUsers,
    };
  },
  methods: {
    createLogin() {
      const dadosUsuario = {
        email: this.email,
        password: this.password
      };

      axios.post(`${this.rota}/criar-usuario`, dadosUsuario)
          .then((response) => {
            this.mensagem(
                'sucesso',
                `${response.data.message}`,
                null,
                false
            );
            router.push({name: "dashboard"});
          })
          .catch((error) => {
            this.mensagem(
                'erro',
                `${error.response.data.message}`,
                null,
                false
            );
          })
    },
    abrirLogin() {
      const log = document.querySelectorAll(".logar");
      const criar = document.querySelectorAll(".criar");

      log.forEach((log) => {
        log.classList.add("none");
      });

      criar.forEach((criar) => {
        criar.classList.remove("none");
      });
    },
    voltar() {
      const log = document.querySelectorAll(".logar");
      const criar = document.querySelectorAll(".criar");

      log.forEach((log) => {
        log.classList.remove("none");
      });

      criar.forEach((criar) => {
        criar.classList.add("none");
      });
    },
    loginWithEmail() {
      const dadosUsuario = {
        email: this.email,
        password: this.password
      };

      axios.post(`${this.rota}/login-usuario`, dadosUsuario)
          .then((response) => {
            this.mensagem(
                'sucesso',
                `${response.data.message}`,
                null,
                false
            );
            router.push({name: "dashboard"});
          })
          .catch((error) => {
            this.mensagem(
                'erro',
                `${error.response.data.message}`,
                null,
                false
            );
          })
    },
    mensagem(estilo, texto_msg, tempo_msg) {
      this.estilo = estilo;
      this.msg = texto_msg;
      this.tempo_msg = (tempo_msg == 0 || tempo_msg == null) ? this.tempo_msg = 3000 : this.tempo_msg = tempo_msg;
      setTimeout(() => {
        this.msg = false
      }, this.tempo_msg);
    },
    destroyMyComponent() {
      const myComponent = this.$refs.notificacoesAlert;
      if (myComponent) {
        myComponent.$destroy();
        this.$refs.notificacoesAlert = null;
      }
    }

  },
}
</script>