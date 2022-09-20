<template>
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item> <i class="el-icon-lx-cascades"></i> 人员管理 </el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-button type="primary" icon="el-icon-delete" class="handle-del mr10" @click="delAllSelection">批量删除 </el-button>
                <el-input @input="searchEvent" @clear="clear_fn" clearable v-model="query.zhanghao" placeholder="请输入姓名" class="handle-input mr10"></el-input>
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
                <el-table-column prop="user_acc" label="账号" width="55" align="center"></el-table-column>
                <el-table-column prop="user_name" label="姓名" align="center"></el-table-column>
                <el-table-column label="头像" align="center">
                    <template slot-scope="scope">
                        <!-- <el-image class="table-td-thumb" src="./imgs/1.PNG" :preview-src-list="[scope.row.thumb]"> </el-image> -->
                        <el-image class="table-td-thumb" :src="`http://localhost:3000/img/${[scope.row.user_img]}.jpg`" :preview-src-list="[scope.row.user_img]">
                        </el-image>
                    </template>
                </el-table-column>
                <el-table-column prop="user_sex" label="性别" align="center"></el-table-column>
                <el-table-column prop="user_phone" label="电话" align="center"></el-table-column>
                <el-table-column prop="user_money" label="金额" align="center">
                    <template slot-scope="scope">￥{{ scope.row.user_money }}</template>
                </el-table-column>
                <el-table-column prop="user_integral" label="积分" align="center"></el-table-column>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <!-- <div>
                 返回上一页 
                <el-button class="handle-del mr10" type="primary" @click="goBack" icon="el-icon-delete">添加信息</el-button>
            </div> -->
            <!-- 分页 -->
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
                pageIndex: 1,
                pageSize: 6,
                zhanghao:''
            },
            tableData: [],
            tableData2: [],
            multipleSelection: [],
            delList: [],
            editVisible: false,
            form: {},
            idx: -1,
            id: -1,
            name: '',  
            gender: '',
            tel: '',
            jin:'',
            jifen:''
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
            return item.user_name.indexOf(this.query.zhanghao) != -1
          })
          
        },
        clear_fn() {
          this.getData()
        },
        getData() {
         
         axios({
            method:'GET',
            url:'http://localhost:3000/getAll_user_info',
         }).then((val) =>{
          console.log(val);
            this.tableData = val.data.value
            this.tableData2 = val.data.value
         })
            
        },
        // 触发搜索按钮
        handleSearch() {
            axios({
                method:'POST',
                url:'http://localhost:3000/select_user',
                data:{
                    user_name:this.query.zhanghao
                }
            }).then((val)=>{
                this.tableData = val.data.value
                
            })
        },
        // 删除操作
        handleDelete(index, row) {
            // 二次确认删除
            this.$confirm('确定要删除吗？', '提示', {
                type: 'warning'
            })
                .then(() => {
                    let arr = [row.user_acc];
                    axios({
                        method: 'POST',
                        url: 'http://localhost:3000/user_delete',
                        data: {
                            user_acc_arr: JSON.stringify(arr)
                        }
                    }).then((val) => {
                        console.log(val);
                    });
                    this.$message.success('删除成功');
                    this.tableData.splice(index, 1);
                })
                .catch(() => {});
        },
        // 多选操作
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        delAllSelection() {
            let arr = []
            const length = this.multipleSelection.length;
            for (let i = 0; i < length; i++) {
                arr.push(this.multipleSelection[i].user_acc)
            }
            axios({
                method:'POST',
                url:'http://localhost:3000/user_delete',
                data:{
                     user_acc_arr: JSON.stringify(arr)
                }
            }).then((val)=>{
                console.log(val);
                this.getData()
                this.$message.error(`删除成功`);
            })
            this.multipleSelection = [];
        },
        // 编辑操作
        handleEdit(index, row) {
            this.idx = index;
            this.form = row;
            this.editVisible = true;
        },
        // 保存编辑
        saveEdit() {
            this.editVisible = false;
            this.$message.success(`修改第 ${this.idx + 1} 行成功`);
            this.$set(this.tableData, this.idx, this.form);
        },
        // 分页导航
        handlePageChange(val) {
            // this.$set(this.query, 'pageIndex', val);
            // this.getData();
            this.query.pageIndex = val
        },
        // 返回上一页
        goBack() {
            this.$router.push({ path: '/editor' });
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
