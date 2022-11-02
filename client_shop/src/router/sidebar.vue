// found子组件 左侧边栏
<template>
  <div class="fou_sid">
    <div v-for="(item,index) in sidebar" :key="index" @click="s_click(index,item)" :class="{Sidebar: current == index}">
        <div :class="{sidebar_inner: current == index}">{{item.name}}</div>
    </div>
  </div>
</template>

<script>
export default {
    name: "sidebar",
    data() {
        return {
            sidebar: [  
                {
                    name:"原粮"
                },
                {
                    name:"精致特一粉"
                },
                {
                    name:"优质特一粉"
                },
                {
                    name:"小包装"
                },
                {
                    name:"标准粉"
                },
                {
                    name:"普通粉"
                },
                {
                    name:"次粉"
                },
                {
                    name:"麸皮"
                }
            ],
            current: 0
        }
    },
    methods: {
        s_click(res,item) {
            this.current = res
            this.$bus.$emit('qiehuan',item.name)
        }
    },
}
</script>

<style scoped>
.fou_sid {
    width: 100%;
    height: 100%;
    position: relative;
    top: 0;
}
.fou_sid > div {
    position: relative;
    height: 10vw;
    
    margin-bottom: 4.3vw;
}
.fou_sid > div > div {
    position: absolute;
    top: 0;bottom: 0;
    margin: auto;
    padding-left: 2vw;
    /* width: 100%; */
    height: 7vw;
    line-height: 7vw;
    font-size: 13px;
    font-weight: 700;
}
/* 点击切换样式 */
.Sidebar {
    background-color: #fff;
    color: #356096;
}
.sidebar_inner {
    border-left: 3.5px solid #356096;
    box-sizing: border-box;
}
</style>