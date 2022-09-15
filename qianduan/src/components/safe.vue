<template>
  <div class="saf">
    <div class="head">
      <i class="el-icon-arrow-left" @click="fan_home"></i>
      <span class="span2"><strong>账号与安全</strong></span>
      <!-- <img
        :src="require('../assets/zhankai(1).png')"
        width="25px"
        height="25px"
        style="position: fixed; right: 15px; top: 9px"
      /> -->
    </div>
    <div class="main">
      <div class="one">
        <div>
          <span>淘宝账号</span>
          <span class="num">1231111111111</span>
        </div>
        <div>
          <span>绑定手机号</span>
          <span class="num">1231111111111</span>
        </div>
        <div>
          <span>实名认证</span>
          <span class="num">未认证</span>
          <img src="../assets/jiantou_liebiaoxiangyou_o.png" width="25px" height="25px"
            style="position: fixed; right: 13px" /><br />
        </div>
        <div @click="pwd_fn" v-if="0">
          <span>设置登录密码</span>
          <img src="../assets/jiantou_liebiaoxiangyou_o.png" width="25px" height="25px"
            style="position: fixed; right: 13px" /><br />
        </div>
        <!-- <div>
          <span>支付宝账号</span>
          <span class="num">1231111111111</span>
          <img
            src="../assets/jiantou_liebiaoxiangyou_o.png"
            width="25px"
            height="25px"
            style="position: fixed; right: 13px"
          /><br />
        </div> -->
      </div>
      <!-- <span class="span1"
        >身份验证&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用于注销、修改密码等关键操作</span
      > -->
      <!-- <div class="two">
        <div>
          <span>扫脸验证</span>
          <span class="num">已开启</span>
          <img
            src="../assets/jiantou_liebiaoxiangyou_o.png"
            width="25px"
            height="25px"
            style="position: fixed; right: 13px"
          />
          <br />
        </div>
        <div>
          <span>声音验证</span>
          <span class="num">已开启</span>
          <img
            src="../assets/jiantou_liebiaoxiangyou_o.png"
            width="25px"
            height="25px"
            style="position: fixed; right: 13px"
          />
          <br />
        </div>
      </div> -->
      <span class="span1">安全工具</span>
      <div class="three">
        <!-- <div>
          <span>登录设备管理</span>
          <span class="num">查看当前在线的设备</span>
          <img
            src="../assets/jiantou_liebiaoxiangyou_o.png"
            width="25px"
            height="25px"
            style="position: fixed; right: 13px"
          />
          <br />
        </div>
        <div>
          <span>账号日志</span>
          <span class="num">查看近期敏感操作</span>
          <img
            src="../assets/jiantou_liebiaoxiangyou_o.png"
            width="25px"
            height="25px"
            style="position: fixed; right: 13px"
          />
          <br />
        </div> -->
        <div @click="suo_ding">
          <span>锁定账号</span>
          <span class="num">账号被盗或手机丢失</span>
          <img src="../assets/jiantou_liebiaoxiangyou_o.png" width="25px" height="25px"
            style="position: fixed; right: 13px" />
          <br />
        </div>
        <!-- <div>
          <span>安全中心</span>
          <img
            src="../assets/jiantou_liebiaoxiangyou_o.png"
            width="25px"
            height="25px"
            style="position: fixed; right: 13px"
          />
          <br />
        </div> -->
      </div>
      <!-- <div class="four">
        <div>
          <span>注销账号</span>
          <img src="../assets/jiantou_liebiaoxiangyou_o.png" width="25px" height="25px"
            style="position: fixed; right: 13px" />
          <br />
        </div>
      </div> -->
    </div>
  </div>
</template>
  
  <script>
export default {
  name: "safe",
  methods: {
    suo_ding() {
      this.$router.push({name:'lock_account'})
    },
    fan_home() {
      this.$router.replace({ name: 'my' })
    },
    pwd_fn(){
      this.$router.push({ name: 'pwd' })
    }
  },
};
</script>
  
  <style scoped>
  .head .el-icon-arrow-left {
    font-size: 23px;
    color: white;
    margin: 0 2vw;
  }
  
  .item {
    margin-top: 10px;
    margin-right: 40px;
  }
  
  .span1 {
    font-size: 14px;
    padding: 4px;
    color: black;
  }
  
  .span2 {
    font-size: 20px;
  }
  
  .num {
    position: absolute;
    right: 33px;
  }
  
  .wenzi {
    position: relative;
    right: 0px;
  }
  
  * {
    padding: 0;
    margin: 0;
  }
  
  .saf {
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    background-color: rgb(244, 244, 244);
    display: flex;
    flex-direction: column;
  }
  
  .head {
    flex: 2;
    line-height: 48px;
    background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
    color: white;
  }
  
  .main {
    flex: 25;
    display: flex;
    flex-direction: column;
  }
  
  .main>div {
    margin: 8px;
  }
  
  .one {
    /* flex: 5; */
    width: 88%;
    height: 23%;
    padding: 15px;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    background-color: white;
  }
  
  .one>div {
    flex: 1;
    border-bottom: 1px solid rgba(206, 204, 204, 0.2);
  }
  
  .two {
    /* flex: 2; */
    padding: 15px;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    background-color: white;
  }
  
  .two>div {
    flex: 1;
    border-bottom: 1px solid rgba(206, 204, 204, 0.2);
  }
  
  .three {
    /* flex: 4; */
    width: 88%;
    height: 4%;
    padding: 15px;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    background-color: white;
  }
  
  .three>div {
    flex: 1;
  }
  
  .four {
    width: 88%;
    height: 4%;
    padding: 15px;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    background-color: white;
  }
  
  .four>div {
    flex: 1;
  }
  </style>