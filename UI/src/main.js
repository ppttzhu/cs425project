import Vue from "vue";
import VueRouter from "vue-router";
import VueCookies from "vue-cookies";
import Vuex from "vuex";
import axios from "axios";

import App from "./App.vue";
import global from "./global.js";
import { routes } from "./routes.js";

import { library } from "@fortawesome/fontawesome-svg-core";
import {
  faTrash,
  faPencilAlt,
  faEye,
  faCheck,
  faTimes
} from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import {
  BTable,
  BFormInput,
  BInputGroup,
  BInputGroupAppend,
  BInputGroupPrepend,
  BButton,
  BSpinner,
  BContainer,
  BRow,
  BCol,
} from "bootstrap-vue";
import "./assets/styles/app.scss";

library.add(faTrash, faPencilAlt, faEye, faCheck, faTimes);
Vue.component("font-awesome-icon", FontAwesomeIcon);
Vue.component("b-table", BTable);
Vue.component("b-form-input", BFormInput);
Vue.component("b-input-group", BInputGroup);
Vue.component("b-input-group-append", BInputGroupAppend);
Vue.component("b-input-group-prepend", BInputGroupPrepend);
Vue.component("b-button", BButton);
Vue.component("b-spinner", BSpinner);
Vue.component("b-container", BContainer);
Vue.component("b-row", BRow);
Vue.component("b-col", BCol);

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
