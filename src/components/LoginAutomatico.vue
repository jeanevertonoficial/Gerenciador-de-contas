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
      <notificacoes-alert v-show="alerta" :message="notificacao.descricao" :type="notificacao.tipo" :icon="notificacao.icone"></notificacoes-alert>
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
import notificacoesAlert from "@/components/shared/notificacoes-alert.vue";

export default {
  name: "LoginAutomatico",
  components:{ notificacoesAlert },
  data() {
    return {
      email: "",
      password: "",
      connection: null,
      alerta: false,
      notificacao: {
        descricao: "",
        icone: "",
        tipo: "",
      },
    };
  },
  methods: {
    createLogin() {
      createUserWithEmailAndPassword(auth, this.email, this.password)
          .then((response) => {
            console.log("Novo Usuário Criado: " + response.user.email);
            this.notificacao.descricao = "Login criado com sucesso";
            this.notificacao.icone = "check";
            this.notificacao.tipo = "success";
            //Salvar o e-mail do usuário no banco de dados MySQL
            // const emailValue = response.user.email;
            // const sql = `INSERT INTO cliente (email) VALUES (?)`;
            // const values = ["", emailValue];
            // this.connection.query(sql, values, (error, results, fields) => {
            //   if (error) {
            //     console.error(error);
            //   } else {
            //     alert("E-mail do usuário salvo no banco de dados MySQL");
            //     console.log("E-mail do usuário salvo no banco de dados MySQL");
            //   }
            // });

            router.push({ name: "dashboard" });
          })
          .catch((error) => {
            this.notificacao.descricao = "E-email ou senha incorreto";
            this.notificacao.icone = "danger";
            this.notificacao.tipo = "danger";
            console.error(error);
          });
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
      this.alerta = false;
      signInWithEmailAndPassword(auth, this.email, this.password)
          .then((response) => {
            this.alerta = true
            this.notificacao.descricao = "Logado com sucesso";
            this.notificacao.icone = "check";
            this.notificacao.tipo = "success";
            router.push({ name: "dashboard" });
          })
          .catch((error) => {
            this.alerta = true
            this.notificacao.descricao = "E-email não cadastrado";
            this.notificacao.icone = "danger";
            this.notificacao.tipo = "danger";
            console.error(error.message);
          });
    },
  },
  // mounted() {
  //   this.connection = mysql.createConnection({
  //     host: process.env.VUE_APP_DATABASE_ROST,
  //     user: process.env.VUE_APP_DATABASE_USERNAME,
  //     password: process.env.VUE_APP_DATABASE_PASSWORD,
  //     database: process.env.VUE_APP_DATABASE_DBNAME,
  //   });
  // },
}
</script>