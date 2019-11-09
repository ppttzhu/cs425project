<template>
  <nav class="navbar navbar-expand-sm navbar-dark bg-dark" role="navigation">
    <div class="container">
      <!-- Brand and toggle get grouped for better mobile display -->
      <router-link to="/" class="navbar-brand mr-auto">Online Store</router-link>
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
          <router-link
            to="/login"
            tag="li"
            v-if="!isLoggedIn"
            class="nav-item"
            active-class="active"
          >
            <a class="nav-link">Login</a>
          </router-link>
          <li v-if="isLoggedIn" class="li-pointer nav-item">
            <a @click="logout" class="nav-link">Logout {{ userEmail }}</a>
          </li>
          <router-link
            to="/register"
            tag="li"
            v-if="!isLoggedIn"
            class="nav-item"
            active-class="active"
          >
            <a class="nav-link">Register</a>
          </router-link>
          <li>
            <router-link to="/cart" class="btn btn-success navbar-btn" tag="button">
              Checkout
              <span class="badge badge-light">{{ numItems }} ($ {{ cartValue }})</span>
            </router-link>
          </li>
        </ul>
      </div>
    </div>
    <!-- /.container -->
  </nav>
</template>

<script>
export default {
  name: "Header",
  data() {
    return {
      isNavOpen: false,
      isLoggedIn: false
    };
  },
  methods: {
    toggleNavbar() {
      this.isNavOpen = !this.isNavOpen;
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
