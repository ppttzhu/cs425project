<template>
  <div class="container" :class="{loadingItem: !productList}">
    <div class="row text-center" v-if="!productList">
      <b-spinner variant="success" style="width: 3rem; height: 3rem;" label="Large Spinner"></b-spinner>
    </div>
    <div class="row" v-if="productList">
      <ProductItem
        v-for="item in productList"
        :item="item"
        :key="item.pid"
        @amountChanged="amountChanged"
      />
    </div>
  </div>
</template>

<script>
import ProductItem from "../ProductItem.vue";
import { BSpinner } from "bootstrap-vue";
import { mapActions, mapGetters } from "vuex";

export default {
  components: {
    ProductItem,
    "b-spinner": BSpinner
  },
  data() {
    return {
      shoppingCart: null
    };
  },
  methods: {
    ...mapActions(["addToChart"]),
    amountChanged(product, amount){
      var p = Object.assign({}, product);
      p.amount = amount;
      this.addToChart(p);
    }
  },
  computed: {
    ...mapGetters(["productList"])
  }
};
</script>

<style>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
.loadingItem {
  align-items: center;
  justify-content: center;
  display: flex;
}
</style>
