// 发现页头
<template>
  <div class="dis">
    <i class="el-icon-arrow-left" @click="fanhui_fn"></i>
    <div class="dis_top">发现</div>
    <div class="dis_bottom">
        <!-- <Search/> -->
        <div @click="d_click"><i class="el-icon-search"></i>
        请输入要搜索商品</div>
    </div>
  </div>
</template>

<script>
export default {
    name: "discover",
    methods: {
        d_click() {
        this.$router.replace({name:'search'})
        },
        fanhui_fn() {
            // this.$router.push({path:`${this.$route.matched[1].path}`})
            this.$router.go(-1)
        }
    },  
}
</script>

<style scoped>
.dis {
    width: 100%;
    height: 100%;
    position: relative;
}
.dis > .dis_top {
    width: 10vw;
    position: absolute;
    left: 0;right: 0;
    margin: auto;
    top: 2vw;
    font-weight: 700;
    font-size: 18px;
}
.dis > .dis_bottom {
    width: 95vw;
    position: absolute;
    left: 0;right: 0;
    margin: auto;
    top: 13vw;
}
.dis_bottom div {
    width: 90vw;
    height: 8vw;
    position: absolute;
    left: 0;right: 0;margin: auto;
    background-color: rgb(246, 246, 246);
    border: 0;
    border-radius: 4vw;
    line-height: 8vw;
    text-align: left;
    padding-left: 2vw;
    color: rgb(170, 170, 170);
    font-size: 14px;
}
.dis_bottom .el-icon-search {
    /* text-align: left !important; */
    padding-right: 24vw;
}
.dis .el-icon-arrow-left {
    font-size: 24px;
    line-height: 39px;
    margin-left: 2vw;
}
</style>