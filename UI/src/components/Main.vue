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
    <div class="container mt-3">
      <ProductList
        v-if="currentPage === 'ProductList'"
        :productList="productList"
        @jumpToPage="jumpToPage"
        @message="handleMessage"
      />
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
    this.getProductSummary();
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
          if (r.data.message === "Success") {
            // console.log(r.data.returnValue);
            _this.productList = _this.processProductList(r.data.returnValue);
          } else {
            _this.message = r.data.message;
          }
        })
        .catch(e => (_this.message = e));
    },
    processProductList(pstring) {
      var plist = pstring.split("\n");
      var columns = plist[0].split("|");
      var ret = [];
      for (var i = 1; i < plist.length; i++) {
        if (plist[i] && plist[i] !== "") {
          var onep = {};
          var onepstring = plist[i].split("|");
          for (var j = 0; j < columns.length; j++) {
            onep[columns[j]] = onepstring[j];
          }
          onep["item_left"] = 1;
          ret.push(onep);
        }
      }
      return ret;
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
