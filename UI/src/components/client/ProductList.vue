<template>
  <div id="product-list">
    <h1>CS425Project</h1>
    <ProductItem :item="item" />
  </div>
</template>

<script>
import ProductItem from "../ProductItem.vue";

export default {
  components: {
    ProductItem
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
</style>
