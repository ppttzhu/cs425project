<template>
  <div class="mb-3 col-sm-6 col-md-4 item list-group-item">
    <div class="thumbnail card">
      <div class="img-event intrinsic">
        <img :src="item.image_url" alt class="grow thumbnail-image card-img-top intrinsic-item p-3" />
      </div>
      <div class="card-body">
        <h5 class="card-title">
          <a href="#" @click.prevent="jumpToPage('Register')">{{ item.name }}</a>
        </h5>
        <h6 class="card-subtitle mb-2 remain" v-if="isAdmin">
          {{ item.warehouseAmount}} left in warehouse
          <span
            v-if="item.storeAmount !== undefined"
          >, {{ item.storeAmount}} left in store</span>
        </h6>
        <h6
          class="card-subtitle mb-2 remain"
          v-if="!isAdmin"
        >{{ item.item_left ? item.item_left : 0}} left in stock</h6>
        <h6 class="card-subtitle mb-2 remain" v-if="!isAdmin">
          <star-rating
            v-if="rating"
            v-model="rating"
            :show-rating="false"
            :read-only="true"
            :star-size="24"
          ></star-rating>
        </h6>
        <div class="row">
          <div class="col-9 lead">${{ item.price }}</div>
          <div class="additem">
            <b-input-group class="pull-right">
              <b-input-group-prepend>
                <b-button variant="success" @click="removeItem">-</b-button>
              </b-input-group-prepend>
              <b-form-input type="text" :number="true" v-model="amount" @change="amountChanged"></b-form-input>
              <b-input-group-append>
                <b-button variant="success" @click="addItem">+</b-button>
              </b-input-group-append>
            </b-input-group>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import StarRating from "vue-star-rating";

export default {
  props: ["item"],
  components: {
    "star-rating": StarRating
  },
  data() {
    return {
      amount: 0
    };
  },
  methods: {
    amountChanged() {
      this.$emit("amountChanged", this.item, this.amount);
    },
    addItem() {
      if (this.amount >= 9999) {
        this.amount = 9999;
      } else {
        this.amount += 1;
      }
      this.amountChanged();
    },
    removeItem() {
      if (this.amount <= 0) {
        this.amount = 0;
      } else {
        this.amount -= 1;
      }
      this.amountChanged();
    }
  },
  computed: {
    ...mapGetters(["isAdmin"]),
    rating() {
      if (this.item.client_rating) {
        return parseInt(this.item.client_rating);
      } else {
        return null;
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.additem {
  width: 130px;
}
.pull-right {
  float: right;
}
div.card {
  height: 100%;
}
.card-text {
  font-size: 0.875rem;
}
.remain {
  color: #d17581;
}
.grow {
  transition: all 0.2s ease-in-out;
}
.grow:hover {
  transform: scale(1.1);
}
.list-group-item {
  float: none;
  width: 100%;
  background-color: #fff;
  margin-bottom: 30px;
  -ms-flex: 0 0 100%;
  flex: 0 0 100%;
  max-width: 100%;
  padding: 0 1rem;
  border: 0;
  .thumbnail {
    display: inline-block;
    width: 100%;
  }
  .img-event {
    width: 20%;
    float: left;
    padding: 0 !important;
    margin: 0;
    height: auto;
  }
  .thumbnail-image {
    position: static;
  }
  .card-body {
    float: left;
    width: 80%;
    margin: 0;
  }
  @media (max-width: 767.98px) {
    .img-event {
      width: 30%;
      float: left;
      padding: 0 !important;
      margin: 0;
    }
    .card-body {
      float: left;
      width: 70%;
      margin: 0;
    }
  }
}
.item.list-group-item:before,
.item.list-group-item:after {
  display: table;
  content: " ";
}
.item.list-group-item:after {
  clear: both;
}
</style>
