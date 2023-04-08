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
