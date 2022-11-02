<template>
  <div class="box_1">
    <div class="tong_x1">
      <el-table :data="tableData2" stripe style="width: 100vw">
        <el-table-column prop="g_bianhao" label="编号" width="88">
        </el-table-column>
        <el-table-column prop="g_name" label="名称" width="88">
        </el-table-column>
        <el-table-column prop="g_number" label="数量" width="82">
        </el-table-column>
        <el-table-column prop="g_price" label="单价" width="80">
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>
export default {
  created() {
        this.$http.post('http://localhost:3000/get_all_bill_goods', { user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc }).then((res) => {
            this.tableData2 = res.data.value
        })
    },
  data() {
    return {
      tableData2: [
        {
          status: "代收款",
          xinxi: "34623",
          num: "2",
          money: "133",
        }
      ],
    };
  },
};
</script>

<style scoped>
* {
  padding: 0;
  margin: 0;
}

.cell {
  text-align: center;
}

.box_1 {
  display: flex;
  margin-top: 6px;
  justify-content: center;
}

.tong_x1 {
  overflow: scroll;
  height: 465px;
  width: 95%;
}
</style>