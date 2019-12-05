import ProductList from "./components/client/ProductList.vue";
import ShoppingCart from "./components/client/ShoppingCart.vue";
import MyOrder from "./components/client/MyOrder.vue";
import Account from "./components/client/Account.vue";
import Login from "./components/Login.vue";
import Register from "./components/Register.vue";
import Admin from "./components/company/Admin.vue";

export const routes = [
  { path: "/", component: ProductList, name: "ProductList" },
  { path: "/login", component: Login, name: "Login" },
  { path: "/register", component: Register, name: "Register" },
  { path: "/shoppingcart", component: ShoppingCart, name: "ShoppingCart" },
  { path: "/myorder", component: MyOrder, name: "MyOrder" },
  { path: "/account", component: Account, name: "Account" },
  { path: "/admin", component: Admin, name: "Admin" },
  { path: "*", redirect: "/" }
];
