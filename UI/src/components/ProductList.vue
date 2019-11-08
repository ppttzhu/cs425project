/* eslint-disable */
<template>
  <div id="product-list">
    hhah
    <Header/>
    <h1>CS425Project</h1>
  </div>
</template>

<script>
// import axios from "axios";
import Header from "./Header.vue";

export default {
  name: "ProductList",
  components: {
    Header
  },
  data() {
    return {
      request: {
        id: "7",
        name: "vue"
      },
      content: "Fetching data",
      msg: null
    };
  },
  // mounted() {
  //   this.getData();
  // },
  // methods: {
  //   getData() {
  //     var _this = this;
  //     var apiURL = "beta/getres";
  //     axios
  //       .get(apiURL)
  //       .then(response => {
  //         _this.content = response.data.returnValue;
  //       })
  //       .catch(function(error) {
  //         console.log(error);
  //       });
  //   },
  //   add() {
  //     var _this = this;
  //     var apiURL = "beta/insertres";
  //     var input = {
  //       id: parseInt(_this.request.id),
  //       name: _this.request.name
  //     };
  //     axios
  //       .put(apiURL, JSON.stringify(input), {
  //         headers: {
  //           "Content-Type": "application/json"
  //         },
  //         useCredentails: true
  //       })
  //       .then(r => {
  //         _this.msg = r.data.messageReason;
  //         _this.getData();
  //       })
  //       .catch(e => (_this.msg = e));
  //   }
  // },
  // computed: {
  //   table() {
  //     var table = [];
  //     if (this.content != null) {
  //       table = this.content.split("\t");
  //     }
  //     return table;
  //   }
  // }
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
