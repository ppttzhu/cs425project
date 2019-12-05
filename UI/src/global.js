import axios from "axios";

const state = {
  productList: {},
  messageGroup: {
    level: "",
    message: "",
    timeoutEvent: null
  },
  isAdmin: false,
  currentUser: null,
  shoppingCart: {},
  numItems: 0,
  cartValue: 0
};

const getters = {
  productList: state => {
    return state.productList;
  },
  messageGroup: state => {
    return state.messageGroup;
  },
  isAdmin: state => {
    return state.isAdmin;
  },
  currentUser: state => {
    return state.currentUser;
  },
  numItems: state => {
    return state.numItems;
  },
  cartValue: state => {
    return state.cartValue;
  },
  shoppingCart: state => {
    return state.shoppingCart;
  },
  currentDate() {
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, "0");
    var mm = String(today.getMonth() + 1).padStart(2, "0"); //January is 0!
    var yyyy = today.getFullYear();
    return yyyy + "-" + mm + "-" + dd;
  }
};

const mutations = {
  ADD_MESSAGE(state, { message, level }) {
    state.messageGroup = {
      level,
      message
    };
    if (state.timeoutEvent) {
      clearTimeout(state.timeoutEvent);
    }
    state.timeoutEvent = setTimeout(function() {
      state.messageGroup = {
        level: "",
        message: ""
      };
    }, 10000); //10s
  },
  LOAD_PRODUCT_LIST(state, pstring) {
    var request = {
      func_name: "product_summary",
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
          // parse response
          var plist = r.data.returnValue.split("\n");
          var columns = plist[0].split("|");
          var ret = {};
          for (var i = 1; i < plist.length; i++) {
            if (plist[i] && plist[i] !== "") {
              var onep = {};
              var onepstring = plist[i].split("|");
              for (var j = 0; j < columns.length; j++) {
                if (onepstring[j] === "null") {
                  onep[columns[j]] = null;
                } else {
                  onep[columns[j]] = onepstring[j];
                }
              }
              onep["price"] = parseFloat(
                onep["price"].substring(1, onep["price"].length)
              ); // Skip first $
              ret[onep["pid"]] = onep;
            }
          }
          state.productList = ret;
        } else {
          addMessage({
            level: "danger",
            message: r.data
          });
        }
      })
      .catch(e =>
        addMessage({
          level: "danger",
          message: e
        })
      );
  },
  SET_ADMIN(state, isAdmin) {
    state.isAdmin = isAdmin;
  },
  SET_CURRENT_USER(state, user) {
    state.currentUser = user;
    window.$cookies.set("currentUser", user);
  },
  REMOVE_CURRENT_USER(state) {
    state.currentUser = null;
    state.shoppingCart = {};
    window.$cookies.remove("currentUser");
  },
  ADD_TO_CART(state, product) {
    if (product.amount === 0) {
      delete state.shoppingCart[product.pid];
    } else {
      state.shoppingCart[product.pid] = product;
    }
    var numItems_ = 0;
    var cartValue_ = 0;
    for (var key in state.shoppingCart) {
      numItems_ += state.shoppingCart[key].amount;
      cartValue_ +=
        state.shoppingCart[key].amount * state.shoppingCart[key].price;
    }
    state.numItems = numItems_;
    state.cartValue = cartValue_;
  },
  EMPTY_CART(state) {
    state.shoppingCart = {};
    state.numItems = 0;
    state.cartValue = 0;
  }
};

const actions = {
  addMessage({ commit }, msgobj) {
    commit("ADD_MESSAGE", msgobj);
  },
  loadProductList({ commit }) {
    commit("LOAD_PRODUCT_LIST");
  },
  setCurrentUser({ commit }, user) {
    commit("SET_CURRENT_USER", user);
    commit("SET_ADMIN", false);
  },
  setAdmin({ commit }, isAdmin) {
    commit("SET_ADMIN", isAdmin);
  },
  removeCurrentUser({ commit }) {
    commit("REMOVE_CURRENT_USER");
  },
  addToChart({ commit }, product) {
    commit("ADD_TO_CART", product);
  },
  emptyShoppingcart({ commit }) {
    commit("EMPTY_CART");
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
