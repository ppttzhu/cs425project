<template>
  <div class="container" :class="{loadingItem: !productList}">
    <div class="row text-center" v-if="!productList">
      <b-spinner variant="success" style="width: 3rem; height: 3rem;" label="Large Spinner"></b-spinner>
    </div>
    <div class="row" v-if="productList">
      <ProductItem v-for="item in productList" :item="item" :key="item.pid" />
    </div>
  </div>
</template>

<script>
import ProductItem from "../ProductItem.vue";
import { BSpinner } from "bootstrap-vue";

export default {
  props: ["productList"],
  components: {
    ProductItem,
    "b-spinner": BSpinner
  },
  data() {
    return {
      item: {
        pid: "d",
        name: "d",
        price: "d",
        image_url:
          "https://www.pdfonline.com/corporate/newsletters/images/jpgtopdf.png",
        client_rating: "d",
        item_left: "d"
      },
      currentPage: "ProductList"
    };
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
