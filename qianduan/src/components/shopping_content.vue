// 购物车组件
<template>
  <div>
    <div class="page">
      <div class="page_top">
        <div class="page_top_shang">
          <span class="page_title">购物车</span>
        </div>
        <div class="page_top_xia">
          <div class="page_top_xia_left">
            <span class="page_top_p page_top_p1">全部产品</span
            ><span class="page_top_p">（{{ goods_list.length }}）</span>
          </div>
          <div class="page_top_xia_right">
            <span @click="bian_ji" class="bian page_top_p page_top_p2"
              >编辑</span
            >
            <span @click="cancle" class="qu_xiao page_top_p page_top_p2"
              >取消</span
            >
          </div>
        </div>
      </div>
      <div class="page_center">
        <div class="page_center_list">
          <div class="list1" v-for="(item, index) in goods_list" :key="index">
            <div class="list1_left">
              <div
                class="hhh"
                @click="h_click(index)"
                :class="{ or_hhh: o_index[index].aa == 1 }"
              ></div>
            </div>
            <div class="list1_center">
              <div class="list1_center_left">
                <img :src="'http://192.168.0.135:3000/img/'+item.g_img+'.jpg'" alt="" />
              </div>
              <div class="list1_center_right">
                <div class="name p">
                  <span>{{ item.g_name }}</span>
                </div>
                <div class="jieshao p">
                  <span
                    ><span>{{ item.g_size }}</span
                    >公斤/袋</span
                  >
                </div>
                <div class="jiage p">
                  <span>￥</span><span>{{ item.g_price }}</span>
                </div>
              </div>
            </div>
            <div class="list1_right">
              <div class="bianxing">
                <div class="jia a" @click="jian_fn(item, index)">
                  <img src="../assets/－.png" alt="" />
                </div>
                <div class="num">
                  <span>{{ item.g_number }}</span>
                </div>
                <div class="jian a" @click="jia_fn(index)">
                  <img src="../assets/＋.png" alt="" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="page_bottom">
        <div class="page_bottom_shang">
          <div class="left_quanxuan">
            <div
              class="fff"
              @click="f_click()"
              :class="{ or_fff: aa == 1 }"
            ></div>
            <span>全选</span>
          </div>
          <div class="center_heji" ref="heji">
            <span class="center_heji_wenzi">合计：</span>
            <span class="center_heji_fuhao"
              >￥<span class="center_heji_num">{{ total_price }}</span></span
            >
          </div>
          <div class="right_jiesuan">
            <span class="jie_suan right_jiesuan_jiesuan" @click="jiesuan">去结算</span>
            <span class="del right_jiesuan_jiesuan" @click="shan_ch">删除</span>
          </div>
        </div>
      </div>
    </div>
    <div class="nihaimeiyou" ref="xuanzeshangping">请选择商品</div>
  </div>
</template>

