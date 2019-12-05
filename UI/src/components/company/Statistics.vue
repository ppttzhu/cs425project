<template>
  <div>
    <div v-if="isAdmin">
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
        product_total_sales: null
      }
    };
  },
  mounted() {
    this.loadStatistics();
  },
  methods: {
    ...mapActions(["addMessage"]),
    loadStatistics() {
      this.loadTable("sales_year_report");
      this.loadTable("sales_monthly_report");
      this.loadTable("category_total_sales");
      this.loadTable("product_total_sales");
    },
    loadTable(table) {
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
    parseTable(tableString) {
      var plist = tableString.split("\n");
      var columns = plist[0].split("|");
      var ret = [];
      for (var i = 1; i < plist.length; i++) {
        if (plist[i] && plist[i] !== "") {
          var onep = {};
          var onepstring = plist[i].split("|");
          for (var j = 0; j < columns.length; j++) {
            onep[columns[j]] = onepstring[j];
          }
          ret.push(onep);
        }
      }
      return ret;
    }
  },
  computed: {
    ...mapGetters(["isAdmin"])
  }
};
</script>
