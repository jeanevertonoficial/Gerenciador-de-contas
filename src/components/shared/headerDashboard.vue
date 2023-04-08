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
        <router-link to="/login">
          Fazer login
        </router-link>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  name: "headerDashboard",
  props: ["titulo_centro"]
};
</script>
