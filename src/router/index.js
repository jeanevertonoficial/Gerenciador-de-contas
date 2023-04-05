import { createRouter, createWebHistory } from "vue-router";

const routes = [
  {
    path: "/login",
    name: "login",
    component: () => import("../components/LoginAutomatico.vue"),
  },
  {
    path: "/",
    name: "dashboard",
    component: () => import("../components/DashboardGerencial.vue"),
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
