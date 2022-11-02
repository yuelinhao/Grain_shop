<template>
  <div class="box">
    <div id="box_1">
      <div class="ding_header">
        <div class="ss">
          <div>
            <i class="el-icon-arrow-left" @click="fan_my"></i>
            <span class="span1"><strong>我的对账单</strong></span>
          </div>
          <div class="fan">
            <div class="tc"></div>
          </div>
        </div>
        <div class="a">
          <div class="jing_er">
            <div><img class="jin" src="@/assets/img/金额.png" alt="" /></div>
            <div class="jin_zi">金额明细</div>
            <div class="jing_x">
              <div class="ying_fu">
                <p class="yi_fu">已付金额(元)</p>
                <p class="zi_1">
                  {{ sumPrice.toFixed(0) }}
                </p>
              </div>
              <div class="yu_er">
                <p class="yu_1">余额(元)</p>
                <p class="zi_2"><span>{{ sumAmount.toFixed(0) }}</span></p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="ding_body">
        <div class="tong_ji">
          <div class="tong_z">
            <div>
              <img class="jin1" src="@/assets/img/统计列表.png" alt="" />
            </div>
            <div class="jin_zi">金额明细</div>
          </div>
          <div class="tong_x1">
            <div class="ke_cun">
              <template>
                <el-table :data="tableData" style="width: 100%;overflow: scroll;" height="350">
                  <el-table-column fixed prop="o_id" label="编号" width="80">
                  </el-table-column>
                  <el-table-column prop="g_sum" label="数量" width="77">
                  </el-table-column>
                  <el-table-column prop="o_price" label="金额" width="77">
                  </el-table-column>
                  <el-table-column prop="user_balance" label="余额" width="77">
                  </el-table-column>
                </el-table>
              </template>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
  <script src=""></script>
  <script>
