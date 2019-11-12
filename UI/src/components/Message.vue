<template>
  <div :class="(showMessageBar?'':'d-none') + '  message-bar'">
    <div :class="levelStyle">
      <button type="button" class="close" aria-label="Close" @click="closeMessageBar">
        <span aria-hidden="true">&times;</span>
      </button>
      <div>{{ this.messageGroup.message }}</div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      showMessageBar: false
    };
  },
  computed: {
    ...mapGetters(["messageGroup"]),
    levelStyle() {
      return (
        "col-12 panel panel-" +
        this.messageGroup.level +
        " " +
        (this.showMessageBar ? "" : "hidden")
      );
    }
  },
  methods: {
    closeMessageBar() {
      this.showMessageBar = false;
    }
  },
  watch: {
    messageGroup: function() {
      this.showMessageBar = !(this.messageGroup.message === "");
    }
  }
};
</script>

<style scoped>
.message-bar {
  position: fixed;
  top: 0;
  left: 50%;
  width: 50%;
  min-height: 50px;
  z-index: 9999;
  margin-left: -25%;
}

.message-bar .panel {
  border-color: transparent;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
  padding-right: 25px;
}

.panel {
  padding: 10px 15px;
}

.panel-danger {
  background-color: #d9534f;
  color: #fff;
}

.panel-success {
  background-color: #5cb85c;
  color: #fff;
}

.panel-warning {
  background-color: #f0ad4e;
  color: #fff;
}
</style>
