<template>
  <div class="det">
    <div class="datail">
      <div class="datail_top">
        <i
          class="el-icon-arrow-left"
          @click="
            () => {
              this.$router.go(-1);
            }
          "
        ></i
        ><span class="datail_title">商品详情</span>
      </div>
      <div class="datail_center">
        <div class="datail_center_shang">
          <div class="swp">
            <div class="block">
              <el-carousel height="44vh">
                <el-carousel-item v-for="(item, index) in list" :key="index">
                  <img
                    :src="
                      'http://localhost:3000/goods_imgs/' +
                      item.g_img_lun +
                      '.jpg'
                    "
                    alt=""
                  />
                </el-carousel-item>
              </el-carousel>
            </div>
          </div>
          <div class="news">
            <div class="news_price">
              <span class="news_price_a">￥</span
              ><span class="news_price_b">{{ detail.g_price }}</span
              ><span class="news_price_a">/袋</span>
            </div>
            <div class="news_name">
              <span>{{ detail.g_name }}</span>
            </div>
            <div class="news_danjia">
              <span class="news_danjia_a">单价:</span
              ><span class="news_danjia_b">￥</span
              ><span
                class="news_danjia_b"
                style="color: #eb4926; font-size: 20px"
                >{{ danjia() }}</span
              ><span class="news_danjia_b">/公斤</span>
            </div>
            <div class="news_guige">
              <span class="news_danjia_a news_guige_a">规格:</span
              ><span class="news_guige_b">￥</span
              ><span
                class="news_guige_b"
                style="color: #eb4926; font-size: 20px"
                >{{ detail.g_size }}</span
              ><span class="news_guige_b">公斤/袋</span>
            </div>
            <div class="news_leibie">
              <span class="news_danjia_a news_leibie_a">类别:</span
              ><span class="news_leibie_b">{{ detail.g_type }}</span>
            </div>
          </div>
        </div>
        <div class="datail_center_xia">
          <div class="xiang_qing">
            <span>——</span><span>详情介绍</span><span>——</span>
          </div>
          <div class="datail_center_xia_img">
            <img
              :src="'http://localhost:3000/g_imgs_xinxi/' + tist + '.jpg'"
              alt=""
            />
          </div>
        </div>
      </div>
      <div class="datail_bottom">
        <div @click="wode" class="me_goods">
          <img src="../assets/我的2.png" alt="" />
          <span>我的</span>
        </div>
        <div @click="kefu_serve" class="me_goods">
          <div class="tip">
            <div class="tip_num">
              <!-- <el-badge :value="99" class="item"></el-badge> -->
            </div>
            <img src="../assets/客服旺旺.png" alt="" />
          </div>
          <span>客服</span>
        </div>
        <div class="collection">
          <div class="collection_img">
            <img
              @click="tianjia"
              class="image_b"
              :src="image_t == 1 ? image[1].url : image[0].url"
              alt=""
            />
          </div>
          <span>收藏</span>
        </div>
        <div class="shopping">
          <div class="jiaru_kuang">
            <div class="jiaru jiaru_goumai" @click="add_shop">
              <span>加入购物车</span>
            </div>
            <div class="goumai jiaru_goumai" @click="goPay(detail)"><span>立即购买</span></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
// import HelloWorld from './components/HelloWorld.vue'

export default {
  name: "goods_detail",
  created() {
    let { detail } = this.$route.params;
    this.detail = detail;
    this.$http.post('http://localhost:3000/s_goods_name',{g_type:detail.g_name}).then((res)=> {
      this.image_t = res.data.value[0].isCollect
    })
    // this.image_t = detail.isCollect
    this.tist = detail.g_img_xinxi
    this.$http.post('http://localhost:3000/get_imgs_lunbo',{g_name:detail.g_name}).then((res)=> {
      this.list = res.data.value
    })
  },
  data() {
    return {
      detail: [],
      a: 0,
      list:'',
      tist: [],
      image: [
        {
          url: require("@/assets/收藏.png"),
          a: 0,
        },
        {
          url: require("@/assets/收藏2.png"),
          a: 1,
        },
      ],
      image_t: 0,
    };
  },
  methods: {
    // 我的点击事件
    wode() {
      if(sessionStorage.getItem('user')) {
        this.$router.push({name:'my'})
      }else {
        this.$message.success('赶快登录吧')
      }
    },
    // 客服点击事件
    kefu_serve() {
      this.$router.push('/liaotian')
    },
    // 添加收藏
    tianjia() {
      if(sessionStorage.getItem('user')) {
        if(this.image_t == 0) {
          this.$http.post('http://localhost:3000/add_collect',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc,g_name:this.detail.g_name})
        } else {
          this.$http.post('http://localhost:3000/cancel_collect',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc,g_name:this.detail.g_name})
        }
        this.image_t = this.image_t ? 0 : 1;
      }else {
        this.$message.success('请先登录')
      }
    },
    // 单价
    danjia() {
      return ((this.detail.g_price - 0) / (this.detail.g_size - 0)).toFixed(2)
    },
    // 加入购物车
    add_shop() {
      if(sessionStorage.getItem('user')) {
        this.$bus.$emit("modal",{
        modal:1,
        data:this.detail,
        type:1
        })
      }else {
        this.$message.success('请先登录')
      }
    },
    // 立即购买
    goPay(detail) {
      console.log(detail);
      this.$router.push({name:'jiesuan',params:{detail,total_price:detail.g_price}})
    }
  },
};
</script>

