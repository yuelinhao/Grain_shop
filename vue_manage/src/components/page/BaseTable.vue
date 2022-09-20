<template>
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item> <i class="el-icon-lx-cascades"></i>商品管理</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-button type="primary" icon="el-icon-delete" class="handle-del mr10" @click="delAllSelection">批量删除 </el-button>
                <el-input @input="searchEvent" @clear="clear_fn" clearable v-model="query.name" placeholder="商品名" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="el-icon-search" @click="handleSearch">搜索</el-button>
            </div>
            <el-table
                :data="tableData.slice((query.pageIndex-1)*query.pageSize,query.pageIndex*query.pageSize)"
                border
                class="table"
                ref="multipleTable"
                header-cell-class-name="table-header"
                @selection-change="handleSelectionChange"
                v-if="isReloadData"
            >
                <el-table-column type="selection" width="55" align="center"></el-table-column>
                <el-table-column prop="goods_id" label="ID" width="55" align="center"></el-table-column>
                <el-table-column prop="g_name" label="商品名" align="center"></el-table-column>
                <el-table-column prop="g_price" label="价格" align="center">
                    <template slot-scope="scope">￥{{ scope.row.g_price }}</template>
                </el-table-column>
                <el-table-column prop="g_bianhao" label="编号" align="center"> </el-table-column>
                <el-table-column prop="g_num" label="库存" align="center"> </el-table-column>
                <el-table-column prop="g_sell" label="已售" align="center"> </el-table-column>

                <el-table-column label="商品图片" align="center">
                    <template slot-scope="scope">
                        <!-- <el-image class="table-td-thumb" src="./imgs/1.PNG" :preview-src-list="[scope.row.thumb]"> </el-image> -->
                        <el-image
                            class="table-td-thumb"
                            :src="`http://localhost:3000/img/${[scope.row.g_img]}.jpg`"
                            :preview-src-list="[scope.row.g_img]"
                        >
                        </el-image>
                    </template>
                </el-table-column>
                <el-table-column prop="g_size" label="重量" align="center"> </el-table-column>
                <el-table-column prop="g_type" label="类别" align="center"></el-table-column>
                <el-table-column label="操作" width="180" align="center">
                    <template slot-scope="scope">
                        <el-button type="text" icon="el-icon-edit" @click="handleEdit(scope.$index, scope.row)">编辑 </el-button>
                        <el-button type="text" icon="el-icon-delete" class="red" @click="handleDelete(scope.$index, scope.row)"
                            >删除</el-button
                        >
                    </template>
                </el-table-column>
            </el-table>
            <div>
                <!-- 返回上一页 -->
                <el-button class="handle-del mr10" type="primary" @click="goBack" icon="el-icon-lx-add">添加信息</el-button>
            </div>
            <!-- 分页 -->
            <!-- 
                <el-pagination
                    background
                    layout="total, prev, pager, next"
                   
                    
                    :total="pageTotal"
                    
                ></el-pagination>
             -->
            <div class="pagination">
                <el-pagination 
                background 
                layout="total,prev,pager,next" 
                :total="pageTotal"
                :page-size="query.pageSize"
                :current-page="query.pageIndex"
                @current-change="handlePageChange"> 
                </el-pagination>
            </div>            
        </div>
        <!-- 编辑弹出框 -->
        <el-dialog title="编辑" :visible.sync="editVisible" width="30%">
            <el-form ref="form" :model="form" label-width="70px">
                <el-form-item label="价格">
                    <el-input v-model="form.money"></el-input>
                </el-form-item>
                <el-form-item label="库存">
                    <el-input v-model="form.stock"></el-input>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible = false">取 消</el-button>
                <el-button type="primary" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import axios from 'axios';
// import { fetchData } from '../../api/index';
export default {
    name: 'basetable',
    data() {
        return {
        //     currentPage: '1', //当前页 刷新后默认显示第一页
        // pageSize: '6', //每一页显示的数据量 此处每页显示6条数据

            isReloadData: true,
            query: {
                address: '',
                name: '',
                num: '',
                stock: '',
                sold: '',
                weight: '',
                kind: '',
                pageIndex: 1,
                pageSize: 6
            },
            tableData: [],
            tableData2: [],
            multipleSelection: [],
            delList: [],
            editVisible: false,
            form: {},
            idx: -1,
            id: -1,
            bianhao: '',
            hp: ''
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
            return item.g_name.indexOf(this.query.name) != -1
          })
          
        },
        clear_fn() {
          this.getData()
        },
        reloadPart(){
          this.isReloadData = false
          this.$nextTick(()=>{
              this.isReloadData = true
          })
        },

        // 获取 easy-mock 的模拟数据
        getData() {
            // fetchData(this.query).then((res) => {
            //     console.log(res);
            //     this.tableData = res.list;
            //     console.log(this.tableData);
            //     this.pageTotal = res.pageTotal || 50;
            // });
            axios({
                method: 'GET',
                url: 'http://localhost:3000/all_goods'
            }).then((val) => {
                console.log(val);
                this.tableData = val.data.value;
                this.tableData2 = val.data.value;
            });
        },
        // 触发搜索按钮
        handleSearch() {
            axios({
                method: 'POST',
                url: 'http://localhost:3000/s_goods_name',
                data: {
                    g_name: this.query.name
                }
            }).then((val) => {
                console.log(val);
                this.tableData = val.data.value;
            });
        },
        // 删除操作
        handleDelete(index, row) {
            // 二次确认删除
            this.$confirm('确定要删除吗？', '提示', {
                type: 'warning'
            })
                .then(() => {
                    let arr = [row.g_bianhao];
                    axios({
                        method: 'POST',
                        url: 'http://localhost:3000/re_goods',
                        data: {
                            g_bianhao_arr: JSON.stringify(arr)
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
                arr.push(this.multipleSelection[i].g_bianhao);
            }
            axios({
                method: 'POST',
                url: 'http://localhost:3000/re_goods',
                data: {
                    g_bianhao_arr: JSON.stringify(arr)
                }
            }).then((val) => {
                console.log(val);
                this.getData();
                this.$message.error(`删除成功`);
            });

            this.multipleSelection = [];
        },
        // 编辑操作
        handleEdit(index, row) {
            this.idx = index;
            this.form = row;
            this.editVisible = true;
            // console.log(row);
            this.bianhao = row.g_bianhao;
            this.hp = index;
        },
        // 保存编辑
        saveEdit() {
            this.editVisible = false;

            this.$set(this.tableData, this.idx, this.form);

            axios({
                method: 'POST',
                url: 'http://localhost:3000/m_goods',
                data: {
                    g_price: this.form.money,
                    g_num: this.form.stock,
                    g_bianhao: this.bianhao
                }
            }).then((val) => {
                console.log(val);
                this.tableData[this.hp].g_num = this.form.stock;
                this.tableData[this.hp].g_price = this.form.money;
                this.$message.success(`修改成功`);
            });
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
        },
    
   
    }
}
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
