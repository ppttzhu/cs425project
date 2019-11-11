<template>
  <div class="row">
    <div class="col-md-6 offset-md-3 col-sm-12 offset-sm-1">
      <form id="login-form" role="form" style="display: block;">
        <h3 class="text-center">Login</h3>
        <div class="form-group">
          <input
            type="email"
            name="email"
            id="email"
            class="form-control"
            placeholder="Email Address"
            v-model="email"
            :state="checkEmail"
            lazy-formatter
          />
        </div>
        <div class="form-group">
          <input
            type="password"
            name="password"
            id="password"
            class="form-control"
            placeholder="Password"
            v-model="password"
          />
        </div>

        <div class="form-group">
          <button
            class="btn btn-success"
            style="width: 100%"
            @click.prevent="login"
            :disabled="disableLogin"
          >
            Log in
            <b-spinner v-if="isLoading" small></b-spinner>
          </button>
        </div>
        <div class="form-group">
          <div class="row">
            <div class="col-lg-12">
              <div class="text-center">
                <a href="#" @click.prevent="jumpToPage('Register')">New user? Register</a>
              </div>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { BSpinner } from "bootstrap-vue";
import { sha256 } from "js-sha256";

export default {
  components: {
    "b-spinner": BSpinner
  },
  data() {
    return {
      email: "",
      password: "",
      isLoading: false
    };
  },
  methods: {
    jumpToPage(page) {
      this.$emit("jumpToPage", page);
    },
    login() {
      this.isLoading = true;
      var _this = this;
      var request = {
        func_name: "select_online_client",
        func_argument: this.email
      };
      console.log(request);
      axios
        .post("", JSON.stringify(request), {
          headers: {
            "Content-Type": "application/json"
          }
        })
        .catch(e => _this.$emit("message", e, "danger"))
        .then(r => {
          console.log(r.data);
          if (r.data.returnValue && r.data.returnValue !== "") {
            if (r.data.returnValue.split("\n").length > 2) {
              // Email founded in DB
              var client_info = r.data.returnValue.split("\n")[1].split("|");
              var client = {
                cid: client_info[0],
                firstName: client_info[1],
                lastName: client_info[2],
                email: client_info[3],
                phoneNumber: client_info[4],
                street: client_info[5],
                zip: client_info[6],
                city: client_info[7],
                state: client_info[8],
                cardNumber: client_info[9],
                accountNumber: client_info[10],
                password: client_info[11]
              };
              if (client.password.trim() === sha256(this.password.trim())) {
                _this.$emit("clientLogin", client);
                _this.jumpToPage("Previous");
              } else {
                _this.$emit("message", "Password does not match.", "danger");
              }
            } else {
              // Email not founded in DB
              _this.$emit(
                "message",
                "This Email address does not exist. Please register.",
                "danger"
              );
            }
          } else {
            _this.$emit("message", r.data.message, "danger");
          }
          _this.isLoading = false;
        });
    }
  },
  computed: {
    disableLogin() {
      return this.isLoading || this.email === "" || this.password === "";
    },
    checkEmail() {
      return this.email.includes("@");
    }
  }
};
</script>
