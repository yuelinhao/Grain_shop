// found-------商品
<template>
  <div class="sam">
    <!-- 商品样例 -->
    <div class="list" v-for="item in goods_list" :key="item.serial" @click="detail(item)">
      <div class="list_left">
        <img :src="'http://localhost:3000/img/'+item.g_img+'.jpg'" alt="" />
      </div>
      <div class="list_right">
        <div class="goods_sample">
          <div class="good_name">{{ item.g_name }}</div>
          <div class="good_serial">
            <span>编号:{{ item.g_bianhao }}</span>
            <span>{{ item.g_size }}公斤/袋</span>
          </div>
          <div class="good_price">
            <span>
              <span style="font-size: 12px">￥</span>
              {{ item.g_price }}
              <span style="font-size: 12px">
              </span>
            </span>
            <span>已售{{ item.g_sell }}件</span>
          </div>
          <div class="good_img" @click.stop="add_shop(item)">
            <img src="../static/img/加入购物车.png" alt="加入购物车" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// JSON.stringify();
export default {
  created() {
    this.shuju();
    this.$bus.$on('qiehuan',(res)=> {
      this.shuju(res)
    })
  },
  methods: {
    shuju(res) {
      this.$http.post("http://localhost:3000/s_goods_type", {
        g_type: res||"原粮",
      }).then((res)=> {
        this.goods_list = res.data.value
      });
    },
    detail(item) {
      this.$router.push({name:'goods_detail',params:{detail:item}})
    },
    add_shop(item) {
      this.$bus.$emit("modal",{
        modal:1,
        data:item,
        type:1
      })
    }
  },
  data() {
    return {
      // 商品信息
      goods_list: [],
    };
  },
};
</script>

<style scoped>
.sam {
  width: 100%;
  height: 98%;
  position: relative;
  overflow: scroll;
  padding-top: 2vw;
}
.sam > .list {
  width: 92%;
  height: 28vw;
  margin: auto;
  border-bottom: 1px solid rgba(220, 220, 220, 0.2);
  display: flex;
}
.list_left {
  flex: 1;
  position: relative;
}
.list_left > img {
  width: 20vw;
  height: 20vw;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  background-position: auto;
  background-size: cover;
}
.list_right {
  flex: 1.9;
  position: relative;
}
.goods_sample {
  width: 95%;
  height: 95%;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  display: flex;
  flex-direction: column;
}
.goods_sample > div {
  overflow: hidden;
  position: relative;
}
.good_name {
  flex: 1;
  /* font-weight: 700; */
}
.good_serial {
  flex: 1;
}
.good_serial > span {
  background-color: #f6f6f6;
  padding: 2px;
  border-radius: 2px;
}
.good_serial > span:nth-of-type(1) {
  font-size: 14px;
}
.good_serial > span:nth-of-type(2) {
  font-size: 12px;
  margin-left: 2vw;
}
.good_price {
  flex: 1;
}
.good_price > span:nth-of-type(1) {
  color: #ec5a3a;
}
.good_price > span:nth-of-type(2) {
  margin-left: 2vw;
  font-size: 12px;
  color: #bebebe;
}
.good_img {
  flex: 1;
}
.good_img > img {
  width: 5vw;
  position: absolute;
  top: 0;
  bottom: 0;
  margin: auto;
  right: 1vw;
}
</style>