<template>
    <div class="ke_cun">
      <template>
        <el-table :data="tableData3" style="width: 100%" height="500">
          <el-table-column fixed prop="o_id" label="编号" width="80">
          </el-table-column>
          <el-table-column prop="o_time" label="时间" width="130">
            <template slot-scope="scope">
              {{time_fn(scope.row.o_time)}}
            </template>
          </el-table-column>
          <el-table-column prop="o_price" label="单价" width="72">
          </el-table-column>
          <el-table-column prop="o_status" label="状态" width="72">
            <template slot-scope="scope">
              {{status_fn(scope.row.o_status)}}
            </template>
          </el-table-column>
        </el-table>
      </template>
    </div>
  </template>
  
  <script>
  export default {
    created() {
      this.$http.post('http://localhost:3000/get_all_order',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc}).then((res)=> {
        this.tableData3 = res.data.value
      })
    },
    data() {
      return {
        tableData3: [{
          xuhao: '1',
          name: '金龙鱼大米',
          price: '9999',
          num: '普陀区',
        }]
      }
    },
    methods:{
      time_fn(time){
        const date = new Date(time * 1)
        let y = date.getMonth() < 10 ? '0' + date.getMonth() : date.getMonth()
        let r = date.getDay() < 10 ? '0' + date.getDay() : date.getDay()
        let h = date.getHours() < 10 ? '0' + date.getHours() : date.getHours()
        let m = date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()
        let s = date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds()
        let f_time = y + '-' + r + ' ' + h + ':' + m + ':' + s 
        return f_time
      },
      status_fn(status){
        var status_1 = ''
        if (status == 0){
          status_1 = '待发货'
        }else if(status == 1){
          status_1 = '待付款'
        }else if(status == 2){
          status_1 = '已发货'
        }else if(status == 3){
          status_1 = '已收货'
        }
        return status_1
      }
    }
  }
  </script>
  
  <style>
  .ke_cun {
    margin-top: 6px;
    height: 500px;
  }
  
  .cell {
    text-align: center;
  }
  </style>