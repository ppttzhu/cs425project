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
import axios from "axios";
import Header from "./Header.vue";
import Message from "./Message.vue";

export default {
  name: "Main",
  components: {
    Header,
    Message
  },
  mounted() {
    this.loadProductList();
  },
  methods: {
    ...mapActions(["loadProductList"])
  }
};
</script>
