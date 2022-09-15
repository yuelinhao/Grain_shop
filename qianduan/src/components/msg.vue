<template>
  <div class="xx">
    <div class="head">
      <i class="el-icon-arrow-left" @click="retur"></i>
      <span class="span2"><strong>消息设置</strong></span>
      <!-- <img
        src="../assets/zhankai (1).png"
        width="25px"
        height="25px"
        style="position: fixed; right: 15px; top: 9px"
      /> -->
    </div>
    <div class="shang">
      <span class="shezhi">消息通知设置</span>
      <span class="num1">消息通知已打开</span>
      <br />
    </div>
    <div class="main">    
      <div class="one">
        <div>
          <span>接受消息通知：</span>
          <span class="num">已开启</span>
          <img
            src="../assets/jiantou_liebiaoxiangyou_o.png"
            width="25px"
            height="25px"
            style="position: fixed; right: 13px"
          />
          <br />
        </div>
      </div>
      <div class="two">
        <div>
          <span class="span3">聊天消息通知:</span>
          <br />
        </div>
        <div>
          <span>店铺客服接待</span>
          <el-switch
          v-model="value1"
          active-color="#13ce66"
          inactive-color="gray">
        </el-switch>
          <br />
        </div>
        <div>
          <span>淘宝好友聊天</span>
          <el-switch
          v-model="value2"
          active-color="#13ce66"
          inactive-color="gray">
        </el-switch>
          <br />
        </div>
        <div>
          <span>群聊消息</span>
          <el-switch
          v-model="value3"
          active-color="#13ce66"
          inactive-color="gray">
        </el-switch>
          <br />
        </div>
      </div>
      <div class="three">
        <div>
          <span class="span3">平台消息通知：</span>
         <img src="../assets/wenhao.png" width="15px" height="15px">
          <br />
        </div>
        <div>
          <span>交易物流通知（物流动态、退换货提醒）</span>
          <el-switch
          v-model="value4"
          active-color="#13ce66"
          inactive-color="gray">
        </el-switch>
          <br />
        </div>
        <div>
          <span>活动优惠（官方大促、购物车降价等）</span>
          <el-switch
          v-model="value5"
          active-color="#13ce66"
          inactive-color="gray">
        </el-switch>
          <br />
        </div>
        <div>
          <span>服务通知（你主动设置的消息提醒）</span>
          <el-switch
          v-model="value6"
          active-color="#13ce66"
          inactive-color="gray">
        </el-switch>
          <br />
        </div>
        <div>
          <span>互动通知（评论、点赞、关注等）</span>
          <el-switch
          v-model="value7"
          active-color="#13ce66"
          inactive-color="gray">
        </el-switch>
          <br />
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "msg",
  data(){
    return {
        value1: true,
        value2: true,
        value3: false,
        value4: true,
        value5: true,
        value6: true,
        value7: false
      }
  },
  methods: {
    retur() {
      this.$router.replace({name:'my'})
    },
  },
};
</script>
<style scoped>
  .num1{
    color: grey;
    position: absolute;
    right: 18px;
    font-size: 13px;
  }
  .el-switch{
    position: fixed;
    right: 23px;
  }
.shezhi{
  font-size: 18px;
}
.xx {
  width: 100vw;
  height: 100vh;
  overflow: hidden;
  background-color: rgb(244, 244, 244);
  display: flex;
  flex-direction: column;
}
.head {
  flex: 1;
  line-height: 48px;
  background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
}
.main {
  flex: 20;
  display: flex;
  padding: 6px;
  flex-direction: column;
}
.main > div {
  margin: 9px;
  padding: 17px;
}
.shang{
  padding: 7px;
}
.one {
  flex: 1;
  display: flex;
  flex-direction: column;
  background-color: white;
  border-radius: 10px;

}
.two {
  flex: 6;
  display: flex;
  flex-direction: column;
  background-color: white;
  border-radius: 10px;
  font-size: 13px;
}
.two>div{
  flex: 1;
  border-bottom: 1px solid rgba(206, 204, 204, 0.2);
}
.three {
  flex: 9;
  display: flex;
  flex-direction: column;
  background-color: white;
  border-radius: 10px;
  font-size: 13px;
}
.three>div{
  flex: 1;
  border-bottom: 1px solid rgba(206, 204, 204, 0.2);
}
.span2 {
  font-size: 18px;
  color: white;
}
.span3{
  color: grey;
  font-size: 16px;
}
.num {
  position: absolute;
  right: 33px;
  color: grey;
}
.el-icon-arrow-left:before{
  color: white;
  font-size: 23px;
}
</style>