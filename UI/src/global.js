import axios from "axios";

const state = {
  productList: null,
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
    }, 5000); //5s
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
          var ret = [];
          for (var i = 1; i < plist.length; i++) {
            if (plist[i] && plist[i] !== "") {
              var onep = {};
              var onepstring = plist[i].split("|");
              for (var j = 0; j < columns.length; j++) {
                onep[columns[j]] = onepstring[j];
              }
              onep["item_left"] = 1; //TODO
              onep["price"] = parseFloat(
                onep["price"].substring(1, onep["price"].length)
              );
              ret.push(onep);
            }
          }
          state.productList = ret;
        } else {
          addMessage({
            level: "danger",
            message: r.data.message
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
  },
  REMOVE_CURRENT_USER(state) {
    state.currentUser = null;
    state.shoppingCart = null;
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
  }
};

export default {
  state,
  getters,
  actions,
  mutations
};
