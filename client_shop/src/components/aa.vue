<template>
  <div class="box">
    <div class="cc">
      <div class="cc_s">
        <div>
          <img @click="fan_home" class="f1" src="@/assets/img/更多2.png" alt="" />
        </div>
        <div class="ding_zi">
        <span class="lie_biao">订单列表</span>
        </div>
        <div></div>
      </div>
      <div class="tong_li">
        <div v-for="(item, index) in tabList" :key="index" @click="qie_fn(index)"
          :class="{ Sidebar: current == index }">
          <div :class="{ sidebar_inner: current == index }">
            {{ item.name }}
          </div>
        </div>
      </div>
      <div class="one">
        <div class="list" v-for="item in goods" :key="item.id">
          <span>订单编号：{{ item.o_id }}</span><span class="zt"
            :class="[item.o_status == '0' ? 'red' : '', item.o_status == '1' ? 'blue' : '', item.o_status == '2' ? 'yellow' : '', item.o_status == '3' ? 'green' : '', item.o_status == '4' ? 'burlywood' : '']">{{
                status_fn(item.o_status)
            }}</span>
          <div class="list_x">
            <div class="list_l">
              <div class="img1">
                <img :src="'http://localhost:3000/img/' + item.g_img + '.jpg'" alt="" />
              </div>
              <div class="list_imgr">
                <span class="wu">{{ item.g_name }}</span>
                <div class="dai1">
                  <span>{{ item.g_size }}公斤/袋</span>
                </div>
              </div>
            </div>
            <div class="list_r">
              <p>￥{{ item.g_price }}</p>
              <br />
              <p class="num">X{{ item.g_number }}</p>
              <br />
              <p class="hui">实付款 ￥{{ item.g_price * item.g_number}}</p>
              <br />
              <div class="que_ren"><span @click="goPay(item.g_price * item.g_number,item)">{{ anniu(item.o_status) }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
  <script>
export default {
  data() {
    return {
      tabList: [
        { type: 5, name: "全部" },
        { type: 0, name: "待付款" },
        { type: 1, name: "待发货" },
        { type: 2, name: "已发货" },
        { type: 3, name: "已收货" },
      ],
      goods: [],
      current: 0,
    };
  },
  methods: {
    // 判断按钮text
    anniu(type) {
      if (type == 0) {
        return '去付款'
      } else if (type == 1) {
        return '提醒发货'
      } else if (type == 2) {
        return '确认收货'
      } else if (type == 3) {
        return '去评价'
      }
    },
    status_fn(status) {
      let aa = ''
      if (status == 0) {
        aa = '待付款'
      } else if (status == 1) {
        aa = '待发货'
      } else if (status == 2) {
        aa = '已发货'
      } else if (status == 3) {
        aa = '已收货'
      }
      return aa
    },
    goPay(money,item) {
      if (this.current == 1) {
        this.$bus.$emit("goPay", { sure: 1, money})
      }else if(this.current == 2) {
        console.log('提醒发货');
        this.$message.success('已提醒发货')
      } else if(this.current == 3) {
        console.log('确认收货');
        this.$http.post('http://localhost:3000/o_received',{o_id:item.o_id,o_status:3}).then((res)=> {
          this.$bus.$emit('isMain')
      })
      } else if (this.current == 4) {
        this.$message.warning('此功能暂未开放 敬请期待')
      }
      // this.$router.replace({ name: "aa", params: { isAll: false, type: 1 } });
    },
    
    qie_fn(cc) {
      this.current = cc;
      let url = 0
      if (cc == 0) {
        url = 'o_SelectAll'
        this.$http.post('http://localhost:3000/' + url + '', { user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc }).then((res) => {
          this.goods = res.data.value
        })
      } else {
        url = 'o_select'
        this.$http.post('http://localhost:3000/' + url + '', { user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc, o_status: cc - 1 }).then((res) => {
          this.goods = res.data.value
        })
      }
    },
    fan_home() {
      this.$router.push("/my");
    },
  },
  created() {
    let { isAll, type } = this.$route.params
    if (isAll) {
      this.$http.post('http://localhost:3000/' + type + '', { user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc }).then((res) => {
        this.goods = res.data.value
      })
    } else {
      this.$http.post('http://localhost:3000/o_select', { o_status: type, user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc }).then((res) => {
        this.goods = res.data.value
        this.current = (type - 0) + 1
      })
    }
    // 监听支付
    this.$bus.$on('isPay',()=> {
      this.qie_fn(1)
    })
    // 监听收货
    this.$bus.$on('isMain',()=> {
      this.qie_fn(3)
    })

  },
};
</script>
  <style scoped>
    .lie_biao{
      position: absolute;
      top: 6px;
      left: 32px;
    }
  .red {
    color: #ff1111;
  }
  
  .blue {
    color: #4a9eff;
  }
  .green{
    color: #51c300;
  }
  .burlywood{
    color: burlywood;
  }
  .yellow{
    color:darkgoldenrod
  }
  .Sidebar {
    color: #356096;
  }
  
  .sidebar_inner {
    border-bottom: 3.5px solid #356096;
    box-sizing: border-box;
  }
  
  .box {
    width: 100%;
    height: 100%;
    position: absolute;
    z-index: 222;
  }
  
  .cc {
    display: flex;
    height: 100vh;
    flex-direction: column;
    align-items: center;
    background-color: #f6f6f6;
  }
  
  .cc_s {
    width: 100vw;
    height: 55px;
    line-height: 55px;
    font-size: 19px;
    font-weight: 600;
    color: white;
    display: flex;
    text-align: center;
    background-color: #21528a;
  }
  
  .cc_s>div {
    flex: 1;
  }
  
  .f1 {
    float: left;
    width: 25px;
    margin-top: 18px;
    transform: rotate(180deg);
  }
  
  .tong_li>div {
    float: left;
    width: 75px;
    height: 40px;
    border: 0px;
    text-align: center;
    line-height: 40px;
    font-size: 15px;
    font-weight: 600;
  }
  
  .tong_li>div:hover {
    color: #21528a;
    border-bottom: 3.5px solid #21528a;
  }
  
  ul {
    list-style: none;
  }
  
  li {
    font-size: 16px;
    font-weight: 600;
    float: left;
    padding: 8px;
  }
  
  li:hover {
    color: red;
    border-bottom: 3px solid red;
  }
  
  li.active {
    color: red;
    transition: all 0.8s;
  }
  
  .one {
    width: 96%;
    height: 568px;
    display: flex;
    flex-direction: column;
    align-items: center;
    overflow: scroll;
  }
  </style>