<template>
  <div>
    <div v-if="isAdmin">
      <nav class="navbar navbar-expand-lg navbar-light">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item" :class="{active: currentPage === 'Statistics'}">
            <a class="nav-link" href="#" @click.prevent="loadPage('Statistics')">Statistics</a>
          </li>
          <li class="nav-item" :class="{active: currentPage === 'Warehouse'}">
            <a class="nav-link" href="#" @click.prevent="loadPage('Warehouse')">Warehouse</a>
          </li>
          <li class="nav-item" :class="{active: currentPage === 'Store'}">
            <a class="nav-link" href="#" @click.prevent="loadPage('Store')">Store</a>
          </li>
        </ul>
      </nav>
      <Statistics v-if="currentPage === 'Statistics'" />
      <Warehouse v-if="currentPage === 'Warehouse'" />
      <Store v-if="currentPage === 'Store'" />
    </div>
    <div v-else style="color:red;">Page not available</div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import Statistics from "./Statistics.vue";
import Warehouse from "./Warehouse.vue";
import Store from "./Store.vue";

export default {
  name: "Admin",
  components: {
    Statistics,
    Warehouse,
    Store
  },
  data() {
    return {
      currentPage: "Statistics"
    };
  },
  methods: {
    loadPage(page) {
      this.currentPage = page;
    }
  },
  computed: {
    ...mapGetters(["isAdmin"])
  }
};
</script>
