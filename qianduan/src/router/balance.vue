<template>
  <div id="app">
    <div class="da">
      <div class="da_top">
        <!-- <img src="./assets/返回.png" alt=""> -->
        <i class="el-icon-arrow-left" @click="back"></i>
      </div>
      <div class="money">
        <img src="../assets/钱.png" alt="" />
        <span>我的零钱</span>
        <div class="beikengdeqian" v-if="my_user.length >0">
          <span class="icon_qian">￥</span
          ><span class="beikeng_num" >{{price}}</span>
        </div>
      </div>
      <div class="kengqian">
        <button @click="cz_fn" class="kenqian_button">充值</button>
      </div>
      <div @click="kefu_fn()" class="kefu"><span>联系客服</span></div>
    </div>
  </div>
</template>
  
<script>
export default {

  data() {
    return {
        price: 0,
        my_user: [],
    };
  },
  methods: {
    back() {
      this.$router.push('/my');
    },
    cz_fn() {
      this.$router.push("/chongzhi");
    },
  },
  created() {
    // this.price = this.$route.params.price;
    // this.$http.post('http://localhost:3000/')
    this.$http.post('http://localhost:3000/get_user_info',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc}).then((res)=> {
      // console.log(res.data.value);
      if (res.data.value[0]) {
        this.my_user = res.data.value
        this.price = res.data.value[0].user_money
      }
      
    })
  },
};
</script>
  
<style scoped>
.el-icon-arrow-left {
  color: black;
  font-size: 24px;
  padding: 0 2vw;
}

.da {
  width: 100vw;
  height: 100vh;
  background-color: #ffffff;
}

.da_top {
  width: 100%;
  height: 8%;
  display: flex;
  align-items: center;
}

.da_top > img {
  width: 25px;
  height: 25px;
  margin-left: 10px;
}

.money {
  width: 100%;
  height: 40%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.money > img {
  width: 60px;
  height: 60px;
  margin-bottom: 30px;
}

.money > span {
  font-family: "微软雅黑";
  font-size: 17px;
  color: black;
  font-weight: 500;
  letter-spacing: 1px;
}

.beikengdeqian {
  width: 90%;
  height: 20%;
  /* background-color: aqua; */
  display: flex;
  justify-content: center;
  margin-top: 5px;
}

.icon_qian {
  font-family: "微软雅黑";
  font-size: 30px;
  color: black;
  font-weight: 700;
  margin-right: 2px;
}

.beikeng_num {
  font-family: "微软雅黑";
  font-size: 38px;
  color: black;
  font-weight: 700;
  letter-spacing: 2px;
}

.kengqian {
  width: 100%;
  height: 32%;
  display: flex;
  justify-content: center;
  align-items: flex-end;
}

.kenqian_button {
  width: 35%;
  height: 18%;
  background-color: #2964a0;
  border: 1px solid #f2f2f2;
  border-radius: 5px;
  font-family: "微软雅黑";
  font-size: 16px;
  color: #ffffff;
  letter-spacing: 2px;
}

.kefu {
  width: 100%;
  height: 20%;
  display: flex;
  justify-content: center;
  align-items: flex-end;
}

.kefu > span {
  margin-bottom: 18px;
  font-family: "微软雅黑";
  font-size: 14px;
  color: #5c6587;
  /* letter-spacing: 2px; */
}
</style>
  