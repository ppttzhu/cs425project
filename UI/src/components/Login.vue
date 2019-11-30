<template>
  <div class="row">
    <div class="col-md-6 offset-md-3 col-sm-12 offset-sm-1">
      <form id="login-form" role="form" style="display: block;">
        <h3 class="text-center" style="padding-bottom:25px;">Login</h3>
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
                <router-link to="/register">
                  <a>New user? Register</a>
                </router-link>
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
import { sha256 } from "js-sha256";
import { mapActions } from "vuex";

export default {
  data() {
    return {
      email: "",
      password: "",
      isLoading: false
    };
  },
  methods: {
    ...mapActions(["addMessage", "setCurrentUser", "setAdmin"]),
    login() {
      this.isLoading = true;
      var _this = this;
      var request = {
        func_name: "select_online_client",
        func_argument: this.email
      };
      if (this.email === "admin" && this.password === "admin") {
        this.setAdmin(true);
        this.$router.push({
          name: "Statistics"
        });
        return;
      }
      console.log(request);
      axios
        .post("", JSON.stringify(request), {
          headers: {
            "Content-Type": "application/json"
          }
        })
        .catch(e => {
          _this.addMessage({
            level: "danger",
            message: e
          });
        })
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
                phoneNumber: (client_info[4] === 'null') ? null : client_info[4],
                street: (client_info[5] === 'null') ? null : client_info[5],
                zip: (client_info[6] === 'null') ? null : client_info[6],
                city: (client_info[7] === 'null') ? null : client_info[7],
                state: (client_info[8] === 'null') ? null : client_info[8],
                cardNumber: (client_info[9] === 'null') ? null : client_info[9],
                accountNumber: (client_info[10] === 'null') ? null : client_info[10],
                password: client_info[11]
              };
              if (client.password.trim() === sha256(this.password.trim())) {
                _this.setCurrentUser(client);
                _this.$router.push({
                  name: "ProductList"
                });
              } else {
                _this.addMessage({
                  level: "danger",
                  message: "Password does not match."
                });
              }
            } else {
              // Email not founded in DB
              _this.addMessage({
                level: "danger",
                message: "This Email address does not exist. Please register."
              });
            }
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data
            });
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
