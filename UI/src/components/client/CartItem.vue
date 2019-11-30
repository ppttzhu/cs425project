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
    <td data-th="Price" class="text-center">${{ cartItem.price }}</td>
    <td data-th="Amount">
      <b-form-input
        type="number"
        :number="true"
        v-model="amount"
        @change="amountChanged"
        min="0"
        max="9999"
      ></b-form-input>
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
export default {
  props: ["cartItem"],
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
