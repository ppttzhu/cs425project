import ProductList from "./components/client/ProductList.vue";
import ShoppingCart from "./components/client/ShoppingCart.vue";
import Login from "./components/Login.vue";
import Register from "./components/Register.vue";
import Statistics from "./components/company/Statistics.vue";
import ReplenishStore from "./components/company/ReplenishStore.vue";
import ReplenishWarehouse from "./components/company/ReplenishWarehouse.vue";
import Warehouse from "./components/company/Warehouse.vue";
import Store from "./components/company/Store.vue";

export const routes = [
  { path: "/", component: ProductList, name: "ProductList" },
  { path: "/login", component: Login, name: "Login" },
  { path: "/register", component: Register, name: "Register" },
  { path: "/shoppingcart", component: ShoppingCart, name: "ShoppingCart" },
  { path: "/statistics", component: Statistics, name: "Statistics" },
  { path: "/replenish-store", component: ReplenishStore, name: "ReplenishStore" },
  { path: "/replenish-warehouse", component: ReplenishWarehouse, name: "ReplenishWarehouse" },
  { path: "/warehouse", component: Warehouse, name: "Warehouse" },
  { path: "/store", component: Store, name: "Store" },
  { path: "*", redirect: "/" }
];
