import Vue from "vue";
import VueRouter from "vue-router";
import VueCookies from "vue-cookies";
import Vuex from "vuex";
import App from "./App.vue";
import "./assets/styles/app.scss";
import axios from "axios";
import global from "./global.js";
import { routes } from "./routes.js";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faTrash, faPencilAlt, faEye } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";

library.add(faTrash, faPencilAlt, faEye);
Vue.component("font-awesome-icon", FontAwesomeIcon);

Vue.use(VueRouter);
Vue.use(VueCookies);
Vue.use(Vuex);

axios.defaults.baseURL =
  "https://3zo4ophla5.execute-api.us-east-1.amazonaws.com/cs425project_v1";

const router = new VueRouter({
  mode: "history",
  routes
});

const store = new Vuex.Store({
  modules: {
    global
  }
});

new Vue({
  router: router,
  store: store,
  render: h => h(App)
}).$mount("#app");

window.$cookies.config(60 * 15, "");
