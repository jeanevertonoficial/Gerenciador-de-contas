<template>
  <div>
    <input type="file" @change="processImage" accept="image/*" />
    <div v-if="isLoading">Processando imagem...</div>
    <div v-else>
      <div v-if="error">{{ error }}</div>
      <div v-else>
        <textarea v-model="ocrText" rows="10" cols="50" placeholder="Texto OCR"></textarea>
      </div>
    </div>
  </div>
</template>

<script>
import Tesseract from 'tesseract.js';

export default {
  name: "leitorOCR",
  data() {
    return {
      isLoading: false,
      error: null,
      ocrText: '',
    };
  },
  methods: {
    processImage(event) {
      this.isLoading = true;
      this.error = null;
      this.ocrText = '';

      const file = event.target.files[0];
      if (!file) {
        this.error = 'Nenhum arquivo selecionado.';
        this.isLoading = false;
        return;
      }

      const reader = new FileReader();
      reader.onload = async () => {
        try {
          const { data: { text } } = await Tesseract.recognize(reader.result, 'por');
          this.ocrText = text.trim();
        } catch (error) {
          this.error = 'Erro ao processar a imagem: ' + error.message;
        } finally {
          this.isLoading = false;
        }
      };

      reader.readAsDataURL(file);
    },
  },
};
</script>


<style scoped>

</style>