<script>
export default {
  created() {
    this.$http
      .post("http://192.168.0.135:3000/get_shop_car", { user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc })
      .then((res) => {
        this.goods_list = res.data.value;
        res.data.value.forEach(() => {
          this.o_index.push({ aa: 0 });
        });
      });
  },
  data() {
    return {
      // 是否全选
      aa: 0,
      goods_list: [],
      o_index: [],
    };
  },
  computed: {
    total_price() {
      let aa = 0;
      for (var i = 0; i < this.o_index.length; i++) {
        if (this.o_index[i].aa == 1) {
          aa += this.goods_list[i].g_number * this.goods_list[i].g_price;
        }
      }
      return aa;
    },
  },
  methods: {
    //编辑按钮
    bian_ji() {
      var bian = document.querySelector(".bian");
      var qu_xiao = document.querySelector(".qu_xiao");
      var jie_suan = document.querySelector(".jie_suan");
      var del = document.querySelector(".del");
      bian.style.display = "none";
      qu_xiao.style.display = "block";
      jie_suan.style.display = "none";
      del.style.display = "block";
      this.$refs.heji.style.opacity = 0
    },
    // 取消按钮
    cancle() {
      var bian = document.querySelector(".bian");
      var qu_xiao = document.querySelector(".qu_xiao");
      var jie_suan = document.querySelector(".jie_suan");
      var del = document.querySelector(".del");
      bian.style.display = "block";
      qu_xiao.style.display = "none";
      jie_suan.style.display = "block";
      del.style.display = "none";
      this.$refs.heji.style.opacity = 1
    },
    // 删除
    shan_ch() {
      var bian = document.querySelector(".bian");
      var qu_xiao = document.querySelector(".qu_xiao");
      var jie_suan = document.querySelector(".jie_suan");
      var del = document.querySelector(".del");
      bian.style.display = "block";
      qu_xiao.style.display = "none";
      jie_suan.style.display = "block";
      del.style.display = "none";
    },
    // 单个选择
    h_click(index) {
      this.o_index[index].aa = this.o_index[index].aa == 1 ? 0 : 1;
      let bb = this.o_index.filter((item) => {
        return item.aa == 0;
      });
      this.aa = bb.length > 0 ? 0 : 1;
    },
    // 全选
    f_click() {
      if (this.aa == 1) {
        this.aa = 0;
        this.o_index.forEach((item) => {
          item.aa = 0;
        });
      } else {
        this.aa = 1;
        this.o_index.forEach((item) => {
          item.aa = 1;
        });
      }
      // this.aa = this.aa == 1 ? 0 : 1
    },
    // 减
    jian_fn(item, index) {
      if (item.g_number <= 1) {
      } else {
        this.goods_list[index].g_number--;
        this.$http.post("http://192.168.0.135:3000/re_shop_car", {
          user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc,
          g_name: item.g_name,
          g_number: this.goods_list[index].g_number,
        });
      }
    },
    // 加
    jia_fn(index) {
      this.goods_list[index].g_number++;
      this.$http.post("http://192.168.0.135:3000/re_shop_car", {
        user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc,
        g_name: this.goods_list[index].g_name,
        g_number: this.goods_list[index].g_number,
      });
    },
    // 结算功能
    jiesuan() {
      if (0) {
      } else {
        if(this.total_price>0) {
          let aa = []
          this.o_index.forEach((item,index)=> {
            if (item.aa == 1) {
              aa.push(index)
            }
          })
          let shop_goods = []
          for(var i = 0; i<aa.length;i++) {
            shop_goods.push(this.goods_list[aa[i]])
          }
          this.$router.push({name:'jiesuan',params:{shop_goods,total_price:this.total_price}})
          localStorage.setItem('goods',JSON.stringify(shop_goods))
          
        }else {
          console.log('请选择要购买的物品');
          this.$refs.xuanzeshangping.style.display = 'block'
          setTimeout(()=> {
            this.$refs.xuanzeshangping.style.display = 'none'
          },1000)
        }
      }
    },
    // this.$http
    //       .post("http://192.168.0.135:3000/get_user_info", {
    //         user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc,
    //       })
    //       .then((res) => {
    //         console.log(res.data.value[0].user_money);
    //         console.log(this.total_price);
    //         if (res.data.value[0].user_money >= this.total_price) {
    //           this.$http
    //             .post("http://192.168.0.135:3000/", {
    //               user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc,
    //               user_money: res.data.value[0].user_money - this.total_price,
    //             })
    //             .then((res) => {
    //               console.log(res);
    //             });
    //         }
    //       });
    // 删除
    shan_ch() {
      let g_name_arr = [];
      for (var i = 0; i < this.o_index.length; i++) {
        if (this.o_index[i].aa == 1) {
          g_name_arr.push(this.goods_list[i].g_name);
        }
      }
      this.$http
        .post("http://192.168.0.135:3000/delete_shop_car", {
          user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc,
          g_name_arr: JSON.stringify(g_name_arr),
        })
        .then((res) => {
          if (res.data.msg == "删除成功") {
            this.o_index = [];
            this.$http
              .post("http://192.168.0.135:3000/get_shop_car", {
                user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc,
              })
              .then((res) => {
                this.goods_list = res.data.value;
                res.data.value.forEach(() => {
                  this.o_index.push({ aa: 0 });
                });
              });
          }
        });
      for (var i = 0; i < this.o_index.length; i++) {
        if (this.o_index[i].aa == 1) {
        }
      }
    },
  },
};
</script>

