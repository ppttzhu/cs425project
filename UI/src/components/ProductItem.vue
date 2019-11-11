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
        <h6 class="card-subtitle mb-2 remain">{{ item.item_left }} left in stock</h6>
        <div class="row">
          <p class="col-6 lead">${{ item.price }}</p>
          <p class="col-6">
            <button
              class="btn btn-success pull-right"
              :disabled="item.item_left === 0"
              @click="addItem"
            >Add to cart</button>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["item"],
  methods: {
    addItem() {},
    jumpToPage(page) {}
  },
  filters: {
    shortDescription(value) {
      if (value && value.length > 100) {
        return value.substring(0, 100) + "...";
      } else {
        return value;
      }
    }
  }
};
</script>

<style lang="scss" scoped>
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
