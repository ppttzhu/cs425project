<template>
  <nav class="navbar navbar-expand-sm navbar-dark bg-dark" role="navigation">
    <div class="container">
      <ul class="nav navbar-nav" v-if="!isAdmin">
        <router-link to="/" class="navbar-brand mr-auto">Online Store</router-link>
      </ul>
      <ul class="nav navbar-nav" v-if="isAdmin">
        <span class="navbar-brand mr-auto">Online Store Management</span>
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
          <router-link to="/login" v-if="currentUser === null && !isAdmin" class="nav-item">
            <a class="nav-link">Login</a>
          </router-link>
          <li v-if="currentUser !== null" class="li-pointer nav-item">
            <router-link to="/account" class="nav-link">Account</router-link>
          </li>
          <li v-if="currentUser !== null" class="li-pointer nav-item">
            <router-link to="/myorder" class="nav-link">Orders</router-link>
          </li>
          <li v-if="currentUser !== null" class="li-pointer nav-item">
            <a @click="logoutUser" class="nav-link">Logout</a>
          </li>
          <li v-if="isAdmin" class="li-pointer nav-item">
            <a @click="logoutAdmin" class="nav-link">Logout admin</a>
          </li>
          <li v-if="!isAdmin">
            <router-link to="/shoppingcart" class="btn btn-success navbar-btn" tag="button">
              Checkout
              <span class="badge badge-light">{{ numItems }} ($ {{ cartValue.toFixed(2) }})</span>
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
import { mapActions, mapGetters } from "vuex";

export default {
  data() {
    return {
      isNavOpen: false,
      isLoggedIn: false
    };
  },
  methods: {
    ...mapActions(["removeCurrentUser", "setAdmin"]),
    toggleNavbar() {
      this.isNavOpen = !this.isNavOpen;
    },
    logoutUser() {
      this.removeCurrentUser();
      this.$router.push({
        name: "ProductList"
      });
    },
    logoutAdmin() {
      this.setAdmin(false);
      this.removeCurrentUser();
      this.$router.push({
        name: "ProductList"
      });
    }
  },
  computed: {
    ...mapGetters(["currentUser", "isAdmin", "numItems", "cartValue"])
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
