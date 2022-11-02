<template>
  <div class="sea">
    <div class="sea_top"><i class="el-icon-arrow-left" @click="fanhui"></i><span class="span1">搜索内容</span></div>
    <div class="sea_bottom">
      <div class="sea_bottom_input">
        <el-autocomplete
          popper-class="my-autocomplete"
          v-model="state"
          :fetch-suggestions="querySearch"
          placeholder="请输入要搜索商品"
          @select="handleSelect"
          ref="reference"
        >
          <i
            class="el-icon-search el-input__icon"
            slot="prefix"
            
          >
          </i>
        </el-autocomplete>
        <button @click="handleIconClick()">搜索</button>
      </div>
      <div class="sea_bottom_recent">
        <span
          ><i class="el-icon-time"></i> 最近搜索<i
            @click="delete_fn"
            class="el-icon-delete-solid"
          ></i
        ></span>
        <span v-for="(item, index) in history" :key="index" @click="handleIconClick(item)">{{ item }}</span>
      </div>
      <div class="search_goods" v-if="isTrue">
          <!-- <Doods/> -->
          <router-view></router-view>
    </div>
    </div>
  </div>
</template>

<script>
import Doods from './goods.vue'
export default {
  components: { Doods },
  name: "search",
  created() {
    // 历史记录
    this.$http.post('http://localhost:3000/get_history',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc}).then((res)=> {
      res.data.value.forEach((res)=> {
        this.history.unshift(res.history)
      })
    })
    this.$http({
        method: "GET",
        url:"http://localhost:3000/all_goods",
      }).then((res)=> {
        let infoAll = res.data.value
        let info = []
        infoAll.forEach((item)=> {
          info.push({'value':item.g_name})
        })
        this.restaurants = info
        this.restaurants2 = info
    })
  },
  mounted() {
    if (this.$route.name == 'search') {
      this.$refs.reference.focus()
    }
  },
  data() {
    return {
      restaurants: [],
      restaurants2: [],
      state: "",
      // 历史记录
      history: [],
    };
  },
  methods: {
    // 返回点击事件
    fanhui() {
      // this.$router.go(-1)
      console.log(this.$route);
      this.$router.push({path:`${this.$route.matched[1].path}`})
    },
    querySearch(queryString, cb) {
      var restaurants = this.restaurants;
      var results = queryString
        ? restaurants.filter(this.createFilter(queryString))
        : restaurants;
      // 调用 callback 返回建议列表的数据
      cb(results);
    },
    createFilter(queryString) {
      return (restaurant) => {
        return (
          restaurant.value.toLowerCase().indexOf(queryString.toLowerCase()) != -1
        );
      };
    },
    // loadAll() {
      
    //   return [
    //     { value: "三全鲜食（北新泾店）" }
    //   ];
    // },
    handleSelect(item) {
      // console.log(item);
    },
    // 点击搜索
    handleIconClick(res) {
      let info = res||this.$refs.reference.value
      this.$http({
        method:"POST",
        url:"http://localhost:3000/s_goods_name",
        data:{g_type:info}
      }).then((res)=> {
        if(res.data.value.length >= 1) {
          // console.log(this.$route.path);
          this.$router.replace({path:`${this.$route.path}/goods`,query:{g_type:info,method:'s_goods_name'}})
          // console.log(res.data.value);
          // 添加到历史记录
          this.$http({
            method: "POST",
            url:"http://localhost:3000/add_history",
            data:{
              user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc,
              search_info:info
          }
      })
        } else {
          console.log("没有该商品");
        }
      })
      
    },
    // 删除历史记录
    delete_fn() {
      this.$http.post('http://localhost:3000/delete_history',{user_acc:JSON.parse(sessionStorage.getItem('user'))[0].user_acc})
      this.history = []
    },
 
  },
  computed: {
      // 是否展示搜索内容
      isTrue() {
        return this.$route.name == 'search' ? 0 : 1
      }
  }
};
</script>

<style>
  .span1{
    font-size: 18px;
    font-weight: 700;
    color: white;
  }
.sea {
  width: 100vw;
  height: 100%;
  position: relative;
  display: flex;
  flex-direction: column;
  background-color: white;
  z-index: 5;
  overflow: scroll;
}
.sea_top {
  flex: 1;
  /* text-align: center; */
  line-height: 50px;
  color: white;
  background:linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
}
.sea_top > .el-icon-arrow-left {
  margin-left: 2vw;
  font-size: 24px !important;
  margin-right: 31vw;
}
.sea_bottom {
  flex: 12;
}
.sea_bottom_input {
  width: 100%;
  /* height: 9vw; */
  position: relative;
}
.sea_bottom_input button {
  width: 13vw;
  height: 7.3vw;
  position: absolute;
  top: 2vw;
  right: 2vw;
  border: 0;
  border-radius: 4vw;
  font-size: 14px;
  text-align: center;
  line-height: 8vw;
  color: white;
  background-color: rgb(29, 59, 97);
}
.sea_bottom_recent {
  width: 94%;
  height: 20vw;
  margin: auto;
  margin-top: 2vw;
  font-size: 14px;
  color: rgb(153, 153, 153);
}
.sea_bottom_recent > span:nth-of-type(n + 2) {
  display: inline-block;
  font-size: 12px;
  background-color: rgb(246, 246, 246);
  color: black;
  margin: 1vw;
  padding: 0 1vw;
  border-radius: 3vw;
 position: relative;
 top: 2vw;
}
.sea_bottom_recent .el-icon-delete-solid {
  margin-left: 70vw;

}

/* 输入框样式 */
.my-autocomplete {
  line-height: normal;
  padding: 7px;
  border-radius: 20px;
}
.name {
  text-overflow: ellipsis;
  overflow: hidden;
}

/* /deep/可以强制修改样式 */
.el-input__inner {
  border-radius: 20px !important;
  color: #8b8b8c;
  background-color: #f7f7f9;
  height: 29px;
  width: 79vw;
  text-align: center;
  border: 0;
  margin-left: 2vw;
  font-size: 13px;
  position: relative;
  top: 2vw;
}
.el-input__icon {
  line-height: 30px;
  padding-left: 1vw;
  position: absolute;
  top: 2vw;
}
.el-autocomplete-suggestion {
  background-color: #ced5de;
  opacity: 0.9;
}
.el-scrollbar__view li {
  color: black;
}
.search_goods {
  width: 100vw;
  height: 100vh;
  position: fixed;
  top: 0;
  background-color: rgb(246, 246, 246);
  display: flex;
  flex-direction: column;
}
.search_goods_top {
  flex: 1;
  position: relative;
  background-color: white;
}
.search_goods_bottom {
  position: relative;
  flex: 6.5;
}
</style>