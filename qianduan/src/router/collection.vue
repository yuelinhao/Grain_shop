<template>
    <div class="app">
      <div class="page">
        <div class="page_top">
          <div class="page_top_shang">
            <div @click="back" class="back">
              <img src="../static/img/fanhui.png" alt="">
            </div>
            <span class="page_title">我的收藏</span>
          </div>
          <div class="page_top_xia">
            <div class="page_top_xia_left">
              <span class="page_top_p page_top_p1">全部收藏</span><span class="page_top_p">({{goods_list.length}})</span>
            </div>
            <!-- <div class="page_top_xia_right">
              <span @click="guan_li()" class="manage page_top_p page_top_p2">管理</span>
              <span @click="qu_xiao()" class="cancle page_top_p page_top_p2">取消</span>
            </div> -->
          </div>
        </div>
        <div class="page_center">
          <div class="page_center_list">
            <div @click="xiangqing(item)" class="list1" v-for="(item,index) in goods_list" :key="index">
              <!-- <div class="list1_left">
                <div class="hhh" @click="h_click(item)" :class="{or_hhh: item.aa == 1}"></div>
              </div> -->
              <div class="list1_center">
                <div class="list1_center_left">
                  <img :src="'http://192.168.0.135:3000/img/' + item.g_img + '.jpg'" alt="">
                </div>
                <div class="list1_center_right">
                  <div class="name p"><span>{{item.g_name}}</span></div>
                  <div class="jieshao p"><span><span>{{item.g_size}}</span>公斤/袋</span></div>
                  <div class="jiage p"><span>￥</span><span>{{item.g_price}}</span></div>
                </div>
              </div>
              <!-- <div class="list1_right">
                <div class="bianxing">
                  <div @click="jian_fn(item.number,index)" class="jia a"><img src="../assets/－.png" alt=""></div>
                  <div class="num"><span>{{item.number}}</span></div>
                  <div @click="item.number++" class="jian a"><img src="../assets/＋.png" alt=""></div>
                </div>
              </div> -->
            </div>
          </div>
        </div>
        <!-- <div class="page_bottom">
          <div class="page_bottom_shang">
            <div class="left_quanxuan">
              <div class="fff" @click="f_click()" :class="{or_fff: aa == 1}"></div>
              <span>全选</span>
            </div>
            <div class="center_heji">
            </div>
            <div class="right_aa right_jiesuan">
            </div>
            <div @click="yichu_fn()" class="right_bb dis_bl">
              <span class="bl_yichu">移出收藏夹</span>
            </div>
          </div>
        </div> -->
      </div>
    </div>
  </template>
  
  <script>
    export default {
      created() {
        this.$http.post('http://192.168.0.135:3000/get_collect',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc}).then((res)=> {
          this.goods_list = res.data.value
        })
      },
      data() {
        return {
          aa: 0,
          goods_list: []
        }
      },
      computed: {
        total_price() {
          let aa = 0
          let a = this.goods_list.filter((item)=> {
            return item.aa == 1
          })
          a.forEach((item)=> {
            aa+=item.number * item.price
          })
          return aa
        }
      },
      methods: {
        // 详情点击跳转
        xiangqing(res){
          console.log(1111);
         this.$router.push({name:"goods_detail",params:{detail:res}})
        },
        back() {
            this.$router.go(-1)
        },
        h_click(res){
          if (res.aa == 1) {
            res.aa = 0
            this.aa = 0
          } else {
            res.aa = 1
            let bb = this.goods_list.filter((item)=> {
              return item.aa == 0
            })
            if(bb.length>0) {
              this.aa = 0
            } else {
              this.aa = 1
            }
          }
          // this.aa = this.aa == 1 ? 0 : 1
        },
        f_click(){
          if (this.aa == 1) {
            this.aa = 0
            this.goods_list.forEach((item)=> {
              item.aa = 0
            })
          } else {
            this.aa = 1
            this.goods_list.forEach((item)=> {
              item.aa = 1
            })
          }
          // this.aa = this.aa == 1 ? 0 : 1
        },
        jian_fn(num,index) {
          if(num<=1) {
            num = 1
          } else {
            this.goods_list[index].number--
          }
        },
        guan_li() {
          var right_aa = document.querySelector(".right_aa")
          var right_bb = document.querySelector(".right_bb")
          var manage = document.querySelector(".manage")
          var cancle = document.querySelector(".cancle")
          right_aa.style.display="none"
          right_bb.style.display="block"
          manage.style.display="none"
          cancle.style.display="block"
          console.log(111);
        },
        qu_xiao() {
          var right_aa = document.querySelector(".right_aa")
          var right_bb = document.querySelector(".right_bb")
          var manage = document.querySelector(".manage")
          var cancle = document.querySelector(".cancle")
          right_aa.style.display="block"
          right_bb.style.display="none"
          manage.style.display="block"
          cancle.style.display="none"
          console.log(222);
        },
        yichu_fn() {
          var right_aa = document.querySelector(".right_aa")
          var right_bb = document.querySelector(".right_bb")
          var manage = document.querySelector(".manage")
          var cancle = document.querySelector(".cancle")
          right_aa.style.display="block"
          right_bb.style.display="none"
          manage.style.display="block"
          cancle.style.display="none"
          console.log(333);
        }
      }
    }
  </script>
  
  <style scoped>
  #app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
  }
  .page{
    width: 100vw;
    height: 100vh;
    background-color: #f6f6f6;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
  }
  .page_top{
    width: 100%;
    height: 13%;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
  }
  .page_top_shang{
    width: 100%;
    height: 70%;
    background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
    color: white;
    display: flex;
    justify-content: flex-start;
    align-items: center;
  }
  .back{
    width: 10%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .back>img{
    width: 20px;
    height: 20px;
  }
  .page_title{
    width: 80%;
    height: 100%;
    display: flex;
    align-items: center;
    font-size: 18px;
    font-family: "微软雅黑";
    font-weight: 700;
  }
  .page_top_xia{
    width: 95%;
    height: 30%;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .page_top_xia_left{
    width: 50%;
    height: 100%;
    display: flex;
    align-items: center;
  }
  .page_top_p{
    font-size: 16px;
    font-family: "微软雅黑";
  }
  .page_top_p1{
    margin-left: 15px;
  }
  .page_top_xia_right{
    width: 30%;
    height: 100%;
    display: flex;
    justify-content: flex-end;
    align-items: center;
  }
  .page_top_p2{
    margin-right: 15px;
  }
  .cancle{
    display: none;
  }
  .page_center{
    width: 100%;
    height: 87%;
    display: flex;
    justify-content: center;
    overflow-y: scroll;
    overflow-x: hidden;
  }
  .page_center_list{
    width: 95%;
  }
  .list1{
    width: 100%;
    height: 130px;
    background-color: #ffffff;
    border-radius: 10px;
    overflow: hidden;
    margin-bottom: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .list1_left{
    width: 10%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .hhh{
    width: 20px;
    height: 20px;
    overflow: hidden;
    border: 1.5px solid rgba(0,0,0,.5);
    border-radius: 50%;
  }
  .or_hhh {
    background-image:url(../assets/选中.png);
    background-position: center;
    background-size: cover;
    border: 0;
  }
  .xiaoshi{
    display: none;
  }
  .list1_center{
    width: 90%;
    height: 100%;
    display: flex;
    justify-content: flex-start;
    align-items: center;
  }
  .list1_center_left{
    width: 40%;
    height: 100%;
    padding: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .list1_center_left>img{
    width: 70%;
    height: 80%;
    background-position: center;
    background-size: cover;
  }
  .list1_center_right{
    width: 60%;
    height: 80%;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: flex-start;
  }
  .p{
    width: 100%;
    height: 30%;
    display: flex;
    align-items: center;
  }
  .name>span{
    font-size: 18px;
    font-family: "微软雅黑";
    color: #333333;
    font-weight: 600;
    letter-spacing: 1px;
  }
  .jieshao>span{
    background-color: #f6f6f6;
    padding: 5px;
    font-size: 12px;
    font-family: "微软雅黑";
    color: #6c6c6c;
    border-radius: 5px;
  }
  .jiage>span{
    font-size: 16px;
    font-family: "微软雅黑";
    color: #eb4926;
    font-weight: 600;
    letter-spacing: 1px;
  }
  .list1_right{
    width: 30%;
    height: 100%;
    display: flex;
    align-items: flex-end;
  }
  .bianxing{
    width: 100%;
    height: 30%;
    margin-bottom: 20px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
  }
  .a{
    width: 30%;
    height: 80%;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .a>img{
    width: 15px;
    height: 15px;
    background-position: center;
    background-size: cover;
  }
  .num{
    width: 40%;
    height: 60%;
    background-color: #f6f6f6;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 5px;
  }
  .num>span{
    font-size: 16px;
    font-family: "微软雅黑";
    color: #353535;
    font-weight: 550;
  }
  .page_bottom{
    width: 100%;
    height: 8%;
    display: flex;
    flex-direction: column;
    background-color: #ffffff;
    overflow: hidden;
  }
  .page_bottom_shang{
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: flex-start;
    align-items: center;
  }
  .left_quanxuan{
    width: 25%;
    height: 80%;
    display: flex;
    justify-content: flex-start;
    align-items: center;
  }
  .fff{
    margin-left: 10px;
    width: 20px;
    height: 20px;
    overflow: hidden;
    border: 1.5px solid rgba(0,0,0,.5);
    border-radius: 50%;
  }
  .or_fff{
    background-position: center;
    background-size: cover;
    background-image: url(../assets/选中.png);
    border: 0;
  }
  .left_quanxuan>span{
    margin-left: 10px;
    font-size: 18px;
    font-family: "微软雅黑";
    color: #9d9d9d;
    letter-spacing: 2px;
  }
  .center_heji{
    width: 37%;
    height: 80%;
    display: flex;
    justify-content: flex-start;
    align-items: center;
  }
  .center_heji_wenzi{
    font-size: 16px;
    font-family: "微软雅黑";
    color: #353535;
  }
  .center_heji_fuhao{
    font-size: 15px;
    font-family: "微软雅黑";
    color: #ed4926;
  }
  .center_heji_num{
    font-size: 20px;
    font-family: "微软雅黑";
    color: #ed4926;
    font-weight: 550;
  }
  .right_jiesuan{
    width: 35%;
    height: 70%;
    border-radius: 50px;
  }
  .dis_bl{
    width: 35%;
    height: 70%;
    background: linear-gradient(to right,#f09153 10%, #eb4d28 40%);
    border-radius: 50px;
    display: none;
  }
  .bl_yichu{
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 15px;
    font-family: "微软雅黑";
    color: #ffffff;
    letter-spacing: 2px;
  }
  </style>
  