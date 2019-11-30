<template>
  <div class="row">
    <div class="col-md-6 offset-md-3 col-sm-12 offset-sm-1">
      <h3 class="text-center" style="padding-top:10px; padding-bottom:10px;">
        Basic Info
        <button class="btn btn-sm float-right" v-if="showChangeBasic">
          <font-awesome-icon icon="check" @click="saveBasic"></font-awesome-icon>
        </button>
        <button class="btn btn-sm float-right" v-if="showChangeBasic">
          <font-awesome-icon icon="times" @click="cancelBasic"></font-awesome-icon>
        </button>
        <button class="btn btn-sm float-right" v-if="!showChangeBasic">
          <font-awesome-icon icon="pencil-alt" @click="changeBasic"></font-awesome-icon>
        </button>
      </h3>
      <b-container fluid>
        <b-row class="m-1">
          <b-col sm="4">
            <label>Email:</label>
          </b-col>
          <b-col sm="8">{{email}}</b-col>
        </b-row>
        <b-row class="m-1">
          <b-col sm="4">
            <label>First Name:</label>
          </b-col>
          <b-col sm="8">
            <span v-if="!showChangeBasic">{{firstName}}</span>
            <b-form-input v-else v-model="firstName" :state="checkFirst"></b-form-input>
          </b-col>
        </b-row>
        <b-row class="m-1">
          <b-col sm="4">
            <label>Last Name:</label>
          </b-col>
          <b-col sm="8">
            <span v-if="!showChangeBasic">{{lastName}}</span>
            <b-form-input v-else v-model="lastName" :state="checkLast"></b-form-input>
          </b-col>
        </b-row>
      </b-container>
      <h3 class="text-center" style="padding-top:10px; padding-bottom:10px;">
        Payment Info
        <button class="btn btn-sm float-right" v-if="showChangePay">
          <font-awesome-icon icon="check" @click="savePay"></font-awesome-icon>
        </button>
        <button class="btn btn-sm float-right" v-if="showChangePay">
          <font-awesome-icon icon="times" @click="cancelPay"></font-awesome-icon>
        </button>
        <button class="btn btn-sm float-right" v-if="!showChangePay">
          <font-awesome-icon icon="pencil-alt" @click="changePay"></font-awesome-icon>
        </button>
      </h3>
      <b-container fluid>
        <b-row class="m-1">
          <b-col sm="4">
            <label>Phone Number:</label>
          </b-col>
          <b-col sm="8">
            <span v-if="!showChangePay">{{phoneNumber}}</span>
            <b-form-input v-else v-model="phoneNumber"></b-form-input>
          </b-col>
        </b-row>
        <b-row class="m-1">
          <b-col sm="4">
            <label>Street:</label>
          </b-col>
          <b-col sm="8">
            <span v-if="!showChangePay">{{street}}</span>
            <b-form-input v-else v-model="street"></b-form-input>
          </b-col>
        </b-row>
        <b-row class="m-1">
          <b-col sm="4">
            <label>Zip Code:</label>
          </b-col>
          <b-col sm="8">
            <span v-if="!showChangePay">{{zip}}</span>
            <b-form-input v-else v-model="zip" :state="checkZip"></b-form-input>
          </b-col>
        </b-row>
        <b-row class="m-1">
          <b-col sm="4">
            <label>Card Number:</label>
          </b-col>
          <b-col sm="8">
            <span v-if="!showChangePay">{{cardNumber}}</span>
            <b-form-input v-else v-model="cardNumber" :state="checkCard"></b-form-input>
          </b-col>
        </b-row>
        <b-row class="m-1">
          <b-col sm="4">
            <label>Account Number:</label>
          </b-col>
          <b-col sm="8">
            <span v-if="!showChangePay">{{accountNumber}}</span>
            <b-form-input v-else v-model="accountNumber" :state="checkAccount"></b-form-input>
          </b-col>
        </b-row>
      </b-container>
      <h3 class="text-center" style="padding-top:10px; padding-bottom:10px;">
        Password
        <button class="btn btn-sm float-right" v-if="showChangePassword">
          <font-awesome-icon icon="check" @click="savePassword"></font-awesome-icon>
        </button>
        <button class="btn btn-sm float-right" v-if="showChangePassword">
          <font-awesome-icon icon="times" @click="cancelPassword"></font-awesome-icon>
        </button>
        <button class="btn btn-sm float-right" v-if="!showChangePassword">
          <font-awesome-icon icon="pencil-alt" @click="changePassword"></font-awesome-icon>
        </button>
      </h3>
      <b-container fluid>
        <b-row class="m-1" v-if="showChangePassword">
          <b-col sm="4">
            <label>New Password:</label>
          </b-col>
          <b-col sm="8">
            <b-form-input v-model="newPassword" :state="checkPassword"></b-form-input>
          </b-col>
        </b-row>
      </b-container>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { sha256 } from "js-sha256";
import { mapGetters, mapActions } from "vuex";

