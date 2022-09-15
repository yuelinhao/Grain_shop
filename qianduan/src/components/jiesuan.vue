<template>
  <div class="jie">
    <el-container>
      <el-header>
        <i class="el-icon-arrow-left" @click="fan_home"></i>
        <span class="span1">确认订单</span></el-header
      >
      <el-main class="main">
        <div class="one">
          <div class="circle">
            <i class="el-icon-location-outline"></i>
          </div>
          <div class="content" v-if="this.$status == 1">
            <span class="addre"
              ><strong
                >{{ user_arr.user_ress }} {{ user_arr.more_address }}</strong
              ></span
            ><br />
            <div class="span2">
              <span>{{ user_arr.user_name2 }}</span>
              <span>{{ user_arr.user_phone3 }}</span>
            </div>
          </div>
          <div class="content" v-if="this.$status == 0">
            <span class="addre"
              ><strong
                >{{ user_arr1.user_ress }} {{ user_arr1.more_addres }}</strong
              ></span
            ><br />
            <div class="span2">
              <span>{{ user_arr1.user_name2 }}</span>
              <span>{{ user_arr1.user_phone3 }}</span>
            </div>
          </div>
          <i
            class="el-icon-arrow-right"
            style="color: gray"
            @click="modify_fn"
          ></i>
        </div>
        <div class="two" v-for="(item, index) in shop_goods" :key="index">
          <div>
            <img
              :src="'http://192.168.0.135:3000/img/' + item.g_img + '.jpg'"
              alt=""
            />
          </div>
          <div>
            <div>
              <span style="display: inline-block; width: 44vw">{{
                item.g_name
              }}</span>
              <span
                style="
                  color: rgb(235, 73, 38);
                  font-size: 0.75rem;
                  margin-left: 3vw;
                "
                >￥<span style="font-size: 0.875rem">{{
                  item.g_price
                }}</span></span
              >
            </div>
            <div style="color: gray; font-size: 0.8125rem">
              <span>{{ item.g_size }}公斤/袋</span>
              <span style="margin-left: 35vw"
                >×<span>{{ item.g_number }}</span></span
              >
            </div>
          </div>
        </div>

        <!-- <div class="three">
            <div class="thone">
                <div class="circle">
                    <i class="el-icon-phone-outline"></i>
                  </div>
            </div>
            <div class="thtwo">
                <span><strong>号码保护</strong></span>
                <img src="../assets/wenhao.png" width=".9375rem" height=".9375rem"><br>
                <span class="span3">隐藏收件人真实手机号，保护隐私</span>
            </div>
            <div class="ththr"></div>
        </div> -->
      </el-main>
      <el-footer class="foot">
        <div class="five"></div>
        <div class="six">
          <div class="num">
            <span>共</span> <span>{{ number }}</span
            ><span>件</span>
          </div>
          <br />
          <span>合计：</span>
          <div class="total">
            <span>￥</span><span>{{ total_price }}</span>
          </div>
          <div class="right_jiesuan">
            <span class="right_jiesuan_jiesuan" @click="goPay">确认付款</span>
          </div>
        </div>
      </el-footer>
    </el-container>
  </div>
</template>
<script>
import Vue from "vue";
export default {
  name: "jiesuan",
  data() {
    return {
      shop_goods: [],
      // 总件数
      number: 0,
      total_price: 0,
      user_arr: [],
      user_arr1: [],
    };
  },
  created() {
    // let {shop_goods,total_price} = this.$route.params
    // this.shop_goods = shop_goods
    // this.total_price = total_price
    // this.shop_goods.forEach((item)=> {
    //   this.number+=item.g_number
    // })
    let goods = JSON.parse(localStorage.getItem("goods"));
    this.shop_goods = goods;
    let money = 0;
    let number = 0;
    for (var i = 0; i < goods.length; i++) {
      money += goods[i].g_number * goods[i].g_price;
      number += goods[i].g_number;
    }
    this.total_price = money;
    this.number = number;
    // 订单个人信息
    this.$http
      .post("http://192.168.0.135:3000/get_address", {
        user_acc: JSON.parse(sessionStorage.getItem("user"))[0].user_acc,
      })
      .then((res) => {
        this.user_arr = res.data.value[0];
      });
    this.user_arr1 = this.$route.params.items;
    if (!this.user_arr1) {
      Vue.prototype.$status = 1;
    }
  },
  beforeRouteEnter(to, from, next) {
    if (from.name == "detail_addres") {
      Vue.prototype.$status = 0;
    } else {
      Vue.prototype.$status = 1;
    }
    next();
  },
  // beforeRouteLeave(to,from,next) {
  //   next()
  // },
  methods: {
    fan_home() {
      console.log("----------------");
      this.$router.push("/shopping");
    },
    modify_fn() {
      this.$router.push({ name: "detail_addres" });
    },
    // 确认付款
    goPay() {
      let shijian = new Date().getTime();
      sessionStorage.setItem("shijian", shijian);
      let g_arr = []
      JSON.parse(localStorage.getItem("goods")).forEach((item) => {
        g_arr.push({ g_name: item.g_name, g_number: item.g_number });
      });
      var o_id = sessionStorage.getItem('shijian')
      this.$http.post("http://192.168.0.135:3000/o_wait_pay", {
        o_id,
        g_arr: JSON.stringify(g_arr),
        user_acc: JSON.parse(sessionStorage.getItem("user"))[0].user_acc,
        o_price: this.total_price,
        u_name:this.user_arr.user_name2,
        u_address:`${this.user_arr.user_ress}${this.user_arr.more_address}`,
        u_phone:this.user_arr.user_phone3,
        g_sum:this.number,
      });
      this.$bus.$emit("goPay", { sure: 1, money: this.total_price });
    },
  },
};
</script>

