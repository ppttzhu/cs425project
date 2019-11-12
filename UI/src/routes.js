import ProductList from "./components/client/ProductList.vue";
import ShoppingCart from "./components/client/ShoppingCart.vue";
import Login from "./components/Login.vue";
import Register from "./components/Register.vue";
import Statistics from "./components/company/Statistics.vue";

export const routes = [
  { path: "/", component: ProductList, name: "ProductList" },
  { path: "/login", component: Login, name: "Login" },
  { path: "/register", component: Register, name: "Register" },
  { path: "/statistics", component: Statistics, name: "Statistics" },
  { path: "/shoppingcart", component: ShoppingCart, name: "ShoppingCart" },
  { path: "*", redirect: "/" }
];
