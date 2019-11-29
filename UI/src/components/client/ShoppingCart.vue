<template>
  <div class="container table-responsive">
    <table id="cart" class="table table-hover">
      <thead>
        <tr>
          <th style="width:50%">Product</th>
          <th style="width:15%" class="text-center">Price</th>
          <th style="width:12%" class="text-center" :style="'min-width:80px'">Amount</th>
          <th style="width:20%" class="text-center">Subtotal</th>
          <th style="width:3%"></th>
        </tr>
      </thead>

      <transition-group tag="tbody">
        <CartItem v-for="cartItem in shoppingCart" :cartItem="cartItem" :key="cartItem.pid" />
      </transition-group>

      <tfoot>
        <tr class="d-table-row d-sm-none">
          <td class="text-center">
            <strong>Total ${{ cartValue.toFixed(2) }}</strong>
          </td>
        </tr>
        <tr>
          <td>
            <router-link to="/" class="btn btn-warning">
              <span class="text-nowrap">&lt; Continue Shopping</span>
            </router-link>
          </td>
          <td colspan="2" class="d-none d-sm-table-cell"></td>
          <td class="d-none d-sm-table-cell text-center">
            <strong>Total ${{ cartValue.toFixed(2) }}</strong>
          </td>
          <td class="px-0">
            <button class="btn btn-success" @click="checkout">
              <span class="text-nowrap">Checkout &gt;</span>
            </button>
          </td>
        </tr>
      </tfoot>
    </table>
  </div>
</template>

<script>
import axios from "axios";
import { mapActions, mapGetters } from "vuex";
import CartItem from "./CartItem.vue";
export default {
  components: {
    CartItem
  },
  computed: {
    ...mapGetters([
      "shoppingCart",
      "productList",
      "currentUser",
      "cartValue",
      "currentDate"
    ])
  },
  methods: {
    ...mapActions(["addMessage", "emptyShoppingcart", "loadProductList"]),
    checkout() {
      if (this.currentUser) {
        if (this.checkValidCart() === "") {
          if (this.checkValidInfo() === "") {
            this.insert_order_online();
          }
        }
      } else {
        this.addMessage({
          level: "warning",
          message: "Please login to checkout"
        });
      }
    },
    checkValidCart() {
      var message = "";
      if (
        Object.entries(this.shoppingCart).length === 0 &&
        this.shoppingCart.constructor === Object
      ) {
        message = "Your cart is empty!";
        this.addMessage({
          level: "warning",
          message: message
        });
      } else {
        for (var pid in this.shoppingCart) {
          if (
            this.shoppingCart[pid].amount > this.shoppingCart[pid].item_left
          ) {
            message +=
              "Only " +
              this.shoppingCart[pid].item_left +
              " '" +
              this.shoppingCart[pid].name +
              "' available in stock; ";
          }
        }
        this.addMessage({
          level: "danger",
          message: message
        });
      }
      return message;
    },
    checkValidInfo() {
      return "";
    },
    insert_order_online() {
      var func_argument = "";
      var tracking_number = Math.floor(Math.random() * 1000000000 + 1);
      for (var pid in this.shoppingCart) {
        func_argument +=
          this.currentUser.cid +
          "|" +
          this.shoppingCart[pid].default_wid +
          "|" +
          pid +
          "|" +
          this.shoppingCart[pid].amount +
          "|" +
          this.currentDate +
          "|" +
          tracking_number;
        func_argument += "||";
      }
      func_argument = func_argument.substring(0, func_argument.length - 2);
      var request = {
        func_name: "insert_order_online",
        func_argument: func_argument
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
            _this.addMessage({
              level: "success",
              message: "Your order has been successfully processed!"
            });
            _this.loadProductList();
            _this.emptyShoppingcart();
            this.$router.push({
              name: "MyOrder"
            });
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data.message
            });
          }
        })
        .catch(e => {
          _this.addMessage({
            level: "danger",
            message: e
          });
        });
    }
  }
};
</script>

