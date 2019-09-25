import Vue from 'vue'
import App from './App.vue'
import axios from "axios"

Vue.config.productionTip = false
axios.defaults.baseURL = 'https://iykvc15p40.execute-api.us-east-1.amazonaws.com/';

new Vue({
  render: h => h(App),
}).$mount('#app')
