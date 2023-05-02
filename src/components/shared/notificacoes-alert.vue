<template>
  <div @click="dismiss()" :class="['alert', `alert-${type}`]" v-show="show">
    <i :class="['fa', `fa-${icon}`]" aria-hidden="true"></i>
    <span @click="dismiss()" class="message">{{ message }}</span>
    <button @click="dismiss()" class="close">X</button>
  </div>
</template>

<script>
export default {
  name: "notificacoes-alert",
  props: {
    type: {
      type: String,
      default: 'success'
    },
    icon: {
      type: String,
      default: 'check'
    },
    message: {
      type: String,
      required: true
    },
    dismissible: {
      type: Boolean,
      default: true
    },
    show: Boolean
  },
  data() {
    return {
      show: true
    }
  },
  methods: {
    dismiss() {
      this.show = !this.show
    }
  }
}
</script>

<style scoped>
.alert button {
  color: #444;
  font-weight: bolder;
}
.alert {
  cursor: pointer;
  position: fixed;
  background-color: #fff;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 3px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  transition: transform .5s ease-in-out, opacity .5s ease-in-out;
  animation: slide-up 0.5s ease-out forwards;
  opacity: 1;
}

.alert.warning {
  color: #ff9800;
}

.alert.success {
  color: #4caf50;
}

.alert.error {
  color: #f44336;
}

@keyframes slide-up {
  from {
    transform: translate(0, 0);
  }
  to {
    transform: translate(0, 100%);
  }
}

.alert-success {
  background-color: #d4edda;
  color: #155724;
  border-color: #c3e6cb;
}

.alert-danger {
  background-color: #f8d7da;
  color: #721c24;
  border-color: #f5c6cb;
}

.alert-warning {
  background-color: #fff3cd;
  color: #856404;
  border-color: #ffeeba;
}

.alert-info {
  background-color: #d1ecf1;
  color: #0c5460;
  border-color: #bee5eb;
}

.fa {
  margin-right: 8px;
}

.message {
  flex: 1;
}

.close {
  margin-left: 8px;
  background: none;
  border: none;
  outline: none;
  cursor: pointer;
}
</style>