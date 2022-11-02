// App子组件
<template>
  <div class="fou">
    <div class="top">
      <!-- <discover /> -->
      <div class="dis">
        <!-- <i style="color:white" class="el-icon-arrow-left" @click="fanhui_fn"></i> -->
        <div class="dis_top">发现</div>
        <div class="dis_bottom">
          <!-- <Search/> -->
          <div @click="d_click">
            <i class="el-icon-search"></i> 请输入要搜索商品
          </div>
        </div>
      </div>
    </div>
    <div class="bottom">
      <div class="left">
        <sidebar />
      </div>
      <div class="right">
        <sample />
        <!-- <router-view></router-view> -->
      </div>
    </div>
    <div v-show="isTrue" class="search">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import sidebar from "./sidebar.vue";
// import discover from "./discover.vue"
import sample from "./sample.vue";
export default {
  data() {
    return {};
  },
  components: { sidebar, sample },
  computed: {
    isTrue() {
      return this.$route.name == "found" ? 0 : 1;
    },
  },
  methods: {
        d_click() {
        this.$router.replace({name:'search'})
        },
        // fanhui_fn() {
        //     this.$router.push({path:`${this.$route.matched[1].path}`})
        // }
    },
};
</script>

<style scoped>
.fou {
  width: 100%;
  height: 93.85vh;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}
.fou > .top {
  flex: 1;
  
}
.fou > .bottom {
  flex: 6;
  overflow: hidden;
  display: flex;
}
.fou > .bottom > .left {
  overflow: hidden;
  flex: 1;
  background-color: #f6f6f6;
}
.fou > .bottom > .right {
  overflow: hidden;
  flex: 3.3;
}
/* 搜索 */
.search {
  position: absolute;
  width: 100vw;
  height: 100vh;
  z-index: 3;
}

.dis {
    width: 100%;
    height: 100%;
    background-color: #1e4c7b;
    position: relative;
}
.dis > .dis_top {
    width: 10vw;
    position: absolute;
    left: 0;right: 0;
    margin: auto;
    top: 2vw;
    color: white;
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