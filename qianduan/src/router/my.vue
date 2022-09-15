<template>
  <div class="my">
    <div v-if="tui" @click="tui_fn" class="tui">
      <div class="tui_body">
        <!-- <img @click="qx_fn" style="width:30px;height:30px;float: right;margin-left: 272px;" src="@/assets/img/取消.png" alt=""> -->
        <div><span>是否确认退出登录？</span></div>
        <div class="an">
          <div @click="qx_fn"><span class="a_1">取消</span></div>
          <div @click="qr_fn"><span class="a_2">确认</span></div>
        </div>
      </div>
    </div>
    <div class="my_top" @click="tiaozhuan">
      <img src="@/static/my_img/个人中心头部.png" alt="" />
      <div class="my_title">个人中心</div>
      <div class="my_avatar">
        <div class="my_avatar_img" v-if="my_user.length > 0">
          <img
            :src="
              my_user[0].user_img
                ? 'http://192.168.0.135:3000/img/' +
                  my_user[0].user_img +
                  '.jpg'
                : avatar
            "
            alt=""
          />
        </div>

        <div class="my_avatar_img" v-if="my_user.length == 0">
          <img :src="avatar" alt=""/>
        </div>

        <div class="my_avatar_name" v-if="my_user.length >0">{{my_user[0].user_name}}</div>

        <div class="my_avatar_name" v-if="my_user.length == 0">设置昵称</div>

      </div>
    </div>
    <div class="my_content">
      <div class="my_content_1" v-if="my_user.length > 0">
        <div @click="yve" class="my_content_11">
          <div>{{ my_user[0].user_money }}</div>
          <div>余额(元)</div>
        </div>
        <span>丨</span>
        <div class="my_content_12">
          <div>{{ my_user[0].user_integral }}</div>
          <div>积分</div>
        </div>
        <span>丨</span>
        <div @click="shou_cang" class="my_content_13">
          <div>{{ my_user[0].user_collect }}</div>
          <div>收藏</div>
        </div>
      </div>

      <div class="my_content_1" v-if="my_user.length == 0">
        <div @click="yve" class="my_content_11">
          <div>0</div>
          <div>余额(元)</div>
        </div>
        <span>丨</span>
        <div class="my_content_12">
          <div>0</div>
          <div>积分</div>
        </div>
        <span>丨</span>
        <div @click="shou_cang" class="my_content_13">
          <div>0</div>
          <div>收藏</div>
        </div>
      </div>

      <div class="my_content_2">
        <div class="my_content_21">
          <div>订单信息</div>
          <div @click="ck_fn">
            查看全部订单<span class="el-icon-arrow-right"></span>
          </div>
        </div>
        <div class="my_content_22">
          <div
            class="my_content_22_list"
            @click="qb_fn(index)"
            v-for="(item, index) in my_order"
            :key="index"
          >
            <div>
              <div>
                <img :src="item.url" alt="" />
              </div>
            </div>
            <div>{{ item.title }}</div>
          </div>
        </div>
      </div>
      <div class="my_content_3">
        <div
          class="my_content_3_list"
          @click="tong_ji(index)"
          v-for="(item, index) in my_table"
          :key="index"
        >
          <div class="my_content_3_list_1">
            <img :src="item.url" alt="" />
          </div>
          <div class="my_content_3_list_2">{{ item.title }}</div>
          <div class="my_content_3_list_3">
            <i class="el-icon-arrow-right"></i>
          </div>
        </div>
      </div>
    </div>
    <!-- <div class="view" v-if="0">
      <router-view></router-view>
    </div> -->
  </div>
</template>

