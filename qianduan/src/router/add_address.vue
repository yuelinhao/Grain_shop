<template>
    <div class="add_addr">
        <div class="addr_page">
            <div class="addr_top">
                <i class="el-icon-arrow-left" @click="back_detail"></i>
                <span>添加收货地址</span>
            </div>
            <div class="addr_center">
                <div class="addr_name add_pub">
                    <div class="addr__left"><span>收货人</span></div>
                    <div class="aaa addr__right"><input v-model="user_name" placeholder="名字" type="text"></div>
                </div>
                <div class="addr_phone add_pub">
                    <div class="addr__left"><span>手机号码</span></div>
                    <div class="addr__right"><input v-model="user_phone" placeholder="+86" type="text"></div>
                </div>
                <div class="addr_address add_pub">
                    <div class="addr__left"><span>所在地区</span></div>
                    <div class="addr__right"><input v-model="user_sheng" placeholder="省、市、县/区" type="text"></div>
                </div>
                <div class="addr_detail_addr add_pub2">
                    <div class="addr__left2"><span>详细地址</span></div>
                    <div class="addr__right2"><textarea v-model="user_addres" placeholder="乡镇/街道/小区" name="" id="" cols="30" rows="10"></textarea></div>
                </div>
            </div>
            <div @click="preser()" class="addr_bottom">
                <div class="baocun_span"><span>保存</span></div>
                <div class="baocun_succ"><div class="succ_cc"><span>保存成功~</span></div></div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name:"add_addr",
    data() {
        return{
            user_name:'',
            user_phone:'',
            user_sheng:'',
            user_addres:''
        }
    },
    methods: {
        back_detail() {
            this.$router.go(-1)
        },
        preser() {
            if(this.user_name != '' && this.user_phone != '' && this.user_sheng != '' && this.user_addres != '') {
                var baocun_succ = document.querySelector(".baocun_succ")
                var arr = []
                baocun_succ.style.display = "block"
                setTimeout(() => {
                    baocun_succ.style.display = "none"
                    this.$router.go(-1)
                }, 1000),
                arr.push(this.user_name, this.user_phone, this.user_sheng, this.user_addres)
                let time = parseInt(new Date().getTime() / 1000) + '';
                this.$http.post('http://192.168.0.135:3000/add_address',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc,address_id:time, user_address:this.user_sheng, user_name:this.user_name, user_phone:this.user_phone, more_address:this.user_addres}).then((res)=> {
                    console.log(res)
                })
            } else {
                this.$message.warning('请将信息补充完整')
            }
        }
    }
}
</script>

<style>
.addr_page {
    width: 100vw;
    height: 100vh;
    background-color: white;
}

.addr_page .el-icon-arrow-left {
    font-size: 23px;
    color: white;
    margin: 0 2vw;
}

.addr_top{
    width: 100%;
    height: 9%;
    display: flex;
    align-items: center;
    background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
}

.addr_top>span{
    color: #ffffff;
    font-size: 16px;
    font-weight: 550;
}

.addr_center{
    width: 100%;
    height: 45%;
    display: flex;
    flex-direction: column;
    align-items: center;
}
.add_pub{
    width: 90%;
    height: 20%;
    display: flex;
    align-items: center;
}

.addr__left{
    width: 25%;
    height: 55%;
    display: flex;
    align-items: center;
}

.addr__left>span{
    font-family: "微软雅黑";
    font-size: 15px;
    font-weight: 550;
    color: #333333;
}

.addr__right{
    width: 75%;
    height: 55%;
    display: flex;
    align-items: center;
}

.addr__right>input{
    width: 100%;
    height: 100%;
    border-radius: 10px;
    font-family: "微软雅黑";
    padding-left: 8px;
    font-size: 14px;
    color: #333333;
    border-color: transparent;
    outline: none;
    caret-color: #0551bc;
    background-color: #f4f4f4;
}

.add_pub2{
    width: 90%;
    height: 40%;
    display: flex;
    align-items: center;
    /* background-color: #2964a0; */
}

.addr__left2{
    width: 25%;
    height: 72%;
}

.addr__left2>span{
    font-family: "微软雅黑";
    font-size: 15px;
    font-weight: 550;
    color: #333333;
}

.addr__right2{
    width: 75%;
    height: 70%;
    display: flex;
    align-items: center;
    /* background-color: #1b375c; */
}

.addr__right2>textarea{
    width: 100%;
    height: 100%;
    border-radius: 10px;
    font-family: "微软雅黑";
    font-size: 14px;
    color: #333333;
    border-color: transparent;
    outline: none;
    caret-color: #0551bc;
    background-color: #f4f4f4;
    padding: 10px;
}

.addr_bottom{
    width: 100%;
    height: 6%;
    margin-top: 30px;
    position: relative;
}

.baocun_span{
    width: 100%;
    height: 100%;
    margin-top: 30px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.baocun_span>span{
    width: 80%;
    height: 100%;
    border-radius: 50px;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
    font-family: "微软雅黑";
    font-size: 16px;
    color: #ffffff;
    letter-spacing: 2px;
}

.baocun_succ{
    /* width: 100%; */
    height: 100%;
    display: none;
    position: absolute;
    top: -160px;
    width: 100%;
}

.succ_cc{
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.succ_cc>span{
    width: 60%;
    height: 160%;
    border-radius: 10px;
    background-color: aquamarine;
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>