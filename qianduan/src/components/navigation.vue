// 底部导航栏
<template>
  <div class="nav">
    <div
      v-for="(item, index) in navigation"
      :key="index"
      @click="n_click(item.path, index)"
    >
      <div :class="{ active: index == current }">
        <i :class="item.icon"></i>
      </div>
      <div :class="{ active: index == current }">{{ item.name }}</div>
    </div>
  </div>
</template>

<script>
export default {
  // updated() {
  //   this.isLogin = sessionStorage.getItem('user')
  // },
  data() {
    return {
      // 是否登录
      // isLogin:null,
      // 底部导航栏
      navigation: [
        {
          name: "首页",
          icon: "el-icon-s-home",
          path: "home",
          //   index: 0
        },
        {
          name: "发现",
          icon: "el-icon-discover",
          path: "found",
          //   index: 1
        },
        {
          name: "购物车",
          icon: "el-icon-shopping-cart-2",
          path: "shopping",
          //   index: 2
        },
        {
          name: "我的",
          icon: "el-icon-user",
          path: "my",
          //   index: 3
        },
      ],
      current: 0,
      //   yanse: '#a2a2a2'
      //   335a89
    };
    
  },
  methods: {
    n_click(res, res1) {
      if(!this.isLogin) {
        this.$router.push({name:'login'})
      }else {
        this.$router.push({ name: res });
        this.current = res1;
      }
    },
  },
  computed: {
    o_route() {
      return this.$route;
    },
    isLogin() {
      return sessionStorage.getItem('user')
    }
  },
  watch: {
    // o_route: {
    // //   immediate: true, //初始化时调用handler
    // //   deep:true,//深度监视
    //   handler(val) {
    //     console.log(val);
    //   },
    // },
    // 简写形式
    o_route: {
      immediate: true,
      handler(val) {
        let aa = val.name;
        if (aa == "home") {
          this.current = 0;
        } else if (aa == "found") {
          this.current = 1;
        } else if (aa == "shopping") {
          this.current = 2;
        } else if (aa == "my") {
          this.current = 3;
        }
      },
    },

  },
};
</script>

<style scoped>
.nav {
  width: 100%;
  height: 100%;
  display: flex;
}
.nav > div {
  flex: 1 !important;
  position: relative !important;
  top: 0;
}
.nav > div > div:nth-of-type(1) {
  width: 100%;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  color: rgb(172, 172, 172);
  font-size: 24px;
  text-align: center;
}
.nav > div > div:nth-of-type(2) {
  width: 100%;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  font-size: 12px;
  color: rgb(172, 172, 172);
  text-align: center;
  top: 29px;
}
.active {
  color: #335a89 !important;
}
</style>