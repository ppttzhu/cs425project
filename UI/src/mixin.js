import axios from "axios";

export default {
  data() {},
  methods: {
    parseTable(tableString) {
      var plist = tableString.split("\n");
      var columns = plist[0].split("|");
      var ret = [];
      for (var i = 1; i < plist.length; i++) {
        if (plist[i] && plist[i] !== "") {
          var onep = {};
          var onepstring = plist[i].split("|");
          for (var j = 0; j < columns.length; j++) {
            onep[columns[j]] = onepstring[j];
          }
          ret.push(onep);
        }
      }
      return ret;
    },
    connectDatabase(request) {
      axios
        .post("", JSON.stringify(request), {
          headers: {
            "Content-Type": "application/json"
          }
        })
        .then(r => {
          console.log(request);
          if (r.data.message === "Success") {
            return r.data.returnValue;
          } else {
            _this.addMessage({
              level: "danger",
              message: r.data
            });
          }
        })
        .catch(e =>
          _this.addMessage({
            level: "danger",
            message: e
          })
        );
    }
  }
};
