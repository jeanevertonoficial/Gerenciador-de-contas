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

<style scoped>

header {
  width: 70%;
  display: flex;
  flex-direction: row;
  margin: auto;
  align-items: center;
  justify-content: space-between;
  height: 100%;
}

.header-titulo-centro {
  font-weight: bolder;
}

.header-logar {
  display: flex;
  align-items: center;
}

.header-botao-logar {
  font-size: small;
  font-weight: 900;
}

.header-botao-logar {
  cursor: pointer;
  transition: 0.5s;
}

.header-botao-logar:hover {
  color: #9A34FF;
  transition: 0.5s;
}
.header-botao-logar a {
  text-decoration: none;
  color: inherit;
}

</style>