<style scoped>
* {
  padding: 0;
  margin: 0;
  box-sizing: border-box;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
.qu_xiao {
  display: none;
}
.del {
  display: none;
}
.page {
  width: 100vw;
  height: 92.1vh;
  background-color: #f6f6f6;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: center;
}
.page_top {
  width: 100%;
  height: 16%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: center;
}
.page_top_shang {
  width: 100%;
  height: 63%;
  background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
  display: flex;
  justify-content: center;
  align-items: center;
}
.page_title {
  font-size: 18px;
  font-family: "微软雅黑";
  font-weight: 700;
  letter-spacing: 1px;
  color: white;
}
.page_top_xia {
  width: 95%;
  height: 30%;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.page_top_xia_left {
  width: 50%;
  height: 100%;
  display: flex;
  align-items: center;
}
.page_top_p {
  font-size: 16px;
  font-family: "微软雅黑";
}
.page_top_p1 {
  margin-left: 15px;
}
.page_top_xia_right {
  width: 30%;
  height: 100%;
  display: flex;
  justify-content: flex-end;
  align-items: center;
}
.page_top_p2 {
  margin-right: 15px;
}
.page_center {
  width: 100%;
  height: 81%;
  display: flex;
  justify-content: center;
  overflow-y: scroll;
  overflow-x: hidden;
}
.page_center_list {
  width: 95%;
}
.list1 {
  width: 100%;
  height: 150px;
  background-color: #ffffff;
  border-radius: 10px;
  overflow: hidden;
  margin-bottom: 10px;
  display: flex;
  justify-content: flex-start;
}
.list1_left {
  width: 10%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.hhh {
  width: 25px;
  height: 25px;
  overflow: hidden;
  border: 1.5px solid rgba(0, 0, 0, 0.5);
  border-radius: 50%;
}
.or_hhh {
  background-image: url(../assets/选中.png);
  background-position: center;
  background-size: cover;
  border: 0;
}
.xiaoshi {
  display: none;
}
.list1_center {
  width: 56%;
  height: 100%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
}
.list1_center_left {
  width: 40%;
  height: 100%;
  padding: 5px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.list1_center_left > img {
  width: 100%;
  height: 80%;
  background-position: center;
  background-size: cover;
}
.list1_center_right {
  width: 60%;
  height: 80%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
}
.p {
  width: 100%;
  height: 30%;
  display: flex;
  align-items: center;
}
.name > span {
  font-size: 16px;
  font-family: "微软雅黑";
  color: #333333;
  font-weight: 600;
  letter-spacing: 1px;
}
.jieshao > span {
  background-color: #f6f6f6;
  padding: 5px;
  font-size: 12px;
  font-family: "微软雅黑";
  color: #6c6c6c;
  border-radius: 5px;
}
.jiage > span {
  font-size: 16px;
  font-family: "微软雅黑";
  color: rgb(235, 74, 39);
  color: rgb(235, 73, 38);
  font-weight: 600;
  letter-spacing: 1px;
}
.list1_right {
  width: 30%;
  height: 100%;
  display: flex;
  align-items: flex-end;
}
.bianxing {
  width: 100%;
  height: 30%;
  margin-bottom: 20px;
  display: flex;
  justify-content: flex-start;
  align-items: center;
}
.a {
  width: 30%;
  height: 80%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.a > img {
  width: 15px;
  height: 15px;
  background-position: center;
  background-size: cover;
}
.num {
  width: 40%;
  height: 60%;
  background-color: #f6f6f6;
  display: flex;
  justify-content: center;
  align-items: center;
  border-radius: 5px;
}
.num > span {
  font-size: 16px;
  font-family: "微软雅黑";
  color: #353535;
  font-weight: 550;
}
.page_bottom {
  width: 100%;
  height: 7%;
  display: flex;
  flex-direction: column;
  background-color: #ffffff;
  overflow: hidden;
}
.page_bottom_shang {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
}
.left_quanxuan {
  width: 30%;
  height: 80%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
}
.fff {
  margin-left: 10px;
  width: 25px;
  height: 25px;
  overflow: hidden;
  border: 1.5px solid rgba(0, 0, 0, 0.5);
  border-radius: 50%;
}
.or_fff {
  background-position: center;
  background-size: cover;
  background-image: url(../assets/选中.png);
  border: 0;
}
/* .left_quanxuan>img{
  width: 25px;
  height: 25px;
  background-position: center;
  background-size: cover;
  margin-left: 10px;
} */
.left_quanxuan > span {
  margin-left: 10px;
  font-size: 18px;
  font-family: "微软雅黑";
  color: #9d9d9d;
  letter-spacing: 2px;
}
.center_heji {
  width: 40%;
  height: 80%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
}
.center_heji_wenzi {
  font-size: 16px;
  font-family: "微软雅黑";
  color: #353535;
}
.center_heji_fuhao {
  font-size: 15px;
  font-family: "微软雅黑";
  color: rgb(235, 74, 39);
  color: rgb(235, 73, 38);
}
.center_heji_num {
  font-size: 20px;
  font-family: "微软雅黑";
  color: 2e527f;
  font-weight: 550;
}
.right_jiesuan {
  width: 26%;
  height: 80%;
  background: linear-gradient(
    to right,
    rgb(238, 126, 67) 10%,
    rgb(235, 74, 39) 40%
    /* 58deg, */
    /* rgb(235, 138, 72) 13%,
    rgb(235, 74, 39) 100% */
  );
  border-radius: 50px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.right_jiesuan_jiesuan {
  font-size: 18px;
  font-family: "微软雅黑";
  color: #ffffff;
  letter-spacing: 2px;
}
.page_bottom_xia {
  width: 100%;
  height: 55%;
  display: flex;
  justify-content: space-around;
  align-items: center;
}
.shouye {
  width: 25%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.image {
  width: 50%;
  height: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.image > img {
  width: 32px;
  height: 32px;
  background-position: center;
  background-size: cover;
}
.img_p {
  font-size: 16px;
  font-family: "微软雅黑";
  color: #9d9d9d;
  letter-spacing: 2px;
}
.img_p_p {
  font-size: 16px;
  font-family: "微软雅黑";
  color: rgb(235, 73, 38);
  letter-spacing: 2px;
}
.nihaimeiyou {
  width: 30vw;
  height: 11vw;
  color: white;
  text-align: center;
  line-height: 11vw;
  border-radius: 6px;
  background-color: rgba(0, 0, 0, 0.5);
  position: absolute;
  left: 0;right: 0;top: 0;bottom: 0;
  margin: auto;
  display: none;
}
</style>
