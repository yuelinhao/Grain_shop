import Vue from 'vue';
import App from './App.vue';
import router from './router';
import ElementUI from 'element-ui';
import VueI18n from 'vue-i18n';
import { messages } from './components/common/i18n';
import 'element-ui/lib/theme-chalk/index.css'; // 默认主题
// import './assets/css/theme-green/index.css'; // 浅绿色主题
import './assets/css/icon.css';
import './components/common/directives';
import 'babel-polyfill';

/**
 * 
 * 以下是 环信的代码
 */
// 导入
import WebIM from 'easemob-websdk'

// 初始化 环信
const conn = new WebIM.connection({
  appKey: "1159220831140761#shop",
});

// 监听消息
// conn.addEventHandler("connection&message", {
//   onConnected: () => {
//     console.log("111111")
//   },
//   onTextMessage: (message) => {
//     console.log("收到消息了。。。")
//     console.log(message)
//   }
// })
// conn.addEventHandler("contactEvent", {
//   // 当前用户收到好友请求。用户 B 向用户 A 发送好友请求，用户 A 收到该事件。
//   onContactInvited: function (msg) {
//     console.log("222222222")
//     console.log("收到好友添加的请求")
//     console.log(msg)
//   }
// })

Vue.prototype.hx_conn = conn

/**
 * 
 * 以上 是  环信的代码
 */


Vue.config.productionTip = false;
Vue.use(VueI18n);
Vue.use(ElementUI, {
    size: 'small'
});
const i18n = new VueI18n({
    locale: 'zh',
    messages
});

//使用钩子函数对路由进行权限跳转
router.beforeEach((to, from, next) => {
    document.title = `${to.meta.title} | vue-manage-system`;
    const role = localStorage.getItem('boss_info');
    if (!role && to.path !== '/login') {
        next('/login');
    } else {
        // 简单的判断IE10及以下不进入富文本编辑器，该组件不兼容
        if (navigator.userAgent.indexOf('MSIE') > -1 && to.path === '/editor') {
            Vue.prototype.$alert('vue-quill-editor组件不兼容IE10及以下浏览器，请使用更高版本的浏览器查看', '浏览器不兼容通知', {
                confirmButtonText: '确定'
            });
        } else {
            next();
        }
    }
});
// router.beforeEach((to, from, next) => {
//     document.title = `${to.meta.title} | vue-manage-system`;
//     const role = localStorage.getItem('boss_info');
//     if (!role && to.path !== '/login') {
//         next('/login');
//     } else if (to.meta.permission) {
//         // 如果是管理员权限则可进入，这里只是简单的模拟管理员权限而已
//         role === 'admin' ? next() : next('/403');
//     } else {
//         // 简单的判断IE10及以下不进入富文本编辑器，该组件不兼容
//         if (navigator.userAgent.indexOf('MSIE') > -1 && to.path === '/editor') {
//             Vue.prototype.$alert('vue-quill-editor组件不兼容IE10及以下浏览器，请使用更高版本的浏览器查看', '浏览器不兼容通知', {
//                 confirmButtonText: '确定'
//             });
//         } else {
//             next();
//         }
//     }
// });

new Vue({
    router,
    i18n,
    render: h => h(App)
}).$mount('#app');