export default {
  created(){
    this.$http.post("http://localhost:3000/get_bill",{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc}).then((res)=>{
      this.tableData = res.data.value
      console.log(res.data.value);
    })
  },
  data: () => ({
    str: "",
    tableData: [
    ],
  }),
  computed: {
    sumAmount(){
        return this.tableData
        .map(row => row.user_balance)
        .reduce((acc,cur)=> parseFloat(cur) ,0)
      },


      sumPrice(){
        return this.tableData
        .map(row => row.o_price)
        .reduce((acc,cur)=> parseFloat(cur) + acc,0)
      }
  },
  methods: {
    fan_my() {
      this.$router.push("/my");
    },
  },
};
</script>
  
  <style scoped>
  .ke_cun {
    margin-top: 6px;
    height: 500px;
  }
  
  .cell {
    text-align: center;
  }
  
  .box {
    width: 100%;
    height: 100%;
    position: absolute;
    z-index: 222;
    overflow: hidden;
  }
  
  .a {
    width: 100vw;
    height: 210px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  
  .a_list {
    display: flex;
    overflow: scroll;
  }
  
  .a_list>div {
    height: 30px;
    text-align: center;
    line-height: 30px;
    flex: 1;
  }
  
  .a_list:nth-child(odd) {
    background-color: #eff6ff;
  }
  
  .ming {
    height: 30px;
    line-height: 30px;
    background-color: #eeeeee;
  }
  
  ul>li {
    width: 77px;
    font-size: 16px;
    font-weight: 600;
    text-align: center;
    list-style: none;
    float: left;
  }
  
  input {
    width: 190px;
    height: 27px;
    border: 1px solid rgb(223, 223, 219);
    margin-top: 7px;
  }
  
  #box_1 {
    display: flex;
    height: 100%;
    background-color: #eeeeee;
    flex-direction: column;
  }
  
  .ding_header {
    height: 218px;
    background: rgb(28, 75, 122);
    z-index: 3;
    border-radius: 0% 0% 90% 90%/0% 0% 40% 40%;
  }
  
  .ss {
    height: 62px;
    display: flex;
    color: white;
  }
  
  .zi_tou {
    line-height: 80px;
    font-family: "Microsoft YaHei";
    font-size: 20px;
    text-align: center;
  }
  
  .ss>div {
    flex: 1;
  }
  
  .fan {
    float: right;
  }
  
  .ff {
    float: left;
    width: 40px;
    margin-top: 24px;
    transform: rotate(180deg);
  }
  
  .tc {
    width: 100px;
    height: 40px;
    position: relative;
    top: 10%;
    border-radius: 33px;
    float: right;
  }
  
  .ding_body {
    width: 100vw;
    height: 448px;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 7px;
  }
  
  .jing_er {
    width: 94%;
    height: 132px;
    font-size: 18px;
    border-radius: 10px;
    background-color: white;
  }
  
  .tong_ji {
    width: 82%;
    height: 378px;
    margin-top: 13px;
    border-radius: 10px;
    display: flex;
    background-color: white;
    padding: 22px;
    flex-direction: column;
    align-items: center;
  }
  
  .left {
    background-color: blue;
    width: 60px;
    height: 30px;
  }
  
  .right {
    background-color: rgb(255, 0, 68);
    width: 60px;
    height: 30px;
  }
  
  .jing_x {
    width: 100%;
    height: 80px;
    margin-top: 10px;
    z-index: 40;
    display: flex;
    align-items: center;
    text-align: center;
    position: relative;
    left: 4%;
  }
  
  .jing_zz {
    display: flex;
    height: 70px;
    margin-top: -10px;
    text-align: center;
    margin-right: 10px;
    align-items: center;
    font-size: 16px;
    justify-content: center;
  }
  
  .jing_x>div {
    flex: 1;
  }
  
  .ying_fu {
    height: 30px;
    font-size: 18px;
    border-right: 2px solid rgb(153, 159, 159);
    margin-right: 20px;
  }
  
  .yi_fu {
    height: 20px;
    color: #529c9c;
  }
  
  .yu_er {
    margin-right: 20px;
    margin-top: 10px;
    height: 20px;
  }
  .yu_1{
    margin-top: -25px;
  }
  .zi_2{
    margin-top: 10px;
  }
  .jin {
    float: left;
    width: 30px;
    height: 30px;
    margin-left: 6px;
    margin-top: 5px;
  }
  
  .jin1 {
    float: left;
    width: 25px;
    height: 25px;
    margin-top: 5px;
  }
  
  .cell {
    text-align: center;
  }
  
  .jin_zi {
    margin-top: 5px;
    font-size: 20px;
  }
  
  .tong_z {
    width: 104%;
    margin-bottom: 5px;
    height: 31px;
  }
  
  .tong_x1 {
    width: 103%;
    height: 320px;
    display: flex;
    flex-direction: column;
    /* overflow: scroll; */
  }
  
  p {
    font-weight: 600;
    margin-top: -12px;
  }
  
  .zi_1 {
    color: #529c9c;
    margin-top: 10px;
  }
  
  .box {
    width: 100%;
    height: 100%;
    position: absolute;
    z-index: 222;
    overflow: hidden;
  }
  
  .el-icon-arrow-left {
    font-size: 23px;
    color: white;
    margin: 1vw 2vw;
    position: absolute;
    top: 14px;
  }
  
  .span1 {
    font-size: 20px;
    position: absolute;
    top: 14px;
    left: 43px;
  }
  
  .a_list {
    display: flex;
    overflow: scroll;
  }
  
  .a_list>div {
    height: 30px;
    text-align: center;
    line-height: 30px;
    flex: 1;
  }
  
  .a_list:nth-child(odd) {
    background-color: #eff6ff;
  }
  
  .ming {
    height: 30px;
    line-height: 30px;
    background-color: #eeeeee;
  }
  
  ul>li {
    width: 77px;
    font-size: 16px;
    font-weight: 600;
    text-align: center;
    list-style: none;
    float: left;
  }
  
  input {
    width: 190px;
    height: 27px;
    border: 1px solid rgb(223, 223, 219);
    margin-top: 7px;
  }
  
  #box_1 {
    display: flex;
    height: 100%;
    background-color: #eeeeee;
    flex-direction: column;
  }
  
  .ding_header {
    height: 218px;
    z-index: 3;
  }
  
  .ss {
    height: 48px;
    display: flex;
    color: white;
  }
  
  .zi_tou {
    line-height: 80px;
    font-family: "Microsoft YaHei";
    font-size: 20px;
    text-align: center;
  }
  
  .ss>div {
    flex: 1;
  }
  
  .fan {
    float: right;
  }
  
  .ff {
    float: left;
    width: 40px;
    margin-top: 24px;
    transform: rotate(180deg);
  }
  
  .tc {
    width: 100px;
    height: 40px;
    position: relative;
    top: 10%;
    border-radius: 33px;
    float: right;
  }
  
  .ding_body {
    width: 100vw;
    height: 448px;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 7px;
  }
  
  .jing_er {
    width: 94%;
    height: 132px;
    font-size: 18px;
    border-radius: 10px;
    background-color: white;
  }
  
  .tong_ji {
    width: 82%;
    height: 378px;
    margin-top: 13px;
    border-radius: 10px;
    display: flex;
    background-color: white;
    padding: 22px;
    flex-direction: column;
    align-items: center;
  }
  
  .left {
    background-color: blue;
    width: 60px;
    height: 30px;
  }
  
  .right {
    background-color: rgb(255, 0, 68);
    width: 60px;
    height: 30px;
  }
  
  .jing_x {
    width: 100%;
    height: 80px;
    margin-top: 10px;
    z-index: 40;
    display: flex;
    align-items: center;
    text-align: center;
    position: relative;
    left: 4%;
  }
  
  .jing_zz {
    display: flex;
    height: 70px;
    margin-top: -10px;
    text-align: center;
    margin-right: 10px;
    align-items: center;
    font-size: 16px;
    justify-content: center;
  }
  
  .jing_x>div {
    flex: 1;
  }
  
  .ying_fu {
    height: 30px;
    font-size: 18px;
    border-right: 2px solid rgb(222, 227, 227);
    margin-right: 20px;
  }
  
  .cell {
    text-align: center;
  }
  
  .jin_zi {
    margin-top: 5px;
    font-size: 20px;
  }
  
  .tong_z {
    width: 104%;
    margin-bottom: 5px;
    height: 31px;
  }
  
  .tong_x1 {
    width: 103%;
    height: 320px;
    display: flex;
    flex-direction: column;
    /* overflow: scroll; */
  }
  
  p {
    font-weight: 600;
    margin-top: -12px;
  }
  
 
  </style>
  