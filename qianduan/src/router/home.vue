<template>
  <div class="hom">
    <div class="hom_top">
      <img src="../static/home_img/画板3.png" alt="" />
      <div class="hom_top_name">
        粮达软件
        <i class="el-icon-bell" @click="xiaoxi_fn">
         
        </i>
        <div class="bell" v-if="this.messages"></div>
      </div>
      <div class="hom_top_inp">
        <input type="text" placeholder="请输入你感兴趣的内容进行搜索" @click="search" />
        <i class="el-icon-search"></i>
        <button>搜索</button>
      </div>
      <div class="hom_top_shuffling">
        <!-- 轮播图插件 -->
        <div class="block">
          <el-carousel height="45vw">
            <el-carousel-item>
              <img :src="require('../static/home_img/shuffling/home1.jpg')" alt="" />
            </el-carousel-item>
            <el-carousel-item>
              <img :src="require('../static/home_img/shuffling/home2.jpg')" alt="" />
            </el-carousel-item>
            <el-carousel-item>
              <img :src="require('../static/home_img/shuffling/home3.jpg')" alt="" />
            </el-carousel-item>
            <el-carousel-item>
              <img :src="require('../static/home_img/shuffling/home4.png')" alt="" />
            </el-carousel-item>
          </el-carousel>
        </div>
      </div>
      <div class="hom_top_announcement">
        <!-- <span>米袋虽空——樱花开哉!</span> -->
        <div @click="yuan_liang" class="announcement_lunbo_p">
          <div class="textBox">
            <transition name="slide">
              <p class="text" :key="text.id">{{text.val}}</p>
            </transition>
          </div>
        </div>
      </div>
    </div>
    <div class="hom_bottom">
      <!-- 10 -->
      <div class="hom_bottom_commodity">
        <div class="hom_bottom_commodity_list" v-for="(item, index) in lists" :key="index" @click="l_click(item.name)">
          <div>
            <img :src="item.src" alt="" />
          </div>
          <div>{{ item.name }}</div>
        </div>
      </div>
      <Sell />
      <Product />
      <div class="quickly_login" v-if="!isLogin">
        <span>登录料厂打开精彩世界</span>
        <span @click="$router.push('/login')">立即登录</span>
      </div>
    </div>
    <div v-if="isTrue" class="search">
      <!-- <Search/> -->
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import Sell from "../components/sell.vue";
import Product from "../components/product.vue";
export default {
  components: {
    Sell,
    Product,
  },
  created() {
    this.isLogin = sessionStorage.getItem('user')
    this.get_message()
  },
  methods: {
    get_message() {
      this.hx_conn.addEventHandler("connection&message", {
      onTextMessage: (message) => {
        console.log("收到消息了。。。")
        console.log(message)
        this.messages = true
      }
    })
    },
    // 消息提示{
      xiaoxi_fn(){
        this.messages = false
        this.$router.replace({name:'liaotian'})
      },
    startMove() {
      // eslint-disable-next-line
      let timer = setTimeout(() => {
        if (this.number === 2) {
          this.number = 0;
        } else {
          this.number += 1;
        }
        this.startMove();
      }, 5000); // 滚动不需要停顿则将2000改成动画持续时间
    },
    // 点击公告跳转到原粮
    yuan_liang() {
      var rss = '原粮'
      this.$router.push({
        path: "home/search/goods",
        query: { g_type: rss, method: "s_goods_type" },
      });
    },
    // 搜索点击事件
    search() {
      this.isTrue = 1;
      this.$router.push({ path: "home/search" });
    },
    l_click(res) {
      // this.$http({
      //   method:"POST",
      //   url:"http://localhost:3000/s_goods_type",
      //   data:{
      //     g_type:res
      //   }
      // }).then((res)=> {
      //   console.log(res)
      // })
      this.$router.push({
        path: "home/search/goods",
        query: { g_type: res, method: "s_goods_type" },
      });
    },
  },
  data() {
    return {
      messages: false,
      textArr: [
        '原产小麦，精致加工',
        '精致打磨，保留最原始风味',
        '原麦加工，无任何添加剂'
      ],
      number: 0,
      isLogin: sessionStorage.getItem("user"),
      lists: [
        {
          name: "原粮",
          src: require("../static/home_img/原粮.png"),
        },
        {
          name: "精致特一粉",
          src: require("../static/home_img/精致.png"),
        },
        {
          name: "优质特一粉",
          src: require("../static/home_img/优质.png"),
        },
        {
          name: "普通粉",
          src: require("../static/home_img/普通.png"),
        },
        {
          name: "小包装",
          src: require("../static/home_img/小包装.png"),
        },
        {
          name: "标准粉",
          src: require("../static/home_img/标准.png"),
        },
        {
          name: "次粉",
          src: require("../static/home_img/促销产品.png"),
        },
        {
          name: "麸皮",
          src: require("../static/home_img/常规.png"),
        },
        // {
        //   name: "物流",
        //   src:require('../static/home_img/物流.png')
        // },
        // {
        //   name: "订单",
        //   src:require('../static/home_img/订单.png')
        // },
      ],
    };
  },
  computed: {
    isTrue() {
      if (this.$route.name == "home") {
        return 0;
      } else {
        return 1;
      }
    },
    text() {
      return {
        id: this.number,
        val: this.textArr[this.number]
      }
    }
  },
  mounted() {
    this.startMove()
  },
};
</script>

