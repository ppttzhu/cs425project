(function(t){function a(a){for(var e,i,o=a[0],l=a[1],c=a[2],p=0,v=[];p<o.length;p++)i=o[p],Object.prototype.hasOwnProperty.call(r,i)&&r[i]&&v.push(r[i][0]),r[i]=0;for(e in l)Object.prototype.hasOwnProperty.call(l,e)&&(t[e]=l[e]);u&&u(a);while(v.length)v.shift()();return s.push.apply(s,c||[]),n()}function n(){for(var t,a=0;a<s.length;a++){for(var n=s[a],e=!0,o=1;o<n.length;o++){var l=n[o];0!==r[l]&&(e=!1)}e&&(s.splice(a--,1),t=i(i.s=n[0]))}return t}var e={},r={app:0},s=[];function i(a){if(e[a])return e[a].exports;var n=e[a]={i:a,l:!1,exports:{}};return t[a].call(n.exports,n,n.exports,i),n.l=!0,n.exports}i.m=t,i.c=e,i.d=function(t,a,n){i.o(t,a)||Object.defineProperty(t,a,{enumerable:!0,get:n})},i.r=function(t){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},i.t=function(t,a){if(1&a&&(t=i(t)),8&a)return t;if(4&a&&"object"===typeof t&&t&&t.__esModule)return t;var n=Object.create(null);if(i.r(n),Object.defineProperty(n,"default",{enumerable:!0,value:t}),2&a&&"string"!=typeof t)for(var e in t)i.d(n,e,function(a){return t[a]}.bind(null,e));return n},i.n=function(t){var a=t&&t.__esModule?function(){return t["default"]}:function(){return t};return i.d(a,"a",a),a},i.o=function(t,a){return Object.prototype.hasOwnProperty.call(t,a)},i.p="/cs425project/";var o=window["webpackJsonp"]=window["webpackJsonp"]||[],l=o.push.bind(o);o.push=a,o=o.slice();for(var c=0;c<o.length;c++)a(o[c]);var u=l;s.push([0,"chunk-vendors"]),n()})({0:function(t,a,n){t.exports=n("56d7")},"43aa":function(t,a,n){"use strict";var e=n("63b8"),r=n.n(e);r.a},"56d7":function(t,a,n){"use strict";n.r(a);n("e260"),n("e6cf"),n("cca6"),n("a79d");var e=n("2b0e"),r=function(){var t=this,a=t.$createElement,n=t._self._c||a;return n("div",{attrs:{id:"app"}},[n("ProductList")],1)},s=[],i=function(){var t=this,a=t.$createElement,n=t._self._c||a;return n("div",{attrs:{id:"product-list"}},[t._v(" hhah "),n("Header"),n("h1",[t._v("CS425Project")])],1)},o=[],l=(n("bc3a"),function(){var t=this,a=t.$createElement,n=t._self._c||a;return n("nav",{staticClass:"navbar navbar-expand-sm navbar-dark bg-dark",attrs:{role:"navigation"}},[n("div",{staticClass:"container"},[n("router-link",{staticClass:"navbar-brand mr-auto",attrs:{to:"/"}},[t._v("Online Store")]),n("button",{staticClass:"navbar-toggler",attrs:{type:"button","data-toggle":"collapse","data-target":"#navbarTop","aria-controls":"navbarTop","aria-expanded":"false","aria-label":"Toggle navigation"},on:{click:t.toggleNavbar}},[n("span",{staticClass:"navbar-toggler-icon"})]),n("div",{staticClass:"collapse navbar-collapse",class:{show:t.isNavOpen},attrs:{id:"navbarTop"}},[n("ul",{staticClass:"navbar-nav mr-auto"}),n("ul",{staticClass:"nav navbar-nav"},[t.isLoggedIn?t._e():n("router-link",{staticClass:"nav-item",attrs:{to:"/login",tag:"li","active-class":"active"}},[n("a",{staticClass:"nav-link"},[t._v("Login")])]),t.isLoggedIn?n("li",{staticClass:"li-pointer nav-item"},[n("a",{staticClass:"nav-link",on:{click:t.logout}},[t._v("Logout "+t._s(t.userEmail))])]):t._e(),t.isLoggedIn?t._e():n("router-link",{staticClass:"nav-item",attrs:{to:"/register",tag:"li","active-class":"active"}},[n("a",{staticClass:"nav-link"},[t._v("Register")])]),n("li",[n("router-link",{staticClass:"btn btn-success navbar-btn",attrs:{to:"/cart",tag:"button"}},[t._v(" Checkout "),n("span",{staticClass:"badge badge-light"},[t._v(t._s(t.numItems)+" ($ "+t._s(t.cartValue)+")")])])],1)],1)])],1)])}),c=[],u=(n("13d5"),{name:"Header",data:function(){return{isNavOpen:!1}},computed:{numItems:function(){return this.cartItemList.reduce((function(t,a){return t+=a.quantity,t}),0)},userEmail:function(){return this.isLoggedIn?this.currentUser.email:""}}}),p=u,v=(n("43aa"),n("2877")),d=Object(v["a"])(p,l,c,!1,null,"6a13dcd4",null),f=d.exports,b={name:"ProductList",components:{Header:f},data:function(){return{request:{id:"7",name:"vue"},content:"Fetching data",msg:null}}},g=b,m=(n("92e5"),Object(v["a"])(g,i,o,!1,null,null,null)),h=m.exports,_={name:"app",components:{ProductList:h}},y=_,C=Object(v["a"])(y,r,s,!1,null,null,null),O=C.exports;e["a"].config.productionTip=!1,new e["a"]({render:function(t){return t(O)}}).$mount("#app")},"63b8":function(t,a,n){},"92e5":function(t,a,n){"use strict";var e=n("baaa"),r=n.n(e);r.a},baaa:function(t,a,n){}});
//# sourceMappingURL=app.451f1bee.js.map