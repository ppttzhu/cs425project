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
      <div class="col-4">
        <div class="col">
          <div class="input-group mb-3">
            <div class="input-group-prepend">
              <label class="input-group-text">Store</label>
            </div>
            <select class="custom-select" v-model="currentStore" @change="loadStore(currentStore)">
              <option v-for="store in storeList" :key="store.sid" :value="store.sid">{{store.name}}</option>
            </select>
          </div>
        </div>
      </div>
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
      v-if="!storeProductItems && currentWarehouse && currentStore"
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
    this.loadStoreSummary();
    this.loadProductList();
  },
  data() {
    return {
      currentStore: "",
      currentWarehouse: "",
      storeList: [],
      warehouseList: [],
      warehouseAmount: null,
      storeAmount: null,
      totalAmount: 0,
      replenishList: {},
      checkallActive: false
    };
  },
  methods: {
    ...mapActions(["addMessage", "loadProductList"]),
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
    loadStoreSummary() {
      var _this = this;
      var request = {
        func_name: "store",
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
            _this.storeList = _this.parseTable(r.data.returnValue);
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
    loadStore(sid) {
      var _this = this;
      var request = {
        func_name: "select_keep_store",
        func_argument: sid
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
            _this.storeAmount = tmp;
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
      if (!this.replenishAmountCheck()) {
        return;
      }
      for (var pid in replenishAmount) {
        func_argument +=
          this.currentWarehouse +
          "|" +
          this.currentStore +
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
        func_name: "insert_replenish_w2s",
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
            _this.loadStore(_this.currentStore);
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
    replenishAmountCheck() {
      if (!this.checkallActive) {
        var msg = "";
        for (var pid in this.replenishList) {
          if (
            !this.warehouseAmount[pid] ||
            this.warehouseAmount[pid] < this.replenishList[pid]
          ) {
            msg += this.productList[pid].name + ", ";
          }
        }
        if (msg !== "") {
          this.addMessage({
            level: "danger",
            message: msg + "amount exceeded current warehouse storage."
          });
          return false;
        } else {
          return true;
        }
      } else {
        if (
          Object.entries(this.warehouseAmount).length === 0 &&
          this.warehouseAmount.constructor === Object
        ) {
          this.addMessage({
            level: "danger",
            message: "Total amount exceeded current warehouse storage."
          });
          return false;
        }
        for (var pid in this.warehouseAmount) {
          if (
            !this.warehouseAmount[pid] ||
            this.warehouseAmount[pid] < this.totalAmount
          ) {
            this.addMessage({
              level: "danger",
              message: "Total amount exceeded current warehouse storage."
            });
            return false;
          }
        }
        return true;
      }
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
      return this.currentWarehouse !== "" && this.currentStore !== "'";
    },
    storeProductItems() {
      if (
        this.warehouseAmount &&
        this.storeAmount &&
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
          product.storeAmount = this.storeAmount[pid]
            ? this.storeAmount[pid]
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

