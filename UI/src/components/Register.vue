<template>
  <div class="row">
    <div class="col-md-6 offset-md-3 col-sm-10 offset-sm-1">
      <form id="register-form" role="form">
        <h3 class="text-center">Register</h3>
        <div class="form-group">
          <b-form-input
            type="email"
            name="email"
            id="email"
            class="form-control"
            placeholder="Email Address"
            v-model="email"
            :state="checkEmail"
          ></b-form-input>
        </div>
        <div class="form-group">
          <b-form-input
            type="text"
            name="first-name"
            id="first-name"
            class="form-control"
            placeholder="First Name"
            v-model="firstName"
            :state="checkFirst"
          ></b-form-input>
        </div>
        <div class="form-group">
          <b-form-input
            type="text"
            name="last-name"
            id="last-name"
            class="form-control"
            placeholder="Last Name"
            v-model="lastName"
            :state="checkLast"
          ></b-form-input>
        </div>
        <div class="form-group">
          <b-form-input
            type="password"
            name="password"
            id="password"
            class="form-control"
            placeholder="Password at least 6 characters"
            v-model="password"
            :state="checkPassword"
          ></b-form-input>
        </div>
        <div class="form-group">
          <button
            class="btn btn-success"
            style="width: 100%"
            @click.prevent="insertOnlineClient"
            :disabled="isLoading"
          >
            Register
            <b-spinner v-if="isLoading" small></b-spinner>
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { BFormInput, BSpinner } from "bootstrap-vue";
import { sha256 } from "js-sha256";
import { mapActions } from "vuex";

export default {
  components: {
    "b-form-input": BFormInput,
    "b-spinner": BSpinner
  },
  data() {
    return {
      email: "",
      firstName: "",
      lastName: "",
      password: "",
      isLoading: false,
      isChecking: false
    };
  },
  methods: {
    ...mapActions(["addMessage", "setCurrentUser"]),
    checkInformation() {
      this.isChecking = true;
      var msg = "";
      if (!this.checkEmail) {
        msg += "Email Address not valid. ";
      }
      if (!this.checkFirst) {
        msg += "First Name not empty. ";
      }
      if (!this.checkLast) {
        msg += "Last Name not empty. ";
      }
      if (!this.checkPassword) {
        msg += "Password at least 6 characters. ";
      }
      if (msg !== "") {
        this.addMessage({
          level: "danger",
          message: msg
        });
        return false;
      }
      return true;
    },
    insertOnlineClient() {
      var isValid = this.checkInformation();
      if (!isValid) {
        return;
      }
      this.isLoading = true;
      var _this = this;
      var request = {
        func_name: "insert_online_client",
        func_argument:
          this.firstName +
          "|" +
          this.lastName +
          "|" +
          this.email +
          "|" +
          sha256(this.password)
      };
      console.log(JSON.stringify(request));
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
          if (
            r.data.message &&
            r.data.message.includes(
              "duplicate key value violates unique constraint"
            )
          ) {
            _this.addMessage({
              level: "danger",
              message: "This Email address has been registered. Please log in."
            });
          } else if (r.data.returnValue && r.data.returnValue !== "") {
            var client = {
              cid: r.data.returnValue.split("\n")[1],
              firstName: _this.firstName,
              lastName: _this.lastName,
              email: _this.email,
              phoneNumber: null,
              street: null,
              zip: null,
              city: null,
              state: null,
              cardNumber: null,
              accountNumber: null,
              password: _this.password
            };
            _this.setCurrentUser(client);
            _this.$router.push({
              name: "ProductList"
            });
            _this.addMessage({
              level: "success",
              message: "Successfully registered."
            });
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data.message
            });
          }
          _this.isLoading = false;
        });
    }
  },
  computed: {
    checkEmail() {
      return this.isChecking ? this.email.includes("@") : null;
    },
    checkFirst() {
      return this.isChecking ? this.firstName !== "" : null;
    },
    checkLast() {
      return this.isChecking ? this.lastName !== "" : null;
    },
    checkPassword() {
      return this.isChecking ? this.password.length >= 6 : null;
    }
  }
};
</script>
