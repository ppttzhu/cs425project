<template>
  <div>
    <div v-if="isAdmin">
      <h3>Customize View</h3>
      <div class="row">
        <div class="col-4">
          <div class="input-group mb-3">
            <div class="input-group-prepend">
              <label class="input-group-text">Year</label>
            </div>
            <select class="custom-select" v-model="currentYear">
              <option v-for="year in years" :key="year">{{year}}</option>
            </select>
          </div>
        </div>
        <div class="col-4">
          <div class="col">
            <div class="input-group mb-3">
              <div class="input-group-prepend">
                <label class="input-group-text">Month</label>
              </div>
              <select class="custom-select" v-model="currentMonth">
                <option v-for="month in months" :key="month">{{month}}</option>
              </select>
            </div>
          </div>
        </div>
        <div class="col-3"></div>
        <div class="col-1">
          <button
            class="btn btn-success float-right"
            @click="submitView"
            :disabled="!currentMonth && !currentMonth"
          >Submit</button>
        </div>
      </div>
      <b-table striped hover :items="tables.get_current_month_report"></b-table>
      <h3>Sales Annual Report</h3>
      <b-spinner
        variant="success"
        style="width: 3rem; height: 3rem;"
        label="Large Spinner"
        v-if="!tables.sales_year_report"
      ></b-spinner>
      <b-table striped hover :items="tables.sales_year_report"></b-table>
      <h3>Sales Monthly Report</h3>
      <b-spinner
        variant="success"
        style="width: 3rem; height: 3rem;"
        label="Large Spinner"
        v-if="!tables.sales_monthly_report"
      ></b-spinner>
      <b-table striped hover :items="tables.sales_monthly_report"></b-table>
      <h3>Sales Summary By Region</h3>
      <b-spinner
        variant="success"
        style="width: 3rem; height: 3rem;"
        label="Large Spinner"
        v-if="!tables.region_total_sales"
      ></b-spinner>
      <b-table striped hover :items="tables.region_total_sales"></b-table>
      <h3>Sales Summary By Category</h3>
      <b-spinner
        variant="success"
        style="width: 3rem; height: 3rem;"
        label="Large Spinner"
        v-if="!tables.category_total_sales"
      ></b-spinner>
      <b-table striped hover :items="tables.category_total_sales"></b-table>
      <h3>Sales Summary By Product</h3>
      <b-spinner
        variant="success"
        style="width: 3rem; height: 3rem;"
        label="Large Spinner"
        v-if="!tables.product_total_sales"
      ></b-spinner>
      <b-table striped hover :items="tables.product_total_sales"></b-table>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import axios from "axios";
import mixin from "../../mixin.js";

export default {
  mixins: [mixin],
  data() {
    return {
      tables: {
        sales_year_report: null,
        sales_monthly_report: null,
        category_total_sales: null,
        product_total_sales: null,
        region_total_sales: null,
        get_current_month_report: null
      },
      currentYear: "",
      currentMonth: "",
      years: ["2018", "2019"],
      months: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    };
  },
  mounted() {
    this.loadStatistics();
  },
  methods: {
    ...mapActions(["addMessage"]),
    loadStatistics() {
      this.loadTable("sales_year_report", "");
      this.loadTable("sales_monthly_report", "");
      this.loadTable("category_total_sales", "");
      this.loadTable("product_total_sales", "");
      this.loadTable("region_total_sales", "");
    },
    loadTable(table, func_argument) {
      var _this = this;
      var request = {
        func_name: table,
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
    submitView() {
      this.loadTable(
        "get_current_month_report",
        this.currentYear + "|" + this.currentMonth
      );
    }
  },
  computed: {
    ...mapGetters(["isAdmin"])
  }
};
</script>
