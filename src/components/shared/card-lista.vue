<template>
  <div class="base-card-lista">
    <div class="base-img">
      <div class="base-id">
        <h1>1</h1>
      </div>
      <img src="/images/nu.png">
    </div>
    <div class="base-info">
      <div class="base-titulo">
        <div class="titulo-lista">NUBANK</div>
        <div class="base-valor">
          <img class="img-valor" src="/images/cartoes-com-cifrao.png">
          <p class="p-valor">Valor</p>
          <h2>1545.53</h2>
        </div>
      </div>
      <div class="base-titulo-info">
        <div class="data-info">05/23</div>
        <div class="titulo-info">
          CARTÕES DE CRÉDITOS/DÉBITOS
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "card-lista"
}
</script>

<style scoped>
.base-card-lista {
  min-width: 1019px;
  width: 100%;
  height: 160px;
  background: #FFFFFF;
  box-shadow: -10px 10px 19px rgba(0, 0, 0, 0.1);
  border-radius: 18.75px;
}

.base-img {
  box-sizing: border-box;
  width: 277px;
  height: 160px;
  background: #D7D7D7;
  box-shadow: 4px 1px 3px rgb(0 0 0 / 7%);
  border-radius: 0px 24px 24px 0px;
  float: left;
  margin: auto;
}

.base-id {
  position: relative;
  width: 160px;
  top: 60px;
  left: -58px;
  height: 42px;
  background: #9A34FF;
  box-shadow: 0px 3px 3px rgba(0, 0, 0, 0.25);
  border-radius: 0px 0px 45px 45px;
  transform: rotate(-90deg);

}

.base-id h1 {
  font-size: larger;
  width: 63px;
  position: relative;
  top: 42px;
  left: 0px;
  margin: auto;
  transform: rotate(90deg);
  color: white;
}

.base-img img {
  position: relative;
  transform: rotate(90deg);
  width: 145px;
  left: 80px;
  top: -5px;
}

.base-info {
  width: 65%;
  display: flex;
  float: left;
  margin-left: 30px;
  align-items: center;
  justify-content: space-between;
}

.base-titulo {
  position: relative;
  top: 55px;
}

.titulo-lista {
  font-style: normal;
  font-weight: 800;
  font-size: 24px;
  line-height: 28px;
  color: #9A34FF;
  position: relative;
  top: -10px;
}

img.img-valor {
  width: 17px;
  top: -5px;
  position: relative;
}

p.p-valor {
  left: 43px;
  top: -41px;
  position: relative;
  color: blueviolet;
  font-weight: 600;
  text-transform: lowercase;
}

.base-valor h2 {
  position: relative;
  top: -7rem;
  left: 7.5rem;
  font-weight: 800;
  font-size: 40px;
  line-height: 40px;
  color: #9A34FF;
}
.base-titulo-info {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.titulo-info {
  font-style: normal;
  font-weight: 900;
  font-size: 24px;
  line-height: 28px;
  color: #4616AC;
  position: relative;
  top: -10px;
}

.data-info {
  font-weight: 900;
  font-size: 12px;
  line-height: 14px;
  color: #424242;
  position: relative;
  top: -10px;
}

@media (max-width: 1019px) {
  .base-info {
    width: 65%;
    display: flex;
    float: left;
    justify-content: space-between;
    flex-direction: column;
    margin-top: 30px;
    align-items: center
  }
}
</style>