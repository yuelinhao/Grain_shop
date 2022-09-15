<template>
    <div class="det_add">
        <el-container>
            <el-header style="
            display: flex;
            justify-items: center;
            align-items: center;
            background: linear-gradient(to right, #39669d 0%, #1b375c 100%);
          ">
                <!-- <i class="el-icon-arrow-left" @click="tiao_fn"></i> -->
                <span style="color:white; font-weight:550;">我的收货地址</span>
                <span class="guan_li manage" @click="change_fn" style="color:white; ">管理</span>
                <span class="qu_xiao manage" @click="cancle_fn" style="color:white; ">取消</span>
            </el-header>
            <div class="el">
                <div class="nei">
                    <div v-for="(item, index) in msg" :key="index" class="da_main">
                        <div @click="back_my_msg(item)" class="main">
                            <div class="round">
                                <div class="circle">
                                    <img src="../assets/homefill.png" width="31px" height="30px" />
                                </div>
                            </div>
                            <div class="content">
                                <div>
                                    <span class="a1">{{item.user_name2}}</span>
                                    <span class="tel">{{item.user_phone3}}</span>
                                </div>
                                <span class="addre">{{item.user_ress}}</span>
                                <span class="addre_dal">{{item.more_address}}</span>
                            </div>
                            <div class="edit">
                                <div class="bianji">
                                    <img src="../assets/edit.png" width="25px" height="25px" />
                                </div>
                            </div>
                        </div>
                        <div class="delete_ele" v-if="isDelete">
                            <div @click="shan_chu_fn(index)" class="delete_span">删除</div>
                        </div>
                    </div>
                </div>
            </div>
            <el-footer>
                <div @click="add_addr" class="add">
                    <i class="el-icon-plus"></i>
                    添加收货地址
                </div>
            </el-footer>
        </el-container>
    </div>
</template>
  
<script>
import Vue from 'vue'
export default {
    created() {
        this.$http.post('http://192.168.0.135:3000/get_address', { user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc }).then((res) => {
            this.msg = res.data.value
        })
    },
    data() {
        return {
            msg:[],
            isDelete: false,
            items: null
        };
    },
    beforeRouteEnter (to, from, next) {
      if (from.name == 'jiesuan') {
        Vue.prototype.$tiao = 'jiesuan'
      }
      next()
    },
    beforeRouteLeave (to, from, next) {
      if (Vue.prototype.$tiao == 'jiesuan') {
        Vue.prototype.$tiao = null
        // next('/jiesuan')
        this.$router.push({name: 'jiesuan', params: {items: this.items}})
      }
      next()
    },
    methods: {
        add_addr() {
            this.$router.push({ name: 'add_address' })
        },
        change_fn() {
            var guan_li = document.querySelector(".guan_li")
            var qu_xiao = document.querySelector(".qu_xiao")
            guan_li.style.display="none"
            qu_xiao.style.display="block"
            this.isDelete = true
        },
        cancle_fn() {
            var guan_li = document.querySelector(".guan_li")
            var qu_xiao = document.querySelector(".qu_xiao")
            guan_li.style.display="block"
            qu_xiao.style.display="none"
            this.isDelete = false
        },
        shan_chu_fn(index) {
            let quer_id = this.msg[index].address_id
            this.$http.post('http://192.168.0.135:3000/delete_address', { user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc, address_id:quer_id }).then(() => {
                this.$http.post('http://192.168.0.135:3000/get_address', { user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc }).then((res) => {
                    // console.log(res.data.value);
                    this.msg = res.data.value
                })
            })
        },
        tiao_fn() {
            this.$router.push({name:'my_msg'})
        },
        back_my_msg(item) {
            this.items = item
            this.$router.push({name:'my_msg',params:{item}})
            this.$http.post('http://192.168.0.135:3000/get_user_info2', 
            { user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc, user_name:item.user_name2, }).then((res) => {
                // console.log(res.data.value);
                // this.msg = res.data.value
            })
            
        }
    },
    computed: {
        isTrue() {
            return this.$route.name ? 1 : 0
        }
    },
    components: {
        // HelloWorld
    }
};
</script>
  
<style scoped>
body {
    padding: 0;
    margin: 0;
    overflow: hidden;
}

.det_add {
    width: 100vw;
    height: 100vh;
    background-color: #fff;
    overflow: hidden;
}

.quan {
    line-height: 1px;
    text-align: center;
    color: rgb(240, 91, 27);
}

.addre {
    font-size: 15px;
}

.el-icon-arrow-left {
    position: relative;
    left: 0px;
    color: white;
    font-size: 22px;
}

.manage {
    color: #2e527f;
    position: absolute;
    right: 26px;
}

.qu_xiao{
    display: none;
}

.el-header {
    height: 10vh;
    padding: 15px;
}

.el {
    width: 100%;
    height: 80vh;
    padding: 0;
    background-color: rgb(246, 246, 246);
    display: flex;
    flex-direction: column;
    align-items: center;
    overflow-y: scroll;
    overflow-x: scroll;
}

.nei{
    width: 90%;
}

.da_main{
    width: 100%;
    margin-top: 10px;
}

.main {
    width: 100%;
    height: 100%;
    background-color: white;
    display: flex;
    align-items: center;
}

.delete_ele{
    width: 100%;
    height: 25px;
    background-color: white;
    /* display: none; */
}

.delete_span{
    width: 90%;
    height: 100%;
    margin: 0 auto;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    border-top: 1px solid #b8b7b7;
    font-family: "微软雅黑";
    font-size: 15px;
    color: #333333;
}

.round {
    width: 15%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.circle {
    width: 33px;
    height: 33px;
    border-radius: 100%;
    background-color: #2e527f;
}

.content {
    width: 70%;
    height: 120px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
}

.a1{
    font-family: "微软雅黑";
    font-size: 20px;
    color: #333333;
    font-weight: 550;
    letter-spacing: 1px;
    margin-right: 5px;
}

.tel {
    font-family: "微软雅黑";
    font-size: 14px;
    color: #a1a0a0;
}

.edit {
    width: 15%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.addre{
    font-family: "微软雅黑";
    font-size: 14px;
    color: #333333;
}

.addre_dal{
    font-family: "微软雅黑";
    font-size: 14px;
    color: #333333;
    clear: both;
    width: 100%;
    word-break: break-word;
}

.bianji {
    width: 30px;
    height: 30px;
    border-radius: 100%;
}

.bianji>img{
    width: 100%;
    height: 100%;
}

.moren {
    display: inline-block;
    border: 2px solid #2e527f;
    color: #2e527f;
    font-weight: 400;
    text-align: center;
    margin: 2px;
    border-radius: 6px;
    font-size: 12px;
}

.safe_father {
    width: 100vw;
    height: 100vh;
    position: absolute;
    top: 0;
    overflow: hidden;
}

.el-footer {
    height: 10vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.add {
    width: 95%;
    height: 45%;
    text-align: center;
    color: white;
    background: linear-gradient(to right, #39669d 0%, #1b375c 100%);
    border-radius: 20px;
    padding: 9px;
}
</style>
  