<style scoped>
/* 更多 */
.jie .el-icon-arrow-right {
  position: absolute;
  top: 6.8vw;
  right: 2vw;
}
/* 返回 */
.jie .el-icon-arrow-left {
  margin-right: 2vw;
}
.jie {
  width: 100vw;
  height: 100vh;
  overflow: hidden;
}
.el-container.is-vertical {
  width: 100vw;
  height: 100vh;
}
.el-header {
  background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
  color: white;
  line-height: 0.625rem;
  padding: 1.375rem 0.9375rem;
}
.el-icon-arrow-left {
  font-size: 1.25rem;
}
.span1 {
  font-size: 1.125rem;
  font-weight: 700;
}
.main {
  flex-direction: column;
  background-color: rgb(246, 246, 246);
  overflow: scroll;
}
.one {
  width: 88vw;
  height: 18vw;
  background-color: white;
  border-radius: 0.375rem;
  display: flex;
  margin-bottom: 2vw;
  position: relative;
}

.two {
  width: 88vw;
  height: 30vw;
  background-color: white;
  border-radius: 0.375rem;
  display: flex;
  margin-bottom: 2vw;
}
.two > div:nth-of-type(1) {
  flex: 1;
  position: relative;
}
.two > div:nth-of-type(1) > img {
  position: absolute;
  width: 18vw;
  height: 24vw;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  background-color: rgb(41, 121, 190);
}
.two > div:nth-of-type(2) {
  position: relative;
  flex: 2;
}
.two > div:nth-of-type(2) > div {
  width: 100%;
  height: 6vw;
  margin-top: 5vw;
}
.three {
  flex: 2;
  display: flex;
}
.three > div {
  padding: 0.5rem;
  margin: 0.4375rem;
}
.foot {
  display: flex;
}
.five {
  flex: 1;
}
.six {
  flex: 3;
}

.num {
  display: inline-block;
  font-size: 0.8125rem;
  color: gray;
}
.total {
  display: inline-block;
  font-size: 0.875rem;
  font-family: "微软雅黑";
  color: rgb(235, 73, 38);
}

.right_jiesuan {
  width: 7.4375rem;
  height: 6%;
  background: linear-gradient(
    58deg,
    rgb(235, 138, 72) 13%,
    rgb(235, 74, 39) 100%
  );
  border-radius: 3.125rem;
  display: flex;
  justify-content: center;
  align-items: center;
  position: fixed;
  top: 92vh;
  right: 1.9375rem;
}
.right_jiesuan_jiesuan {
  font-size: 1.125rem;
  font-family: "微软雅黑";
  color: #ffffff;
  letter-spacing: 0.125rem;
}
.circle {
  width: 2.0625rem;
  height: 2.0625rem;
  border-radius: 100%;
  margin: 0.625rem;
  background: linear-gradient(
    58deg,
    rgb(235, 138, 72) 13%,
    rgb(235, 74, 39) 100%
  );
}
.el-icon-location-outline {
  color: white;
  font-size: 1.25rem;
  padding: 0.375rem;
}
.el-icon-phone-outline {
  color: white;
  font-size: 1.25rem;
  padding: 0.375rem;
}
.content {
  padding: 0.4375rem;
}
.span2 {
  padding: 0.3125rem;
  color: gray;
}

.thone {
  flex: 1;
}
.thtwo {
  flex: 10;
  font-size: 1rem;
}
.ththr {
  flex: 1;
}
.span3 {
  color: gray;
}
</style>