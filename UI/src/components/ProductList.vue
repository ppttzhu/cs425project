<template>
  <div id="product-list">
    <h1>CS425Project</h1>
  </div>
</template>

<script>
export default {
  name: "ProductList",
  data() {
    return {
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
