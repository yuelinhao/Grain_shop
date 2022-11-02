<template>
  <div class="box">
    <div class="box_s">
      <div><i class="el-icon-arrow-left" @click="back"></i></div>
      <div class="cz"><span>充值</span></div>
      <div></div>
    </div>
    <div class="cz_sr">
      <el-card class="box-card">
        <ul class="msg-box">
          <h4 style="margin-bottom: 15px">充值金额</h4>
          <div class="aa">
            <el-radio-group v-model="amountVal" @change="amountChange">
              <div class="qqq">
                <div class="qql">
                  <el-radio border :label="'' + 100">充值100</el-radio>
                  <el-radio border :label="'' + 1000">充值1000</el-radio>
                  <el-radio border :label="'' + 2000">充值2000</el-radio>
                </div>
                <div class="qqr">
                  <el-radio border :label="'' + 500">充值500</el-radio>
                  <el-radio border :label="'' + 1500">充值1500</el-radio>
                  <el-radio border :label="''">自定义</el-radio>
                </div>
              </div>
            </el-radio-group>
          </div>

          <h4 style="margin-bottom: 15px; margin-top: 15px">充值金额</h4>
          <el-input
            :disabled="disabled"
            clearable
            v-model="rechargeParams.totalAmt"
            placeholder="请输入金额"
            ref="aa_a"
            oninput="value=value.replace(/[^\d]/g,'')"
            style="width: 200px"
          ></el-input>
        </ul>
        <div style="text-align: center; margin-top: 28px">
          <el-button type="primary" @click="surePay">确认支付</el-button>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      amountVal: "",
      disabled: false,
      //充值参数
      rechargeParams: {
        totalAmt: "", //金额
      },
    };
  },
  methods: {
    back() {
      this.$router.go(-1);
    },
    //充值金额
    amountChange(val) {
      this.rechargeParams.totalAmt = val;
      if (val == "") {
        this.disabled = false;
      } else {
        this.disabled = true;
      }
    },
    //确认支付
    async surePay() {
      if (this.rechargeParams.totalAmt == "") {
        this.$message.warning("请输入金额");
        return;
      }
      
      this.$http.post('http://localhost:3000/f_money',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc,user_money:this.$refs.aa_a.value}).then((res)=> {
        // console.log(res)
        this.$router.push({ name: "balance" });
      })
    },
  },
};
</script>

<style scoped>
.msg-box {
  height: 450px;
}
/* .msg-box > li {
  list-style: none;
  float: left;
  border-bottom: 1px solid #c5c5c5;
} */
.box .el-radio.is-bordered {
  border-radius: 4px;
  border: 1px solid #d4d4d4;
  box-sizing: border-box;
  width: 100px;
  height: 40px;
  margin-bottom: 16px;
}

.el-radio {
  color: #606266;
  cursor: pointer;
}
.box .el-radio.is-bordered + .el-radio.is-bordered {
  margin-left: 0px;
}
.box {
  display: flex;
  flex-direction: column;
}
.el-icon-arrow-left {
  color: black;
  font-size: 24px;
}
.box .aa {
  display: flex;
  margin-left: 2px;
  margin-bottom: 10px;
  background-color: white;
  justify-content: center;
}
.qqq {
  display: flex;
}
.qqq > div {
  margin-left: 16px;
  flex: 1;
}
.box_s {
  width: 100%;
  height: 55px;
  display: flex;
  align-items: center;
}
.box_s > div {
  flex: 1;
}
.box_s > div:nth-child(2) {
  text-align: center;
  font-size: 17px;
}
.cz_sr {
  padding: 20px;
  height: 570px;
}
.cz_sr > div:nth-child(2) {
  margin-top: 30px;
}
.ji_er {
  font-size: 20px;
}
</style>