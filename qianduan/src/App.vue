<template>
  <div id="app">
    <router-view></router-view>
    <!-- 购物车模态框 -->
    <div class="modal" v-show="this.isModal">
      <i class="el-icon-close" @click="returns"></i>
      <div class="shopping">
        <div class="shopping_top">
          <div class="shopping_top_img">
            <img
              :src="
                'http://192.168.0.135:3000/img/' + goods_retail.g_img + '.jpg'
              "
              alt=""
              style="width: 21vw; height: 28vw"
            />
          </div>
          <div>
            <span style="font-size: 18px"
              ><span style="font-size: 12px">￥</span>{{ goods_retail.g_price
              }}<span style="font-size: 12px">/件</span></span
            >
          </div>
        </div>
        <div class="shopping_zj">
          <div>购买数量</div>
          <div>
            <i
              class="el-icon-minus"
              @click="num > 1 ? num-- : num"
              :class="{ color: num < 2 }"
            ></i
            ><input type="text" v-model="num" /><i
              class="el-icon-plus"
              @click="num++"
            ></i>
          </div>
        </div>
        <div class="shopping_bottom">
          <!-- <div class="confirm" @click="sure">确认</div> -->
          <el-button :plain="true" @click="open2" class="confirm"
            >确认</el-button
          >
        </div>
      </div>
    </div>
    <!-- 付款密码模态框 -->
    <div class="fukuan" v-if="isPay">
      <div class="fukuan_box">
        <div><i class="el-icon-close" style="font-size:18px" @click="quePay"></i>请输入支付密码</div>
        <div>
          <span><span style="font-size:24px;vertical-align:top;">￥</span>{{money}}</span>
        </div>
        <div>
          <input ref="ipt" v-for="item,index in 6" :key="index" type="password" maxlength="1" v-model="input_arr[index]">
        </div>
      </div>
    </div>
  </div>
</template>
<script>
//   import paycodeApp from  '@/components/paycodeApp.vue'
import axios from 'axios'
axios.interceptors.request.use(config=>{
    let token = localStorage.getItem("token_liu")
    config.headers.common['Authorization'] = "Bearer " + token
    return config
})
export default {
//   components:{
//   paycodeApp
// },
watch: {
  // console.log(1111);
  // // let a = this.$refs.ipt.length
  // for(let i = 0; i<this.$refs.ipt.length;i++) {
  //   if(this.$refs.ipt[i]._value) {
  //     this.$refs.ipt[i].focus()
  //   } else {
  //     this.$refs.ipt[i].focus()
  //   }
  // }
  // if()
  // 计算密码
  input_arr(newval) {
    for(let i =0; i<6;i++) {
      if(newval.length == i) {
        this.$refs.ipt[i].focus()
        continue
      }
    }
    var a = 0
    newval.forEach((item)=> {
      a++
      if(!item) {
        this.input_arr.shift()
        this.$refs.ipt[a].focus()
      }
    })
    var mima = ''
    newval.forEach((item)=> {
      mima +=item
    })
    if(mima.length == 6) {
      // this.$http.post('http://192.168.0.135:3000/pay_password',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc,user_pay_pw:}).then((res)=> {
      //   console.log(res);
      // })
      this.$http.post('http://192.168.0.135:3000/get_user_info',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc}).then((res)=> {
        if(res.data.value[0].user_money >= this.money) {
          this.$http.post('http://192.168.0.135:3000/pay_password',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc,user_pay_pw:mima}).then((res)=> {
          console.log(res);
          if(res.data.msg == '密码正确') {
             this.$http.post('http://192.168.0.135:3000/pay_money',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc,user_money:this.money}).then((res)=> {
                this.$message.success('支付成功')
                let name_arr = []
                let g_arr = []
                JSON.parse(localStorage.getItem('goods')).forEach((item)=> {
                   name_arr.push(item.g_name)
                   g_arr.push({g_name:item.g_name,g_number:item.g_number})
                })
                this.isPay = 0
                this.ipt = null
                this.input_arr.shift()
                var o_id = sessionStorage.getItem('shijian')//new Date().getTime()// +new Date()
                
                this.$http.post('http://192.168.0.135:3000/delete_shop_car',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc,g_name_arr:JSON.stringify(name_arr)})
                this.$http.post('http://192.168.0.135:3000/o_pay',{
                  o_id,
                  o_status:1,
                  g_arr:JSON.stringify(g_arr),
                  user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc,
                  o_price:this.money
                })
                this.$router.push({ name: "aa", params: { isAll: false, type: 1 } });
                this.$bus.$emit('isPay')
             })
          }
        })
        }
      })

    }

  }
},
  data() {
    return {
      isPay:0,
      ipt: "",
      input: "",
      isModal: 0,
      money: 0,
      num: 1,
      goods_retail: [],
      input_arr:[]
    }
  },

  created() {
    this.$bus.$on("modal", (res) => {
      this.isModal = res.modal;
      this.goods_retail = res.data;
    });
    // 支付界面
    this.$bus.$on('goPay',(res)=> {
      console.log(2222222);
      this.isPay = res.sure
      this.money = res.money
      this.input_arr = []
    })
  },
  methods: {
    quePay() {
      this.isPay = 0
    },
    open2() {
      if (this.num >= 1) {
        this.isModal = 0;
        this.$http.post("http://192.168.0.135:3000/add_shop_car", {
          user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc,
          g_name: this.goods_retail.g_name,
          g_number: this.num,
        });
        this.num = 1;
      }
      this.$message({
        message: "添加成功,移步购物车下单吧",
        type: "success",
        showClose: true,
        center: true,
      });
    },
    returns() {
      this.isModal = 0;
    },

  },
};
</script>