<script>
export default {
  created() {
    this.$http
      .post("http://192.168.0.135:3000/get_user_info", {
        user_acc: JSON.parse(sessionStorage.getItem("user"))[0].user_acc,
      })
      .then((res) => {
        this.my_user = res.data.value;
      });
  },
  data() {
    return {
      tui: false,
      // 默认头像
      avatar: require("@/static/avatar/1.png"),
      // 默认姓名
      user_name: "王可可",
      // 个人信息
      my_user: [],
      my_order: [
        {
          title: "待付款",
          url: require("@/static/my_img/待付款.png"),
        },
        {
          title: "待发货",
          url: require("@/static/my_img/在装车.png"),
        },
        {
          title: "已发货",
          url: require("@/static/my_img/已发货.png"),
        },
        {
          title: "已收货",
          url: require("@/static/my_img/已提交.png"),
        },
      ],
      my_table: [
        {
          title: "账户安全",
          url: require("@/static/my_img/账户安全.png"),
        },
        {
          title: "订单统计",
          url: require("@/static/my_img/订单统计.png"),
        },
        {
          title: "我的对账单",
          url: require("@/static/my_img/我的对账单.png"),
        },
        {
          title: "推荐",
          url: require("@/static/my_img/推荐.png"),
        },
        {
          title: "消息",
          url: require("@/static/my_img/消息.png"),
        },
        {
          title: "客服",
          url: require("@/static/my_img/客服.png"),
        },
        {
          title: "退出",
          url: require("@/assets/img/退出登录.png"),
        },
      ],
    };
  },
  methods: {
    yve() {
      this.$router.push({ name: "balance" });
    },
    shou_cang() {
      this.$router.push({ name: "collection" });
    },
    tiaozhuan() {
      this.$router.push({ name: "my_msg" });
    },
    ck_fn() {
      this.$router.push({
        name: "aa",
        params: { isAll: true, type: "o_SelectAll" },
      });
    },
    tong_ji(cc) {
      if (cc == 1) {
        this.$router.push("/tong_ji");
      } else if (cc == 2) {
        this.$router.push("/dui_zhang");
      } else if (cc == 3) {
        this.$router.push("/tui_jian");
      } else if (cc == 0) {
        this.$router.push("/safe");
      } else if (cc == 4) {
        this.$router.push("/msg");
      } else if (cc == 5) {
        this.$router.push("/liaotian");
      } else if (cc == 6) {
        // console.log("退出");
        this.tui = !this.tui;
      }
    },
    tui_fn() {
      this.tui = false;
      // console.log(2222);
    },
    qx_fn() {
      this.tui = false;
      // console.log("取消");
    },
    qr_fn() {
      this.tui = false;
      // console.log("确认");
      this.hx_conn.close();
      sessionStorage.removeItem('user')
      localStorage.removeItem('token_liu')
      this.$router.push('/login')
    },
    qb_fn(cc) {
      if (cc == 0) {
        this.$router.push({ name: "aa", params: { isAll: false, type: cc } });
      } else if (cc == 1) {
        this.$router.push({ name: "aa", params: { isAll: false, type: cc } });
      } else if (cc == 2) {
        this.$router.push({ name: "aa", params: { isAll: false, type: cc } });
      } else if (cc == 3) {
        this.$router.push({ name: "aa", params: { isAll: false, type: cc } });
      }
    },
  },
};
</script>

<style scoped>
.tui {
  width: 100vw;
  height: 100vh;
  position: absolute;
  z-index: 44;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: rgba(129, 129, 129, 0.5);
}
.tui_body {
  width: 300px;
  height: 100px;
  position: absolute;
  z-index: 55;
  display: flex;
  text-align: center;
  flex-direction: column;
  background-color: white;
}
.tui_body > div:nth-child(1) {
  flex: 1.5;
}
.tui_body > div:nth-child(2) {
  flex: 1;
}
.tui_body > div:nth-child(1) {
  font-family: "微软雅黑";
  font-size: 16px;
  line-height: 50px;
}
.an {
  display: flex;
  line-height: 40px;
}
.an > div {
  flex: 1;
  border: 1px solid rgb(218, 220, 220);
}
.a_1 {
  color: #b0b5b5;
}
.a_2 {
  color: red;
}
.my {
  width: 100%;
  height: 100%;
  background-color: rgba(246, 246, 246, 1);
  position: relative;
}

.my_top {
  width: 100%;
  height: 52vw;
  position: relative;
}

.my_top > img {
  width: 100%;
  margin-top: -21vw;
}

.my_content {
  width: 94%;
  height: 128vw;
  position: absolute;
  left: 0;
  right: 0;
  margin: auto;
  top: 37vw;
  bottom: 4vw;
  border-radius: 6px;
  background-color: rgba(246, 246, 246, 1);
  overflow: scroll;
}

