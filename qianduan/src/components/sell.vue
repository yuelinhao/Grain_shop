// 我的页面热销产品
<template>
  <div class="sel">
    <div class="sel_top">
        <img src="../static/home_img/热销标题.png"/>
        <div>更多<i class="el-icon-arrow-right"></i></div>
    </div>
    <div class="sel_bottom">
        <div class="sel_bottom_box" ref="box">
            <span class="sel_bottom_list" v-for="item,index in lists" :key="index">
                <div class="sel_bottom_list_img" @click="to_detail(item)">
                    <div>
                        <img :src="'http://192.168.0.135:3000/img/'+item.g_img+'.jpg'" alt="">
                    </div>
                </div>
                <div class="sel_bottom_list_price">￥{{item.g_price}}</div>
            </span>
        </div>
    </div>
  </div>
</template>

<script>
export default {
    created(){
        this.$http.get('http://192.168.0.135:3000/hot_goods').then((res)=> {
            this.lists = res.data.value
        })
    },
    data() {
        return {
            lists:[],
        }
    },
    methods: {
        to_detail(item) {
            this.$router.push({name:'goods_detail',params:{detail:item}})
        }
    }
}
</script>

<style scoped>
.sel {
    width: 94vw;
    height: 46vw;
    margin: auto;
    border-radius: 6px;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    background-color: #fff;
    margin-bottom: 5vw;
}
.sel_top {
    flex: 1;
    position: relative;
}
.sel_top > img {
    position: absolute;
    width: 21vw;
    top: 3vw;
    left: 4vw;
}
.sel_top > div {
    width: 10vw;
    position: absolute;
    top: 3vw;
    right: 2vw;
    font-size: 12px;
    color: rgba(0, 0, 0, .5);
}
.sel_bottom {
    flex: 4;
    overflow-x: scroll;
    column-count: 1;
}

.sel_bottom_box {
    height: 100%;
    /* 不换行 */
    white-space:nowrap;
}
.sel_bottom_list {
    display:inline-flex;
    flex-direction: column;
    margin: 1.5vw 0 0 2vw;
    width: 22.6vw;
    height: 33vw;
    overflow: hidden;
    /* border-radius: 4px; */
}
.sel_bottom_list_img {
    flex: 4;
    border-radius: 3px;
    position: relative;
}
.sel_bottom_list_img >div {
    width: 20vw;
    height: 20vw;
    position: absolute;
    top: 0;bottom: 0;left: 0;right: 0;margin: auto;
    overflow: hidden;

}
.sel_bottom_list_img > div > img {
    width: 20vw;
}
.sel_bottom_list_price {
    flex: 1;
    text-align: center;
    font-size: 14px;
    color: #eb4926;
}

</style>