<template>
  <div>
    <div class="row">
      <div class="col-4">
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <label class="input-group-text">Warehouse</label>
          </div>
          <select class="custom-select" v-model="currentWarehouse">
            <option v-for="warehouse in warehouseList" :key="warehouse">{{warehouse}}</option>
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
            @change="totalAmountChanged"
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
      variant="success"
      style="width: 3rem; height: 3rem;"
      label="Large Spinner"
      v-if="!storeProductItems"
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

export default {
  components: {
    ProductItem
  },
  mounted() {
    this.loadProductList();
  },
  data() {
    return {
      currentWarehouse: "",
      warehouseList: ["lolo", "lolo1"],
      totalAmount: 0,
      submitActive: true,
      checkallActive: false,
      storeProductItems: this.productList
    };
  },
  methods: {
    ...mapActions(["loadProductList", "addMessage"]),
    loadWarehouseSummary() {
      var _this = this;
      var request = {
        func_name: table,
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
            _this.tables[table] = _this.parseTable(r.data.returnValue);
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
    amountChanged(product, amount) {},
    submitReplenish() {},
    totalAmountChanged() {
      for (var item in this.storeProductItems) {
        this.storeProductItems[item]["amount"] = this.totalAmount;
      }
    }
  },
  computed: {
    ...mapGetters(["productList"])
  },
  watch: {
    productList: function() {
      this.storeProductItems = this.productList;
    }
  }
};
</script>

<style lang="scss" scoped>
.additem {
  width: 130px;
}
</style>
