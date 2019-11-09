<template>
  <div id="app">
    <Header />
    <ProductList v-if="currentPage === 'ProductList'"  />
    <Login v-if="currentPage === 'Login'"  />
    <Register v-if="currentPage === 'Register'"  />
  </div>
</template>

<script>
import ProductList from "./components/ProductList.vue";
import Header from "./components/Header.vue";
import Login from "./components/Login.vue";
import Register from "./components/Register.vue";

export default {
  name: "app",
  components: {
    ProductList,
    Header,
    Login,
    Register
  },
  data() {
    return {
      currentPage: "ProductList"
    };
  }
};
</script>
