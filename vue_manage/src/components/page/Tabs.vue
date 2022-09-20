<template >
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item> <i class="el-icon-lx-cascades"></i> 订单管理 </el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-button type="primary" icon="el-icon-delete" class="handle-del mr10" @click="delAllSelection">批量删除 </el-button>
                <el-input @input="searchEvent" @clear="clear_fn" clearable v-model="query.id" placeholder="订单编号" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
            </div>
            <el-table
                :data="tableData.slice((query.pageIndex-1)*query.pageSize,query.pageIndex*query.pageSize)"
                border
                class="table"
                ref="multipleTable"
                header-cell-class-name="table-header"
                @selection-change="handleSelectionChange"
            >
                <el-table-column type="selection" width="55" align="center"></el-table-column>
                <el-table-column prop="o_id" label="订单编号" width="140" align="center"></el-table-column>
                <el-table-column prop="o_price" label="订单价格" align="center">
                    <template slot-scope="scope">￥{{ scope.row.o_price }}</template>
                </el-table-column>
                <el-table-column prop="o_status" label="是否付款" align="center">
                  <template slot-scope="scope">{{ (scope.row.o_status == 1 || scope.row.o_status == 2 || scope.row.o_status == 3) ? '是' : '否' }}</template>
                </el-table-column>
                <el-table-column prop="o_status" label="是否发货" align="center">
                  <template slot-scope="scope">{{ (scope.row.o_status == 2 || scope.row.o_status == 3) ? '是' : '否' }}</template>
                </el-table-column>
                <el-table-column prop="o_status" label="是否收货" align="center" ref="isReceive">
                  <template slot-scope="scope">{{ scope.row.o_status == 3 ? '是' : '否' }}</template>
                </el-table-column>

                <el-table-column prop="o_time" label="下单时间" align="center">
                  <template slot-scope="scope">{{format_time(scope.row.o_time)}}</template>
                </el-table-column>
                <el-table-column prop="u_name" label="客户名称" align="center"> </el-table-column>
                <el-table-column prop="u_phone" label="客户电话" align="center"> </el-table-column>
                <el-table-column prop="user_acc" label="客户地址" align="center"> </el-table-column>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        
                        <el-button type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)"
                            >删除</el-button
                        >

                        <el-button :disabled="scope.row.o_status != 1" type="text" icon=" el-icon-lx-location" @click="handleEdit(scope.$index, scope.row)"
                            >发货</el-button
                        >
                    </template>
                </el-table-column>
            </el-table>
            <div>
                <!-- 返回上一页 -->
                <!-- <el-button class="handle-del mr10" type="primary" @click="goBack" icon="el-icon-delete">添加信息</el-button> -->
            </div>
            <div class="pagination">
                <el-pagination
                    background
                    layout="total, prev, pager, next"
                    :current-page="query.pageIndex"
                    :page-size="query.pageSize"
                    :total="pageTotal"
                    @current-change="handlePageChange"
                ></el-pagination>
            </div>
        </div>

        
    </div>
</template>

<script>
import axios from 'axios'
// import { fetchData } from '../../api/index';
export default {
    name: 'basetable',
    data() {
        return {
            query: {
                address: '',
                name: '',
                pageIndex: 1,
                pageSize: 6,
                money: '',
                isPay: '',
                isReceive: '',
                isDelivery: '',
                time: '',
                tel: '',
                id: '',
                address: ''
            },
            tableData: [],
            tableData2: [],
            multipleSelection: [],
            delList: [],
            editVisible: false,
            form: {},
            idx: -1,
            fahuo: '1'
        };
    },
    created() {
        this.getData();
    },
    computed: {
      pageTotal() {
        return this.tableData.length
      }
    },
    methods: {
        searchEvent () {
          this.tableData = this.tableData2.filter((item) => {
            return item.o_id.indexOf(this.query.id) != -1
          })
          
        },
        format_time(timestamp) {
            var date = new Date(timestamp * 1)
            var Y = date.getFullYear() + '-'
            var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-'
            var D = date.getDate() < 10 ? '0' + date.getDate() : date.getDate()
            return Y + M + D
        },
        //     // 弹出框方法
        //     open() {

        //   },
        clear_fn() {
          this.getData()
        },

        getData() {
            axios({
                method: 'GET',
                url: 'http://localhost:3000/o_selectAll_b'
            }).then((val) => {
                console.log(val);
                this.tableData = val.data.value;
                this.tableData2 = val.data.value;
            });
        },
        // 触发搜索按钮
        handleSearch() {
            axios({
                method:'POST',
                url:'http://localhost:3000/o_select_id',
                data:{
                    o_id:this.query.id
                }
            }).then((val)=>{
                console.log(val);
                this.tableData = val.data.value
                
            })
        },
        // 多选操作
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        delAllSelection() {
            let arr = []
            const length = this.multipleSelection.length;
            for (let i = 0; i < length; i++) {
                arr.push(this.multipleSelection[i].o_id)
            }
            axios({
                method:'POST',
                url:'http://localhost:3000/o_delete',
                data:{
                     o_id_arr: JSON.stringify(arr)
                }
            }).then((val)=>{
                console.log(val);
                this.getData()
                this.$message.error(`删除成功`);
            })
            this.multipleSelection = [];
        },
        // 删除操作
        handleDelete(index, row) {
            // 二次确认删除
            this.$confirm('确定要删除吗？', '提示', {
                type: 'warning'
            })
                .then(() => {
                    let arr = [row.o_id];
                    axios({
                        method: 'POST',
                        url: 'http://localhost:3000/o_delete',
                        data: {
                            o_id_arr: JSON.stringify(arr)
                        }
                    }).then((val) => {
                        console.log(val);
                    });
                    this.$message.success('删除成功');
                    this.tableData.splice(index, 1);
                })
                .catch(() => {});
        },
        // 发货操作
        handleEdit(index, row) {
          this.$confirm('确定发货？', '确认信息', {
              distinguishCancelAndClose: true,
              confirmButtonText: '确定',
              cancelButtonText: '取消'
          })
              .then(() => {
                  axios({
                      method:'POST',
                      url:'http://localhost:3000/o_shipped',
                      data:{
                          o_id: row.o_id,
                          o_status: 2
                      }
                  }).then((val)=>{
                      console.log(val);
                      this.getData()
                      this.$message({
                          type: 'success',
                          message: '发货成功'
                      });
                  })
                  
              })
              .catch((action) => {
                  this.$message({
                      type: 'info',
                      message: action === 'cancel' ? '取消发货' : '已取消'
                  });
              });
            // axios({
            //     method: 'POST',
            //     url: '',
            //     data: {

            //     }
            // }).then((val) => {
            //     console.log(val);
            // })
        },
        
        // 分页导航
        handlePageChange(val) {
            // this.$set(this.query, 'pageIndex', val);
            // this.getData();
            this.query.pageIndex = val
        },
        // 返回上一页
        goBack() {
            this.$router.push({ path: '/form' });
        }
    }
};
</script>

<style scoped>
.handle-box {
    margin-bottom: 20px;
}

.handle-select {
    width: 120px;
}

.handle-input {
    width: 300px;
    display: inline-block;
}

.table {
    width: 100%;
    font-size: 14px;
}

.red {
    color: #ff0000;
}

.mr10 {
    margin-right: 10px;
}

.table-td-thumb {
    display: block;
    margin: auto;
    width: 40px;
    height: 40px;
}

.error-btn {
    margin-left: 100px;
}
</style>
