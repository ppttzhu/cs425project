import Vue from 'vue'
import VueCookies from 'vue-cookies'
import App from './App.vue'
import './assets/styles/app.scss';
import axios from "axios"

Vue.config.productionTip = false
axios.defaults.baseURL = 'https://3zo4ophla5.execute-api.us-east-1.amazonaws.com/cs425project_v1';

new Vue({
  render: h => h(App),
}).$mount('#app')

Vue.use(VueCookies)
window.$cookies.config(60 * 15, '');

