<template>
  <!-- eslint-disable-next-line -->
  <div class="hello">
    <h1>CS425Project</h1>
    <div>id</div>
    <input type="text" v-model="request.id" />
    <div>name</div>
    <input type="text" v-model="request.name" />
    <div>
      <button @click="add">add</button>
    </div>
    <div>{{msg}}</div>
    <div>id, name</div>
    <div v-for="element in table">
      {{element}}
      </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "HelloWorld",
  data() {
    return {
      request: {
        id: "7",
        name: "vue"
      },
      content: 'Fetching data',
      msg: null,
    };
  },
  mounted() {
    this.getData();
  },
  methods: {
    getData() {
      var _this = this;
      var apiURL = "beta/getres";
      axios
        .get(apiURL)
        .then(response => {
          _this.content = response.data.returnValue;
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    add() {
      var _this = this;
      var apiURL = "beta/insertres";
      var input = {
        id: parseInt(_this.request.id),
        name: _this.request.name
      };
      axios
        .put(apiURL, JSON.stringify(input), {
          headers: {
            "Content-Type": "application/json"
          },
          useCredentails: true
        })
        .then(r => {
          _this.msg = r.data.messageReason;
          _this.getData();
        })
        .catch(e => (_this.msg = e));
    }
  },
  computed: {
    table() {
      var table = [];
      if (this.content != null) {
        table = this.content.split("\t");
      }
      return table;
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
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
