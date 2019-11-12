<template>
  <tr>
    <td data-th="Product">
      <div class="row">
        <div class="col-sm-2 d-none d-sm-block">
          <img :src="cartItem.image_url" alt="..." class="img-fluid" />
        </div>
        <div class="col-sm-10">
          <h6 class="nomargin">{{ cartItem.name }}</h6>
        </div>
      </div>
    </td>
    <td data-th="Price">${{ cartItem.price }}</td>
    <td data-th="Amount">
      <!-- <input
        type="number"
        class="form-control text-center"
        :value="cartItem.amount"
        @input="updateAmount"
        min="0"
      />-->
      <div class="additem">
        <b-input-group class="pull-right">
          <b-input-group-prepend>
            <b-button variant="success" @click="deleteItem">-</b-button>
          </b-input-group-prepend>
          <b-form-input type="text" :number="true" v-model="amount" @change="amountChanged"></b-form-input>
          <b-input-group-append>
            <b-button variant="success" @click="addItem">+</b-button>
          </b-input-group-append>
        </b-input-group>
      </div>
    </td>
    <td data-th="Subtotal" class="text-center">${{ subtotal.toFixed(2) }}</td>
    <td class="actions" data-th>
      <button class="btn btn-danger btn-sm" @click="removeItem">
        <font-awesome-icon icon="trash"></font-awesome-icon>
      </button>
    </td>
  </tr>
</template>

<script>
import { mapActions } from "vuex";
import {
  BInputGroup,
  BInputGroupAppend,
  BInputGroupPrepend,
  BButton,
  BFormInput
} from "bootstrap-vue";
export default {
  props: ["cartItem"],
  components: {
    "b-input-group": BInputGroup,
    "b-input-group-append": BInputGroupAppend,
    "b-input-group-prepend": BInputGroupPrepend,
    "b-button": BButton,
    "b-form-input": BFormInput
  },
  data() {
    return {
      amount: this.cartItem.amount
    };
  },
  methods: {
    ...mapActions(["addToChart"]),
    amountChanged() {
      this.cartItem.amount = this.amount;
      this.addToChart(this.cartItem);
    },
    addItem() {
      if (this.amount >= 9999) {
        this.amount = 9999;
      } else {
        this.amount += 1;
      }
      this.amountChanged();
    },
    deleteItem() {
      if (this.amount <= 0) {
        this.amount = 0;
      } else {
        this.amount -= 1;
      }
      this.amountChanged();
    },
    removeItem() {
      this.amount = 0;
      this.amountChanged();
    }
  },
  computed: {
    subtotal() {
      return this.amount * this.cartItem.price;
    }
  }
};
</script>
