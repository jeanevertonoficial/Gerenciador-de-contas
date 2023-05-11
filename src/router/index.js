import { createRouter, createWebHistory } from "vue-router";
import {auth} from "@/main";

const routes = [
  {
    path: "/login",
    name: "login",
    component: () => import("../components/LoginAutomatico.vue"),
  },
  {
    path: "/lista-dados-gerais",
    name: "lista",
    component: () => import("../components/ListaDadosGerais.vue"),
  },
  {
    path: "/",
    name: "dashboard",
    component: () => import("../components/DashboardGerencial.vue"),
    meta: {
      requiresAuth: true,
    },
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

router.beforeEach((to, from, next) => {
  const requiresAuth = to.matched.some((record) => record.meta.requiresAuth);
  if (requiresAuth && !auth.currentUser) {
    next("/login");
  } else {
    next();
  }
});

export default router;