<style scoped>
  .bell{
   
    padding: 1px;
    width: 7px;
    height: 7px;
    background-color: rgb(249, 26, 26);
    border-radius: 100%;
    position: absolute;
    right: -133px;
    top: 4px;
    font-size: 12px;
 
  }
  .el-icon-bell{
    position: absolute;
    right: -133px;
    top: 5px;
    font-size: 25px;
  }
.hom {
  width: 100%;
  height: 92.1vh;
  position: relative;
  display: flex;
  flex-direction: column;
  background-color: #f6f6f6;
}

.hom_top {
  flex: 1;
  position: relative;
}

.hom_top>img {
  margin-top: -6vw;
  width: 100vw;
}

.hom_bottom {
  flex: 1;
  overflow: scroll;
  position: relative;
}

.hom_top_name {
  width: 19.8vw;
  position: absolute;
  left: 0;
  right: 0;
  margin: auto;
  top: 2vw;
  font-weight: 600;
  font-size: 18px;
  color: white;
}

.hom_top_inp {
  width: 95%;
  height: 10vw;
  position: absolute;
  left: 0;
  right: 0;
  margin: auto;
  top: 11.5vw;
}

.hom_top_inp>input {
  width: 85vw;
  height: 8vw;
  border-radius: 4vw;
  border: 0;
  margin-top: 1vw;
  padding-left: 10vw;
  outline: 0;
}

.el-icon-search {
  position: absolute;
  top: 3.1vw;
  left: 3vw;
}

.hom_top_inp>button {
  color: white;
  /* background-color: #1d3b61; */
  background-color: transparent;
  width: 14vw;
  height: 7vw;
  position: absolute;
  top: 1.6vw;
  right: 0.5vw;
  border-radius: 3.5vw;
  border: 0;
  z-index: 2;
  overflow: hidden;
}

.hom_top_shuffling {
  width: 95vw;
  height: 45vw;
  position: absolute;
  left: 0;
  right: 0;
  margin: auto;
  top: 26vw;
  border-radius: 6px;
  overflow: hidden;
}

.hom_top_shuffling img {
  width: 95vw;
}

/* 轮播图 */
.el-carousel__item h3 {
  color: #475669;
  font-size: 14px;
  opacity: 0.75;
  line-height: 150px;
  margin: 0;
}

.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n + 1) {
  background-color: #d3dce6;
}

.hom_top_announcement {
  position: absolute;
  left: 0;
  right: 0;
  margin: auto;
  top: 73.8vw;
  width: 94vw;
  height: 8vw;
  border-radius: 4vw;
  background-color: #99a9bf;
  background-image: url(../static/home_img/公告.png);
  background-size: cover;
  display: flex;
  justify-content: flex-end;
  align-items: center;
}

