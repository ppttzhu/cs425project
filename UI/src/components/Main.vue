<template>
  <div id="main">
    <Message :message="message" :level="level" />
    <Header
      :firstName="user ? user.firstName : null"
      :numItems="numItems"
      :cartValue="cartValue"
      @jumpToPage="jumpToPage"
      @logout="logout"
    />
    <ProductList v-if="currentPage === 'ProductList'" />
    <Login
      v-if="currentPage === 'Login'"
      @jumpToPage="jumpToPage"
      @clientLogin="clientLogin"
      @message="handleMessage"
    />
    <Register
      v-if="currentPage === 'Register'"
      @jumpToPage="jumpToPage"
      @clientLogin="clientLogin"
      @message="handleMessage"
    />
  </div>
</template>

<script>
import axios from "axios";
import Header from "./Header.vue";
import Message from "./Message.vue";
import Login from "./Login.vue";
import Register from "./Register.vue";
import ProductList from "./client/ProductList.vue";

export default {
  name: "Main",
  components: {
    Header,
    Message,
    Login,
    Register,
    ProductList
  },
  data() {
    return {
      currentPage: window.$cookies.get("currentPage")
        ? window.$cookies.get("currentPage")
        : "ProductList",
      previousPage: null,
      isClient: true,
      user: null,
      message: "",
      level: "",
      productList: null
    };
  },
  mounted() {
    // this.getProductSummary();
  },
  methods: {
    handleMessage(message, level) {
      this.message = message;
      this.level = level;
      var _this = this;
      setTimeout(function() {
        _this.message = "";
      }, 5000); //5s
    },
    jumpToPage(page) {
      if (page === "Login" && this.currentPage !== "Register") {
        this.previousPage = this.currentPage;
      } else if (page === "Previous") {
        page = this.previousPage;
      }
      if (!page || page === "Home") {
        if (this.isClient) {
          page = "ProductList";
        } else {
          page = "Statistics";
        }
      }
      window.$cookies.set("currentPage", page);
      this.currentPage = page;
      // console(this.$route.query.page);
    },
    clientLogin(client) {
      this.user = client;
    },
    logout() {
      this.user = null;
      this.isClient = true;
    },
    getProductSummary() {
      var _this = this;
      var request = {
        func_name: "product_summary",
        func_argument: ""
      };
      axios
        .post("", JSON.stringify(request), {
          headers: {
            "Content-Type": "application/json"
          }
        })
        .then(r => {
          _this.message = r.data.message;
          _this.productList = r.data.returnValue;
        })
        .catch(e => (_this.message = e));
    }
  },
  computed: {
    numItems() {
      return 1;
    },
    cartValue() {
      return 1;
    }
  }
};
</script>
