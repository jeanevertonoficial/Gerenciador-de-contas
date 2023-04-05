<template>
  <div class="boxs">
  <div class="box-base cartoes">
    <div class="box-base-titulo">
      <div class="titulo_base">
        {{ titulo_cartao }}
      </div>
      <card/>
    </div>
  </div>

    <div class="box-base boletos">
      <div class="box-base-titulo">
        <div class="titulo_base">
          {{ titulo_boleto }}
        </div>
        <card/>
      </div>
    </div>

  </div>
</template>

<script>
import Card from "@/components/shared/card.vue";

export default {
  name: "box-base",
  components: { Card },
  props: ["titulo_cartao", "titulo_boleto"]
};
</script>

<style>
.boxs {
  display: flex;
  flex-direction: column;
}
.box-base {
  position: absolute;
  width: 534px;
  height: 255.75px;
  display: flex;
  left: 143px;
  top: 147px;
  background: var(--COLOR-BASE-TEXTO);
  border-radius: 18.75px;
  justify-content: center;
}
.boletos {
  top: 500px
}
.box-base-titulo {
  position: absolute;
  width: 447.75px;
  height: 42px;

  background: #9A34FF;
  color: var(--COLOR-BASE-TEXTO);
  box-shadow: 0px 3px 3px rgba(0, 0, 0, 0.25);
  border-radius: 0px 0px 37.5px 37.5px;
}
.titulo_base {
  height: 42px;
  position: absolute;
  width: 100%;
  text-align: center;
  font-style: normal;
  font-weight: 800;
  font-size: 18px;
  line-height: 21px;
  display: flex;
  align-items: center;
  justify-content: center;

}
</style>