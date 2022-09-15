<template>
    <div>
        <div class="tong_x">
            <el-table :data="tableData1" stripe style="width: 100vw;">
                <el-table-column prop="o_time" label="时间" width="130">
                    <template slot-scope="scope">
                        {{format_time(scope.row.o_time)}}
                    </template>
                </el-table-column>
                <el-table-column prop="g_sum" label="单据数量" width="76">
                </el-table-column>
                <el-table-column prop="o_price" label="总金额" width="62">
                </el-table-column>
                <el-table-column prop="o_status" label="货物状态" width="76">
                    <template slot-scope="scope">
                        {{status_fn(scope.row.o_status)}}
                    </template>
                </el-table-column>
            </el-table>
        </div>
    </div>
</template>

<script>
export default {
    created() {
        this.$http.post('http://192.168.0.135:3000/get_all_bill', { user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc }).then((res) => {
            this.tableData1 = res.data.value
        })
    },
    data() {
        return {
            tableData1: []

        }
    },
    methods: {
        format_time(time) {
            const date = new Date(time * 1)
            let m = date.getMonth() < 10 ? '0' + date.getMonth() : date.getMonth()
            let d = date.getDay() < 10 ? '0' + date.getDay() : date.getDay()
            let h = date.getHours() < 10 ? '0' + date.getHours() : date.getHours()
            let f = date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()
            let s = date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds()
            let f_time =  m + '-' + d + ' ' + h + ':' + f + ':' + s
            return f_time
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
        }
    }

}
</script>

<style scoped>
.tong_x {
    width: 99%;
    height: 320px;
    overflow: scroll;
    margin-top: 3px;
}

.cell {
    text-align: center;
}

.el-table .el-table__cell {
    padding: 8px 0;
    min-width: 0;
    width: 20px;
    box-sizing: border-box;
    text-overflow: ellipsis;
    vertical-align: middle;
    position: relative;
    text-align: left;
}
</style>
