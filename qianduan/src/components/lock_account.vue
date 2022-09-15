<template>
    <div class="lock_page">
        <div class="page">
            <div class="top">
                <i class="el-icon-arrow-left" @click="fan_safe"></i>
                <span class="span2"><strong>锁定账号</strong></span>
            </div>
            <div class="center">
                <div class="lock_img">
                    <img src="../assets/锁定@2x.png" alt="">
                </div>
                <span>您正在锁定账号</span>
            </div>
            <div class="lock_p">
                <div class="p_up">
                    <span class="s">1.为什么需要锁定账号？</span>
                    <span class="s_p">为了账户安全防止多用户登录造成资金被盗隐患</span>
                </div>
                <div class="p_up">
                    <span class="s">2.锁定后会怎么样？</span>
                    <span class="s_p">无法在其他设备进行登录，且不能远程退出</span>
                </div>
            </div>
            <div class="bottom">
                <div @click="lock_ture" class="yes_lock">确认锁定</div>
                <div class="ture"><span>账号已锁定</span></div>
            </div>
        </div>
    </div>
</template>

<script>
    export default{
        name:"lock_page",
        methods: {
            fan_safe() {
                this.$router.go(-1)
            },
            lock_ture() {
                var ture = document.querySelector(".ture")
                ture.style.display = "block"
                setTimeout(function() {
                    ture.style.display = "none"
                }, 1000)
            }
        }
    }
</script>

<style scoped>
.page {
    width: 100vw;
    height: 100vh;
    background-color: #f4f4f4;
}

.top{
    width: 100%;
    height: 8%;
    display: flex;
    align-items: center;
    background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
}

.page .el-icon-arrow-left {
    font-size: 23px;
    color: white;
    margin: 0 2vw;
}

.span2 {
    font-size: 20px;
    color: #ffffff;
}

.center{
    width: 100%;
    height: 40%;
    background-color: #ffffff;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.lock_img{
    width: 100px;
    height: 100px;
    border: 1px solid #1296db;
    border-radius: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
}
.center>img{
    width: 50%;
    height: 50%;
    background-position: center;
    background-size: cover;
}

.center>span{
    font-size: 16px;
    font-weight: 550;
    letter-spacing: 1px;
}

.lock_p{
    width: 100%;
    height: 38%;
    /* background-color: #1296db; */
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
    margin-top: 20px;
}

.p_up{
    width: 90%;
    height: 30%;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.s{
    font-size: 14px;
    margin-bottom: 10px;
}

.s_p{
    font-size: 12px;
    color: #a1a3a5;
}

.bottom{
    width: 100%;
    height: 10%;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
}

.yes_lock{
    width: 30%;
    height: 60%;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
    border-radius: 5px;
    color: white;
}

.ture{
    position: absolute;
    top: -295px;
    background-color: aquamarine;
    opacity: 0.6;
    width: 60%;
    height: 60%;
    display: none;
}

.ture>span{
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>