<template>
    <div class="ke_cun">
      <template>
        <el-table :data="tableData" style="width: 100%" height="500">
          <el-table-column fixed prop="g_bianhao" label="编号" width="110">
          </el-table-column>
          <el-table-column prop="g_name" label="商品名称" width="120">
          </el-table-column>
          <el-table-column prop="g_price" label="单价" width="60">
          </el-table-column>
          <el-table-column prop="g_number" label="库存" width="60">
          </el-table-column>
        </el-table>
      </template>
    </div>
  </template>
  
  <script>
  export default {
    created() {
      this.$http.post('http://192.168.0.135:3000/get_all_order_goods',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc}).then((res)=> {
        this.tableData = res.data.value
      })
    },
    data() {
      return {
        tableData: [{
          xuhao: '1',
          name: '金龙鱼大米',
          price: '9999',
          num: '普陀区',
        }]
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