export default {
  data() {
    return {
      showChangeBasic: false,
      showChangePay: false,
      showChangePassword: false,
      isChecking: false,
      firstName: null,
      lastName: null,
      email: null,
      phoneNumber: null,
      street: null,
      zip: null,
      city: null,
      state: null,
      cardNumber: null,
      accountNumber: null,
      password: null,
      newPassword: ""
    };
  },
  mounted() {
    this.loadInfo();
  },
  methods: {
    ...mapActions(["addMessage", "setCurrentUser"]),
    loadInfo() {
      if (this.currentUser) {
        this.firstName = this.currentUser.firstName;
        this.lastName = this.currentUser.lastName;
        this.email = this.currentUser.email;
        this.phoneNumber = this.currentUser.phoneNumber;
        this.street = this.currentUser.street;
        this.zip = this.currentUser.zip;
        this.city = this.currentUser.city;
        this.state = this.currentUser.state;
        this.cardNumber = this.currentUser.cardNumber;
        this.accountNumber = this.currentUser.accountNumber;
        this.password = this.currentUser.password;
      }
    },
    changeBasic() {
      this.showChangeBasic = true;
    },
    changePassword() {
      this.showChangePassword = true;
    },
    changePay() {
      this.showChangePay = true;
    },
    cancelBasic() {
      this.showChangeBasic = false;
      this.loadInfo();
    },
    cancelPassword() {
      this.showChangePassword = false;
      this.loadInfo();
    },
    cancelPay() {
      this.showChangePay = false;
      this.loadInfo();
    },
    validBasic() {
      this.isChecking = true;
      var msg = "";
      if (!this.checkFirst) {
        msg += "First Name not empty. ";
      }
      if (!this.checkLast) {
        msg += "Last Name not empty. ";
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
    validPassword() {
      this.isChecking = true;
      if (!this.checkPassword) {
        this.addMessage({
          level: "danger",
          message: "Password at least 6 characters. "
        });
        return false;
      }
      return true;
    },
    validPay() {
      this.isChecking = true;
      var msg = "";
      if (this.checkZip === false) {
        msg += "Zip code should be 5 digits. ";
      }
      if (this.checkCard === false) {
        msg += "Card number should consist of digits. ";
      }
      if (this.checkAccount === false) {
        msg += "Account number should consist of digits. ";
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
    saveBasic() {
      if (!this.validBasic()) {
        return;
      }
      var _this = this;
      var func_argument =
        this.currentUser.cid + "|" + this.firstName + "|" + this.lastName;
      var request = {
        func_name: "update_online_client_basic",
        func_argument: func_argument
      };
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
          if (r.data.message === "Success") {
            _this.addMessage({
              level: "success",
              message: "Your basic information has been successfully updated!"
            });
            _this.showChangeBasic = false;
            _this.isChecking = false;
            _this.saveUser();
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data
            });
          }
        });
    },
    savePassword() {
      if (!this.validPassword()) {
        return;
      }
      var _this = this;
      var func_argument = this.currentUser.cid + "|" + sha256(this.newPassword);
      var request = {
        func_name: "update_online_client_password",
        func_argument: func_argument
      };
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
          if (r.data.message === "Success") {
            _this.addMessage({
              level: "success",
              message: "Your password has been successfully updated!"
            });
            _this.showChangePassword = false;
            _this.isChecking = false;
            _this.password = sha256(_this.newPassword);
            _this.saveUser();
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data
            });
          }
        });
    },
    savePay() {
      if (!this.validPay()) {
        return;
      }
      var _this = this;
      var func_argument =
        this.currentUser.cid +
        "|" +
        this.phoneNumber +
        "|" +
        this.cardNumber +
        "|" +
        this.accountNumber +
        "|" +
        this.street +
        "|" +
        this.zip;
      var request = {
        func_name: "update_online_client_pay",
        func_argument: func_argument
      };
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
          if (r.data.message === "Success") {
            _this.addMessage({
              level: "success",
              message: "Your payment information has been successfully updated!"
            });
            _this.showChangePay = false;
            _this.isChecking = false;
            _this.saveUser();
          } else if (
            r.data.message &&
            r.data.message.includes('is not present in table "region"')
          ) {
            _this.addMessage({
              level: "danger",
              message: "Zip cods is not valid!"
            });
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data
            });
          }
        });
    },
    saveUser() {
      var client = {
        cid: this.currentUser.cid,
        firstName: this.firstName,
        lastName: this.lastName,
        email: this.currentUser.email,
        phoneNumber: this.phoneNumber,
        street: this.street,
        zip: this.zip,
        city: this.currentUser.city, //FIXME
        state: this.currentUser.state,
        cardNumber: this.cardNumber,
        accountNumber: this.accountNumber,
        password: this.password
      };
      this.setCurrentUser(client);
    }
  },
  computed: {
    ...mapGetters(["currentUser"]),
    checkFirst() {
      return this.isChecking ? this.firstName !== "" : null;
    },
    checkLast() {
      return this.isChecking ? this.lastName !== "" : null;
    },
    checkPhone() {
      return this.isChecking ? this.phoneNumber.length >= 6 : null;
    },
    checkPassword() {
      return this.isChecking ? this.newPassword.length >= 6 : null;
    },
    checkZip() {
      return this.isChecking && this.zip
        ? /^\d+$/.test(this.zip) && this.zip.length == 5
        : null;
    },
    checkCard() {
      return this.isChecking && this.cardNumber
        ? /^\d+$/.test(this.cardNumber)
        : null;
    },
    checkAccount() {
      return this.isChecking && this.accountNumber
        ? /^\d+$/.test(this.accountNumber)
        : null;
    }
  },
  watch: {
    currentUser: function() {
      this.loadInfo();
    }
  }
};
</script>

<style scoped>
space {
  margin-bottom: 0.25rem !important;
}
</style>