<style scoped> 
.modal {
  width: 100vw;
  height: 100vh;
  position: absolute;
  top: 0;
  z-index: 4;
  background-color: rgba(0, 0, 0, 0.5);
}
.modal .el-icon-close {
  color: white;
  font-size: 24px;
  margin-left: 90vw;
  padding-top: 4vw;
}
.modal .shopping {
  width: 100%;
  height: 68vw;
  border-top-left-radius: 12px;
  border-top-right-radius: 12px;
  background-color: white;
  position: absolute;
  bottom: 0;
  display: flex;
  flex-direction: column;
}
.shopping_top {
  flex: 2;
  position: relative;
  color: rgb(235, 74, 39);
}
.shopping_zj {
  flex: 1;
  position: relative;
}
.shopping_bottom {
  flex: 1;
  position: relative;
}
.shopping_bottom .confirm {
  position: absolute;
  width: 92vw;
  height: 9vw;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  border-radius: 4.5vw;
  text-align: center;
  color: white;
  font-size: 14px;
  background: linear-gradient(
    120deg,
    rgb(239, 137, 73) 0%,
    rgb(235, 74, 39) 29%
  );
}
.shopping_top_img {
  width: 21vw;
  height: 28vw;
  position: absolute;
  top: 0;
  bottom: 0;
  margin: auto;
  left: 5vw;
}
.shopping_top > div:nth-of-type(2) {
  width: 60vw;
  height: 10vw;
  position: absolute;
  top: 0;
  bottom: 0;
  margin: auto;
  left: 40vw;
}
.shopping_zj > div:nth-of-type(1) {
  width: 18vw;
  height: 6vw;
  position: absolute;
  top: 0;
  bottom: 0;
  margin: auto;
  left: 5vw;
  font-size: 14px;
  font-weight: 600;
}
.shopping_zj > div:nth-of-type(2) {
  width: 20vw;
  height: 6vw;
  position: absolute;
  top: 0;
  bottom: 0;
  margin: auto;
  left: 80vw;
  font-size: 12px;
  line-height: 6vw;
}
.shopping_zj > div:nth-of-type(2) input {
  width: 10vw;
  border: 0;
  outline: none;
  text-align: center;
  background-color: rgb(246, 246, 246);
  border-radius: 2px;
}
.color {
  color: rgb(246, 246, 246);
}
.tishi {
  min-width: 321px !important;
}
.fukuan {
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.5);
  position: absolute;
  top: 0;
  z-index: 1000;
}
.fukuan_box {
  position: absolute;
  left: 0;right: 0;top: 0;bottom: 0;
  margin: auto;
  width: 83vw;
  height: 67vw;
  background-color: white;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
}
.fukuan_box div:nth-of-type(1) {
  flex: 1;
  text-align: center;
  line-height: 12vw;
  font-size: 14px;
  font-weight: 600;
}
.fukuan_box div:nth-of-type(1) .el-icon-close {
  /* text-align: left;   */
  position: absolute;
  left: 3vw;
  top: 4vw;
}
.fukuan_box div:nth-of-type(2) {
  flex: 2;
  text-align: center;
}
.fukuan_box div:nth-of-type(2) > span {
  font-size: 32px;
  line-height: 20vw;
  font-weight: 700;
}
.fukuan_box div:nth-of-type(3) {
  flex: 2;
}
.fukuan_box div:nth-of-type(3) > input:nth-of-type(1) {
  margin-left: 7.725vw;
}
.fukuan_box div:nth-of-type(3) > input {
  display: inline-block;
  width: 10vw;
  height: 10vw;
  border-radius: 4px;
  margin:7vw 1.5vw 0 0;
  background-color: rgb(246, 246, 246);
  border: 0;
  
  text-align: center;
}
</style>