.announcement_lunbo_p {
  width: 76%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.textBox {
  width: 100%;
  height: 100%;
  margin: 0 auto;
  overflow: hidden;
  position: relative;
}

.text {
  width: 100%;
  position: absolute;
  bottom: 5px;
  color: #86c9f4;
  background: -webkit-linear-gradient(90deg, #2964a0, #1b375c);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-size: 14px;
  font-family: '微软雅黑';
}

.slide-enter-active,
.slide-leave-active {
  transition: all 0.5s linear;
}

.slide-enter {
  transform: translateY(20px) scale(1);
  opacity: 1;
}

.slide-leave-to {
  transform: translateY(-20px) scale(0.8);
  opacity: 0;
}

.hom_top_announcement span {
  margin-left: 24vw;
  line-height: 8vw;
  color: rgba(0, 0, 0, 0.4);
  font-size: 14px;
}

.hom_bottom_commodity {
  position: relative;
  left: 0;
  right: 0;
  margin: auto;
  top: 3vw;
  width: 94%;
  height: 50vw;
  border-radius: 6px;
  margin-bottom: 7vw;
  background-color: #fff;
}

.hom_bottom_commodity_list {
  width: 23.5vw;
  height: 25vw;
  float: left;
  display: flex;
  flex-direction: column;
}

.hom_bottom_commodity_list>div:nth-of-type(1) {
  flex: 2.5;
  position: relative;
}

.hom_bottom_commodity_list>div:nth-of-type(1)>img {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  top: 0;
  margin: auto;
  width: 13vw;
}

.hom_bottom_commodity_list>div:nth-of-type(2) {
  flex: 1;
  font-size: 14px;
  margin: auto;
}

.search {
  /* display: none; */
  width: 100vw;
  height: 100vh;
  position: fixed;
  top: 0;
  z-index: 2;
}

.hom_top_announcement {
  position: absolute;
  left: 0;
  right: 0;
  margin: auto;
  top: 73.8vw;
  width: 94vw;
  height: 8vw;
  border-radius: 4vw;
  background-color: #99a9bf;
  background-image: url(../static/home_img/公告.png);
  background-size: cover;
}

.hom_top_announcement span {
  margin-left: 24vw;
  line-height: 8vw;
  color: rgba(0, 0, 0, 0.4);
  font-size: 14px;
}

.hom_bottom_commodity {
  position: relative;
  left: 0;
  right: 0;
  margin: auto;
  top: 3vw;
  width: 94%;
  height: 50vw;
  border-radius: 6px;
  margin-bottom: 7vw;
  background-color: #fff;
}

.hom_bottom_commodity_list {
  width: 23.5vw;
  height: 25vw;
  float: left;
  display: flex;
  flex-direction: column;
}

.hom_bottom_commodity_list>div:nth-of-type(1) {
  flex: 2.5;
  position: relative;
}

.hom_bottom_commodity_list>div:nth-of-type(1)>img {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  top: 0;
  margin: auto;
  width: 13vw;
}

.hom_bottom_commodity_list>div:nth-of-type(2) {
  flex: 1;
  font-size: 14px;
  margin: auto;
}

/* 赶快去登录吧 */
.quickly_login {
  width: 100%;
  height: 12vw;
  position: fixed;
  background-color: rgba(0, 0, 0, 0.8);
  opacity: 0.9;
  bottom: 13.5vw;
}

.quickly_login>span:nth-of-type(1) {
  font-size: 12px;
  line-height: 12vw;
  margin-left: 2vw;
  color: white;
}

.quickly_login>span:nth-of-type(2) {
  display: inline-block;
  color: white;
  font-size: 13px;
  margin-left: 45vw;
  padding: 0 2vw;
  line-height: 6vw;
  border-radius: 6vw;
  background: linear-gradient(90deg,
      rgb(238, 126, 67) 10%,
      rgb(235, 74, 39) 100%);
}

/* 搜索边框 */
.hom_top_inp>button::after {
  content: "";
  width: 13.6vw;
  height: 6.6vw;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  background-color: #1d3b61;
  border-radius: 3.5vw;
  z-index: -1;
}

.hom_top_inp>button::before {
  content: "";
  width: 14vw;
  height: 14vw;
  background-color: rgb(165, 238, 19);
  position: absolute;
  left: 0;
  right: 0;
  margin: auto;
  left: 7vw;
  top: 3.5vw;
  transform-origin: 0 0;
  animation: rotate 3s infinite linear;
  z-index: -2;
}

@keyframes rotate {
  to {
    transform: rotate(1turn);
  }
}
</style>