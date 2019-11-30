<template>
  <tbody>
    <tr>
      <td data-th="Product">
        <div class="row">
          <div class="col-sm-2 d-none d-sm-block">
            <img :src="orderItem.image_url" alt="..." class="img-fluid" />
          </div>
          <div class="col-sm-10">
            <h6 class="nomargin">{{ orderItem.name }}</h6>
          </div>
        </div>
      </td>
      <td data-th="Price" class="text-center">${{ orderItem.price }}</td>
      <td data-th="Amount" class="text-center">{{ orderItem.amount }}</td>
      <td data-th="Date" class="text-center">{{ orderItem.date }}</td>
      <td data-th="tracking_number" class="text-center">{{ orderItem.tracking_number }}</td>
      <td class="actions text-center" data-th>
        <button class="btn btn-sm" @click="writeReview">
          <font-awesome-icon icon="pencil-alt" v-if="!orderItem.rating"></font-awesome-icon>
          <font-awesome-icon icon="eye" v-else></font-awesome-icon>
        </button>
      </td>
    </tr>
    <tr v-if="showReview">
      <td colspan="3" data-th="review" class="text-center">
        <b-form-input type="text" v-model="review"></b-form-input>
      </td>
      <td colspan="2" data-th="rating" class="text-center">
        <star-rating v-model="rating" :show-rating="false" :star-size="24"></star-rating>
      </td>
      <td data-th="submit">
        <button
          class="btn btn-success btn-sm"
          @click="submitReview"
          :disabled="!submitActive"
        >Submit</button>
      </td>
    </tr>
  </tbody>
</template>

<script>
import axios from "axios";
import { mapActions } from "vuex";
import StarRating from "vue-star-rating";

export default {
  props: ["orderItem"],
  components: {
    "star-rating": StarRating
  },
  data() {
    return {
      showReview: false,
      rating: this.orderItem.rating,
      review: this.orderItem.review
    };
  },
  methods: {
    ...mapActions(["addMessage"]),
    writeReview() {
      this.showReview = !this.showReview;
    },
    submitReview() {
      var func_argument =
        this.orderItem.oid + "|" + this.rating + "|" + this.review;
      var request = {
        func_name: "review_order",
        func_argument: func_argument
      };
      var _this = this;
      axios
        .post("", JSON.stringify(request), {
          headers: {
            "Content-Type": "application/json"
          }
        })
        .then(r => {
          console.log(request);
          if (r.data.message === "Success") {
            _this.addMessage({
              level: "success",
              message: "Your review has been successfully submitted!"
            });
            _this.$emit("submitted");
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data
            });
          }
        })
        .catch(e => {
          _this.addMessage({
            level: "danger",
            message: e
          });
        });
      this.showReview = false;
    }
  },
  computed: {
    submitActive() {
      return this.rating && this.review;
    }
  }
};
</script>
