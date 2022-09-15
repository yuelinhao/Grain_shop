<template>
  <div class="box">
    <div id="box_1">
      <div class="tong_biao">

        <div class="ss1">
          
            <!-- <img
              @click="fan_my"
              class="ff1"
              src="@/assets/img/更多2.png"
              alt=""
            /> -->
            <i class="el-icon-arrow-left" @click="fan_my"></i>
            <span class="span1"><strong>订单统计</strong></span>
         
        </div>
        
      </div>
      <div class="tong_body">
        <div class="tong_b">
          <div class="ll">
            <img class="tong_img" src="@/assets/img/统计列表.png" alt="" />
          </div>
          <div class="rr"><span>统计数据</span></div>
        </div>
        <div class="tong_c">
          <ul>
            <li
              @click="qie_fn(item)"
              v-for="(item, index) in list"
              :key="index"
              :class="{ active: currentIndex == index }"
            >
              {{ item.name }}
            </li>
          </ul>
        </div>
        <div class="tong_d">
          <router-view></router-view>
        </div>
      </div>
    </div>
  </div>
</template>
  
  <script>
export default {
  data() {
    return {
      currentIndex: 0,
      list: [
        {
          name: "已开票",
          lujing: "yi",
        },
        {
          name: "已开票按物品",
          lujing: "er",
        },
        {
          name: "订单",
          lujing: "san",
        },
        {
          name: "订单按物品",
          lujing: "si",
        },
      ],
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        },
      },
      value1: "",
      value2: "",
    };
  },
  methods: {
    qie_fn(cc) {
      this.currentIndex = cc;
      this.$router.push({ path: cc.lujing });
    },
    fan_my() {
      this.$router.push("/my");
    },
  },
};
</script>
  
  <style scoped>
    .el-icon-arrow-left {
      font-size: 23px;
      color: white;
      margin:0 2vw;
      position: absolute;
      top: 14px;
    }
  #box_1 {
    display: flex;
    height: 100vh;
    background-color: rgb(234, 234, 234);
    flex-direction: column;
    align-items: center;
    overflow: hidden;
  }
  .box{
    width: 100vw;
    height: 100vh;
    overflow: hidden;
  }
  .tong_body {
    width: 95%;
    height: 570px;
    display: flex;
    border-radius: 10px;
    flex-direction: column;
    background-color: rgb(255, 255, 255);
    margin-top: -150px;
    overflow: hidden;
  }
  
  .active {
    color: crimson;
    border-bottom: 2px solid crimson;
  }
  
  .tong_a {
    display: flex;
    height: 60px;
  }
  
  .a_l {
    flex: 1.5;
    font-size: 19px;
    line-height: 64px;
  }
  
  .a_r {
    flex: 4;
    line-height: 60px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  
  .a_r1 {
    width: 120px;
    overflow: hidden;
  }
  
  .a_r2 {
    width: 120px;
    overflow: hidden;
  }
  
  .tong_b {
    height: 30px;
    display: flex;
    padding: 10px;
    font-size: 20px;
    font-weight: 600;
  }
  
  .tong_img {
    width: 30px;
    height: 30px;
  }
  
  .tong_c {
    height: 40px;
    border-top-left-radius: 2px;
    border-top-right-radius: 2px;
    background-color: #ebebeb;
  }
  
  .tong_d {
    height: 400px;
  }
  
  .tong_c>ul {
    padding: 0;
    list-style: none;
  
  }
  
  .tong_c>ul>li {
    float: left;
    width: 84px;
    height: 40px;
    font-size: 14px;
    font-weight: 600;
    text-align: center;
    line-height: 40px;
  }
  
  .tong_c>ul>li:hover {
    color: crimson;
    border-bottom: 2px solid crimson;
  }
  
  .tong_biao {
    width: 100vw;
    height: 229px;
   
  }
  
  .ss1 {
    height: 48px;
    
    color: white;
    background:linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
  }  
  .ff1 {
    float: left;
    width: 40px;
    transform: rotate(180deg);
    margin-right: 4px;
    margin-top: 24px;
  }
  .span1 {
    font-size: 20px;
    position: absolute;
    top: 14px;
    left: 43px;
  }
  
  </style>