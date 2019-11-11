<template>
  <nav class="navbar navbar-expand-sm navbar-dark bg-dark" role="navigation">
    <div class="container">
      <ul class="nav navbar-nav">
        <a class="nav-link" @click="jumpToPage('Home')">Home</a>
      </ul>

      <!-- Brand and toggle get grouped for better mobile display -->
      <button
        class="navbar-toggler"
        type="button"
        data-toggle="collapse"
        data-target="#navbarTop"
        aria-controls="navbarTop"
        aria-expanded="false"
        aria-label="Toggle navigation"
        @click="toggleNavbar"
      >
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarTop" :class="{show: isNavOpen}">
        <ul class="navbar-nav mr-auto"></ul>
        <ul class="nav navbar-nav">
          <a v-if="firstName === null" class="nav-link" @click="jumpToPage('Login')">Login</a>
          <a v-else class="nav-link" @click="logout">Logout {{ firstName }}</a>
          <button class="btn btn-success navbar-btn">
            Checkout
            <span class="badge badge-light">{{ numItems }} ($ {{ cartValue }})</span>
          </button>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  props: ["firstName", "numItems", "cartValue"],
  data() {
    return {
      isNavOpen: false,
      isLoggedIn: false
    };
  },
  methods: {
    toggleNavbar() {
      this.isNavOpen = !this.isNavOpen;
    },
    jumpToPage(page) {
      this.$emit("jumpToPage", page);
    },
    logout() {
      this.$emit("logout");
    }
  }
};
</script>


<style scoped lange="sass">
.navbar-btn a {
  color: white;
}

.li-pointer {
  cursor: pointer;
}

.li-pointer:hover {
  cursor: pointer;
}
</style>
