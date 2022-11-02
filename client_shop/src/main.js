import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI);
import Element from 'element-ui';
Vue.use(Element, { size: 'small', zIndex: 3000 });
import VueRouter from "vue-router"
Vue.use(VueRouter)
import axios from 'axios'
Vue.prototype.$http = axios
Vue.prototype.$bus = new Vue()
import routes from './router/router.js'
var router = new VueRouter({
  routes
})



Vue.prototype.$status = 1
import './assets/css/index.css'
// import './assets/css/tongji.css'

import WebIM from 'easemob-websdk'
const conn = new WebIM.connection({
  appKey: '1159220831140761#shop'
})
Vue.prototype.hx_conn = conn
Vue.config.productionTip = false
new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
