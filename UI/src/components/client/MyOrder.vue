<template>
  <div class="container table-responsive">
    <table id="cart" class="table table-hover table-sm">
      <thead>
        <tr>
          <th style="width:50%">Product</th>
          <th style="width:10%" class="text-center">Price</th>
          <th style="width:10%" class="text-center">Amount</th>
          <th style="width:10%" class="text-center">Date</th>
          <th style="width:12%" class="text-center">Tracking#</th>
          <th style="width:8%" class="text-center">Review</th>
        </tr>
      </thead>
      <OrderItem
        v-for="orderItem in OrderList"
        :orderItem="orderItem"
        :key="orderItem.pid + orderItem.tracking_number"
        @submitted="loadMyOrder"
      />
    </table>
  </div>
</template>

<script>
import axios from "axios";
import { mapActions, mapGetters } from "vuex";
import OrderItem from "./OrderItem.vue";

export default {
  components: {
    OrderItem
  },
  mounted() {
    this.loadMyOrder();
  },
  data() {
    return {
      OrderList: []
    };
  },
  computed: {
    ...mapGetters(["currentUser", "productList"])
  },
  methods: {
    ...mapActions(["addMessage"]),
    loadMyOrder() {
      if (
        !this.currentUser ||
        (Object.entries(this.productList).length === 0 &&
          this.productList.constructor === Object)
      ) {
        return;
      }
      var request = {
        func_name: "select_order_online",
        func_argument: this.currentUser.cid
      };
      var _this = this;
      axios
        .post("", JSON.stringify(request), {
          headers: {
            "Content-Type": "application/json"
          }
        })
        .then(r => {
          console.log(request);
          if (r.data.message === "Success") {
            _this.processResponse(r.data.returnValue);
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data
            });
          }
        })
        .catch(e => {
          _this.addMessage({
            level: "danger",
            message: e
          });
        });
    },
    processResponse(response) {
      var plist = response.split("\n");
      var ret = [];
      for (var i = 1; i < plist.length; i++) {
        if (plist[i] && plist[i] !== "") {
          var onep = {};
          var onepstring = plist[i].split("|");
          onep.oid = parseInt(onepstring[0]);
          onep.pid = parseInt(onepstring[3]);
          onep.amount = parseInt(onepstring[4]);
          onep.date = onepstring[5];
          onep.tracking_number = onepstring[6];
          onep.rating =
            onepstring[7] === "null" ? null : parseInt(onepstring[7]);
          onep.review = onepstring[8] === "null" ? null : onepstring[8];
          onep.name = this.productList[onep.pid].name;
          onep.price = this.productList[onep.pid].price;
          onep.image_url = this.productList[onep.pid].image_url;
          ret.push(onep);
        }
      }
      this.OrderList = ret;
    }
  },
  watch: {
    currentUser: function() {
      this.loadMyOrder();
    },
    productList: function() {
      this.loadMyOrder();
    }
  }
};
</script>
