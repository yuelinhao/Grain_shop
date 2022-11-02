// home界面组件
<template>
  <div class="pro">
    <div class="pro_top">
      <div
        class="pro_top_list"
        v-for="(item, index) in top_list"
        :key="index"
        @click="t_click(index, item)"
      >
        <div class="pro_top_list_i" :class="{ o_pro_top_list_i: item.aa }">
          {{ item.name }}
        </div>
        <span class="tankuan" v-if="index > 1">
          <i
            class="el-icon-caret-top"
            :class="{ 'el-icon-caret-bottom': xiaojiantou[index] }"
            @click="paixu(index)"
          ></i>
          <!-- <i class="el-icon-caret-bottom"></i> -->
        </span>
      </div>
    </div>
    <div class="pro_bottom">
      <div class="pro_bottom_box">
        <div
          class="pro_bottom_box_list"
          v-for="(item, index) in goods"
          :key="index"
          @click="detail(item)"
        >
          <div class="pro_bottom_box_list_img">
            <div>
              <img
                :src="'http://localhost:3000/img/' + item.g_img + '.jpg'"
                alt=""
              />
            </div>
          </div>
          <div class="pro_bottom_box_list_jinshu">
            <div>{{ item.g_size }}公斤/袋</div>
            <div>{{ item.g_name }}</div>
          </div>
          <div class="pro_bottom_box_list_price">
            <div>￥{{ item.g_price }}</div>
            <div><i class="el-icon-shopping-cart-2" @click.stop="add_shop(item)"></i></div>
          </div>
        </div>
        <div class="meiyou">没有更多了~</div>
      </div>
    </div>
  </div>
</template>
    
<script>
export default {
  created() {
    this.zonhe();
  },
  data() {
    return {
      top_list: [
        {
          name: "综合",
          aa: 1,
        },
        {
          name: "新品",
          aa: 0,
        },
        {
          name: "重量",
          aa: 0,
        },
        {
          name: "价格",
          aa: 0,
        },
      ],
      goods: [],
      xiaojiantou: ["", "", 0, 0],
    };
  },

  methods: {
    zonhe() {
      this.$http.get("http://localhost:3000/all_goods").then((res) => {
        // console.log(res.data.value);
        this.goods = res.data.value;
      });
    },
    t_click(index) {
      this.top_list.forEach((item) => {
        item.aa = 0;
      });
      this.top_list[index].aa = 1;
      if (index == 0) {
        this.zonhe();
      } else if (index == 1) {
        this.canshu();
      } else if (index == 2) {
        let num = this.xiaojiantou[index];
        if (num) {
          this.$http
            .post("http://localhost:3000/s_goods_sort", { num })
            .then((res) => {
              this.goods = res.data.value;
            });
        } else {
          this.$http
            .post("http://localhost:3000/s_goods_sort", { num })
            .then((res) => {
              this.goods = res.data.value;
            });
        }
      } else if (index == 3) {
        let num = this.xiaojiantou[index];
        if (num) {
          this.$http
            .post("http://localhost:3000/sort_goods", { num })
            .then((res) => {
              this.goods = res.data.value;
            });
        } else {
          this.$http
            .post("http://localhost:3000/sort_goods", { num })
            .then((res) => {
              this.goods = res.data.value;
            });
        }
      }
    },
    canshu() {
      this.$http.get("http://localhost:3000/new_goods").then((res) => {
        this.goods = res.data.value;
      });
    },
    // 改变小图标
    paixu(index) {
      this.$set(this.xiaojiantou, index, this.xiaojiantou[index] ? 0 : 1);
    },
    // 商品详细信息
    detail(res) {
      this.$router.push({name:'goods_detail',params:{detail:res}})
    },
    // 加入购物车
    add_shop(item) {
      // console.log(item);
      this.$bus.$emit("modal",{
        modal:1,
        data:item,
        type:1
      })
    }
  },
};
</script>

<style scoped>
.pro {
  width: 100%;
  height: 100%;
  margin: auto;
  display: flex;
  flex-direction: column;
}
.pro_top {
  flex: 1;
  display: flex;
}
.pro_top_list {
  flex: 1;
  text-align: center;
  font-size: 16px;
  font-weight: 700;
  position: relative;
}
.tankuan {
  position: absolute;
  display: inline-flex;
  flex-direction: column;
  width: 3vw;
  height: 8vw;
  border-radius: 4px;
  z-index: 1;
  top: 0;
  bottom: 0;
  margin: auto;
  right: 4vw;
}
.tankuan > i {
  font-size: 12px;
  line-height: 35px;
  color: #3a65a0;
}
.pro_top_list_i {
  width: 10vw;
  height: 5vw;
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  top: 0;
  margin: auto;
}
.o_pro_top_list_i {
  box-shadow: 0 5px 4px -4px #3a65a0;
}
.pro_bottom {
  flex: 6;
  overflow: hidden;
}
.pro_bottom_box {
  width: 94%;
  height: 100%;
  margin: auto;
  overflow: scroll;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
.pro_bottom_box_list {
  width: 45vw;
  height: 50vw;
  border-radius: 6px;
  margin-bottom: 4vw;
  display: flex;
  flex-direction: column;
  background-color: white;
}
.pro_bottom_box_list > div {
  position: relative;
}
.pro_bottom_box_list_img {
  flex: 5;
}
.pro_bottom_box_list_img > div {
  width: 36vw;
  height: 100%;
  margin: auto;
}
.pro_bottom_box_list_img > div > img {
  width: 30vw;
  height: 30vw;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
}
.pro_bottom_box_list_jinshu {
  flex: 1;
}
.pro_bottom_box_list_jinshu > div:nth-of-type(1) {
  width: 16vw;
  height: 4vw;
  position: absolute;
  top: 0;
  bottom: 0;
  margin: auto;
  left: 2vw;
  color: #eb4f2e;
  border-radius: 2px;
  font-size: 12px;
  border: 1px dashed #eb4f2e;
}
.pro_bottom_box_list_jinshu > div:nth-of-type(2) {
  width: 22vw;
  height: 5vw;
  position: absolute;
  top: 0;
  bottom: 0;
  margin: auto;
  right: 2vw;
  font-size: 15px;
  color: black;
  font-weight: 700;
}
.pro_bottom_box_list_price {
  flex: 1;
}
.pro_bottom_box_list_price > div:nth-of-type(1) {
  width: 20vw;
  height: 5vw;
  position: absolute;
  top: -8px;
  bottom: 0;
  margin: auto;
  left: 2vw;
  font-size: 14px;
  color: #eb4f2e;
}
.pro_bottom_box_list_price > div:nth-of-type(2) {
  width: 4vw;
  position: absolute;
  top: 0;
  bottom: 0;
  margin: auto;
  right: 3vw;
  color: #eb4f2e;
}
.meiyou {
  margin: auto;
  text-align: center;
  font-size: 12px;
  color: rgba(164, 164, 164, 0.8);
  padding-bottom: 9px;
}
</style>