.my_title {
  width: 20vw;
  font-size: 18px;
  position: absolute;
  left: 0;
  right: 0;
  margin: auto;
  top: 3vw;
  color: white;
  font-weight: 700;
}

.my_avatar {
  width: 100%;
  height: 18vw;
  position: absolute;
  top: 12vw;
}

.my_avatar_img {
  width: 18vw;
  height: 18vw;
  position: absolute;
  left: 4vw;
  border-radius: 50%;
  border: 2px solid white;
  box-sizing: border-box;
  overflow: hidden;
}

.my_avatar_img img {
  width: 100%;
  height: 100%;
}

.my_avatar_name {
  width: 30vw;
  height: 18vw;
  position: absolute;
  left: 26vw;
  color: white;
  line-height: 18vw;
  font-family: "Microsoft YaHei";
  font-size: 18px;
  font-weight: 600;
}

.my_content_1 {
  width: 100%;
  height: 20vw;
  background-color: white;
  border-radius: 6px;
  display: flex;
}

.my_content_1 > span {
  color: rgba(220, 220, 220, 1);
  line-height: 20vw;
}

.my_content_1 > div {
  display: flex;
  flex-direction: column;
}

.my_content_1 > div > div:nth-of-type(1) {
  flex: 1;
  text-align: center;
  line-height: 10vw;
}

.my_content_1 > div > div:nth-of-type(2) {
  flex: 1;
  text-align: center;
  line-height: 6vw;
  font-size: 14px;
  color: rgb(158, 158, 158);
}

.my_content_11 {
  flex: 1.35;
  display: flex;
}

.my_content_12 {
  flex: 1;
}

.my_content_13 {
  flex: 1;
}

.my_content_2 {
  margin-top: 2vw;
  width: 100%;
  height: 41vw;
  background-color: white;
  border-radius: 6px;
  display: flex;
  flex-direction: column;
}

.my_content_21 {
  flex: 1;
  position: relative;
}

.my_content_21 > div:nth-of-type(1) {
  position: absolute;
  width: 19vw;
  height: 7vw;
  bottom: 1vw;
  left: 2vw;
  font-size: 15px;
  font-weight: 400;
}

.my_content_21 > div:nth-of-type(2) {
  position: absolute;
  width: 27vw;
  height: 5vw;
  bottom: 1vw;
  right: 1vw;
  font-size: 14px;
  color: rgba(220, 220, 220, 1);
}

.my_content_22 {
  flex: 3;
  display: flex;
}

.my_content_22_list {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.my_content_22_list > div:nth-of-type(1) {
  flex: 1.5;
  position: relative;
}

.my_content_22_list > div:nth-of-type(1) > div {
  width: 13vw;
  height: 13vw;
  border-radius: 50%;
  overflow: hidden;
  position: absolute;
  background-color: rgb(229, 235, 250);
  border: 4px solid rgb(243, 246, 254);
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
}

.my_content_22_list > div:nth-of-type(1) img {
  width: 10vw;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
}

.my_content_22_list > div:nth-of-type(2) {
  flex: 1;
  text-align: center;
  font-size: 14px;
  line-height: 30px;
}

.my_content_3 {
  margin-top: 2vw;
  width: 100%;
  height: 93vw;
  background-color: white;
  border-radius: 6px;
}

.my_content_3_list {
  margin: auto;
  width: 80vw;
  height: 13.3vw;
  border-bottom: 1px solid rgba(220, 220, 220, 0.4);
  box-sizing: border-box;
  position: relative;
  display: flex;
}

.my_content_3 > div:nth-last-child(1) {
  border: 0;
}

.my_content_3_list_1 {
  flex: 1;
  position: relative;
}

.my_content_3_list_1 > img {
  width: 6vw;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
}

.my_content_3_list_2 {
  flex: 5.3;
  line-height: 13.3vw;
  font-size: 15px;
}

.my_content_3_list_3 {
  flex: 1;
  position: relative;
}

.my_content_3_list_3 > .el-icon-arrow-right {
  line-height: 13.3vw;
  margin-left: 8vw;
  color: rgba(220, 220, 220, 1);
}

.view {
  z-index: 2;
  width: 100vw;
  height: 100vh;
  position: absolute;
  top: 0;
}
</style>