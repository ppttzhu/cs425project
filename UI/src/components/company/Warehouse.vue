<template>
  <div>
    <div class="row">
      <div class="col-4">
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <label class="input-group-text">Warehouse</label>
          </div>
          <select
            class="custom-select"
            v-model="currentWarehouse"
            @change="loadWarehouse(currentWarehouse)"
          >
            <option
              v-for="warehouse in warehouseList"
              :key="warehouse.wid"
              :value="warehouse.wid"
            >{{warehouse.name}}</option>
          </select>
        </div>
      </div>
      <div class="col-4"></div>
      <div class="col-3">
        <div class="input-group mb-3 additem float-right">
          <div class="input-group-prepend">
            <span class="input-group-text" id="basic-addon1">
              <input type="checkbox" v-model="checkallActive" aria-label="Checkbox for selete all" />
            </span>
          </div>
          <b-form-input
            class="form-control"
            type="number"
            :number="true"
            v-model="totalAmount"
            min="0"
            max="9999"
            :disabled="!checkallActive"
          />
        </div>
      </div>
      <div class="col-1">
        <button
          class="btn btn-success float-right"
          @click="submitReplenish"
          :disabled="!submitActive"
        >Submit</button>
      </div>
    </div>
    <b-spinner
      v-if="!storeProductItems && currentWarehouse"
      variant="success"
      style="width: 3rem; height: 3rem;"
      label="Large Spinner"
    ></b-spinner>
    <div class="row" v-if="storeProductItems">
      <ProductItem
        v-for="item in storeProductItems"
        :item="item"
        :key="item.pid"
        @amountChanged="amountChanged"
      />
    </div>
  </div>
</template>

<script>
import ProductItem from "../ProductItem.vue";
import { mapActions, mapGetters } from "vuex";
import axios from "axios";
import mixin from "../../mixin.js";

export default {
  mixins: [mixin],
  components: {
    ProductItem
  },
  mounted() {
    this.loadWarehouseSummary();
    this.loadProductList();
  },
  data() {
    return {
      currentWarehouse: "",
      warehouseList: [],
      warehouseAmount: null,
      totalAmount: 0,
      replenishList: {},
      checkallActive: false
    };
  },
  methods: {
    ...mapActions(["loadProductList", "addMessage"]),
    loadWarehouseSummary() {
      var _this = this;
      var request = {
        func_name: "warehouse",
        func_argument: ""
      };
      axios
        .post("", JSON.stringify(request), {
          headers: {
            "Content-Type": "application/json"
          }
        })
        .then(r => {
          console.log(request);
          if (r.data.message === "Success") {
            _this.warehouseList = _this.parseTable(r.data.returnValue);
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data
            });
          }
        })
        .catch(e =>
          _this.addMessage({
            level: "danger",
            message: e
          })
        );
    },
    loadWarehouse(wid) {
      var _this = this;
      var request = {
        func_name: "select_keep_warehouse",
        func_argument: wid
      };
      axios
        .post("", JSON.stringify(request), {
          headers: {
            "Content-Type": "application/json"
          }
        })
        .then(r => {
          console.log(request);
          if (r.data.message === "Success") {
            var rets = _this.parseTable(r.data.returnValue);
            var tmp = {};
            rets.forEach(element => {
              tmp[element.pid] = element.amount;
            });
            _this.warehouseAmount = tmp;
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data
            });
          }
        })
        .catch(e =>
          _this.addMessage({
            level: "danger",
            message: e
          })
        );
    },
    amountChanged(product, amount) {
      if (amount === 0) {
        this.replenishList[product.pid];
      } else {
        this.replenishList[product.pid] = amount;
      }
    },
    submitReplenish() {
      var func_argument = "";
      var replenishAmount = this.replenishAmount();
      if (
        Object.entries(replenishAmount).length === 0 &&
        replenishAmount.constructor === Object
      ) {
        this.addMessage({
          level: "warning",
          message: "No replenishment selected."
        });
        return;
      }
      for (var pid in replenishAmount) {
        func_argument +=
          this.currentWarehouse +
          "|" +
          pid +
          "|" +
          replenishAmount[pid] +
          "|" +
          this.currentDate +
          "\n";
      }
      func_argument = func_argument.substring(0, func_argument.length - 1);
      var _this = this;
      var request = {
        func_name: "insert_replenish_m2w",
        func_argument: func_argument
      };
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
              message: "Replenish has been placed."
            });
            _this.loadWarehouse(_this.currentWarehouse);
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data
            });
          }
        })
        .catch(e =>
          _this.addMessage({
            level: "danger",
            message: e
          })
        );
    },
    replenishAmount() {
      if (!this.checkallActive) {
        return this.replenishList;
      } else {
        var ret = {};
        if (this.totalAmount) {
          for (var pid in this.productList) {
            ret[pid] = this.totalAmount;
          }
        }
        return ret;
      }
    }
  },
  computed: {
    ...mapGetters(["productList", "currentDate"]),
    submitActive() {
      return this.currentWarehouse !== "";
    },
    storeProductItems() {
      if (
        this.warehouseAmount &&
        !(
          Object.entries(this.productList).length === 0 &&
          this.productList.constructor === Object
        )
      ) {
        var ret = this.productList;
        for (var pid in this.productList) {
          var product = Object.assign({}, this.productList[pid]);
          product.warehouseAmount = this.warehouseAmount[pid]
            ? this.warehouseAmount[pid]
            : "0";
          ret[pid] = product;
        }
        return ret;
      } else {
        return null;
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.additem {
  width: 130px;
}
</style>
