<template>
  <div id="main">
    <Message />
    <Header />
    <div class="container mt-3">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import Header from "./Header.vue";
import Message from "./Message.vue";

export default {
  components: {
    Header,
    Message
  },
  mounted() {
    this.loadProductList();
    if (window.$cookies.isKey("currentUser")) {
      this.setCurrentUser(window.$cookies.get("currentUser"));
    }
  },
  methods: {
    ...mapActions(["loadProductList", "setCurrentUser"])
  }
};
</script>