<style scoped>
.det {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

.datail {
  width: 100vw;
  height: 100vh;
  background-color: #f6f6f6;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: center;
}

.datail_top {
  width: 100%;
  height: 8%;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #ffffff;
}

.datail_title {
  font-size: 20px;
  font-family: "微软雅黑";
  font-weight: 550;
  letter-spacing: 1px;
  color: #333333;
}

.datail_center {
  width: 100%;
  height: 84%;
  overflow-y: scroll;
  overflow-x: hidden;
}

.datail_center_shang {
  width: 100%;
  height: 80%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
}

.swp {
  width: 100%;
  height: 68%;
}

.news {
  width: 94%;
  height: 32%;
  background-color: #ffffff;
  padding: 2% 4%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: flex-start;
  border-radius: 10px;
  overflow: hidden;
}

.news_price_a {
  font-size: 13px;
  font-family: "微软雅黑";
  font-weight: 550;
  letter-spacing: 2px;
  color: #eb4926;
}

.news_price_b {
  font-size: 20px;
  font-family: "微软雅黑";
  font-weight: 550;
  color: #eb4926;
}

.news_name > span {
  font-size: 16px;
  font-family: "微软雅黑";
  font-weight: 550;
  letter-spacing: 1px;
  color: #333333;
}

.news_danjia_a {
  font-size: 14px;
  font-family: "微软雅黑";
  letter-spacing: 1px;
  color: #9e9e9e;
  margin-right: 6px;
}

.news_danjia_b {
  font-size: 14px;
  font-family: "微软雅黑";
  color: #333333;
}

.news_guige_a {
  font-size: 14px;
  font-family: "微软雅黑";
  letter-spacing: 1px;
  color: #9e9e9e;
  margin-right: 6px;
}

.news_guige_b {
  font-size: 14px;
  font-family: "微软雅黑";
  color: #333333;
}

.news_leibie_b {
  font-size: 15px;
  font-family: "微软雅黑";
  color: #333333;
  margin-left: 3px;
}

.datail_center_xia {
  width: 100%;

  display: flex;
  flex-direction: column;
  align-items: center;
}

.xiang_qing {
  width: 40%;
  padding: 5px 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.xiang_qing > span {
  font-size: 14px;
  font-family: "微软雅黑";
  color: #9b9b9b;
  margin-left: 3px;
}

.datail_center_xia_img {
  width: 100%;
}

.datail_center_xia_img > img {
  width: 100%;
}

.datail_bottom {
  width: 100%;
  height: 8%;
  background-color: #ffffff;
  display: flex;
  justify-content: space-around;
  align-items: center;
}

.me_goods {
  width: 15%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.tip {
  width: 40%;
  height: 45%;
  background-position: center;
  background-size: cover;
  position: relative;
}

.tip_num {
  position: absolute;
  top: -6px;
  right: -16px;
}

.tip > img {
  width: 100%;
  height: 100%;
}

.me_goods > img {
  width: 40%;
  height: 45%;
}

.me_goods > span {
  font-size: 12px;
  font-family: "微软雅黑";
  letter-spacing: 1px;
  color: #6e6e6e;
  margin-top: 2px;
}

.collection {
  width: 15%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.collection_img {
  width: 40%;
  height: 45%;
}

.image_b {
  width: 100%;
  height: 100%;
}

.collection > span {
  font-size: 12px;
  font-family: "微软雅黑";
  letter-spacing: 1px;
  color: #6e6e6e;
  margin-top: 2px;
}

.shopping {
  width: 50%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.jiaru_kuang {
  width: 95%;
  height: 66%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  overflow: hidden;
  box-sizing: border-box;
}

.jiaru_goumai {
  width: 50%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  box-sizing: border-box;
}

.jiaru {
  border: 1px solid #eb4a27;
  border-radius: 50px 0 0 50px;
}

.goumai {
  background-color: #eb4a27;
  border-radius: 0px 50px 50px 0px;
}

.jiaru > span {
  font-size: 14px;
  font-family: "微软雅黑";
  letter-spacing: 1px;
  color: #eb4a27;
}

.goumai {
  font-size: 14px;
  font-family: "微软雅黑";
  letter-spacing: 1px;
  color: #ffffff;
}

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

.el-carousel__item > img {
  width: 100%;
  height: 100%;
  background-position: center;
  background-size: cover;
}
.datail_top .el-icon-arrow-left {
  font-size: 20px;
  transform: translateX(-122px);
}
</style>

