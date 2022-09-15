<template>
  <div class="tj_box">
    <div class="cc_s">
      <div>
        <div class="cc_sz">
          <div class="f1">
            <i class="el-icon-arrow-left" @click="fan_my"></i>
          </div>
          <div class="ding_zi">推荐</div>
        </div>
        <div class="box3">
          <div class="block">
            <el-carousel height="45vw">
              <el-carousel-item>
                <img class="img1" :src="require('../assets/img/1.jpg')" alt="" />
              </el-carousel-item>
              <el-carousel-item>
                <img class="img1" :src="require('../assets/img/2.jpg')" alt="" />
              </el-carousel-item>
              <el-carousel-item>
                <img class="img1" :src="require('../assets/img/4.jpg')" alt="" />
              </el-carousel-item>
              <el-carousel-item>
                <img class="img1" :src="require('../assets/img/5.jpg')" alt="" />
              </el-carousel-item>
            </el-carousel>
          </div>
        </div>
        <div class="box4">
          <div class="hang">
            <span>
              <h2>大米</h2>
            </span>
            <el-collapse accordion>
              <div class="hang1">
                <div><span>品牌：<span class="mi">金龙鱼大米</span></span></div>
                <div><span class="nn">推荐：<img class="xx" v-for="item in imgUrl" :src="item.url" alt=""></span></div>
              </div>

              <el-collapse-item title="描述：">
                <div><span class="ly">推荐理由：</span>大米香味浓郁，非常好闻。</div>
                <div>&nbsp;&nbsp;&nbsp;“金龙鱼”是益海嘉里金龙鱼粮油食品股份有限公司所拥有的食用油品牌。 益海嘉里金龙鱼粮油食品股份有限公司是中国最大的农产品和食品加工企业之一。</div>
              </el-collapse-item>

              <div class="hang1">
                <div><span>品牌：<span class="mi">柴火大院大米</span></span></div>
                <div><span class="nn">推荐：<img class="xx" v-for="item in imgUrl" :src="item.url" alt=""></span></div>
              </div>
              <el-collapse-item title="描述：">
                <div><span class="ly">推荐理由：</span>感觉品质确实非常好，价格也可以接受，味道很香。</div>
                <div>&nbsp;&nbsp;&nbsp;柴火大院，五常市彩桥米业有限公司旗下品牌 ，柴火大院主打草帽包装风格，该品牌注重食品安全与膳食营养。</div>
              </el-collapse-item>

              <div class="hang1">
                <div><span>品牌：<span class="mi">十月稻田大米</span></span></div>
                <div><span class="nn">推荐：<img class="xx" v-for="item in imgUrl" :src="item.url" alt=""></span></div>
              </div>

              <el-collapse-item title="描述：">
                <div><span class="ly">推荐理由：</span>很香味儿。米粒色泽有光泽。有特有的米香味儿。表面有油光。</div>
                <div>
                  &nbsp;&nbsp;&nbsp;十月稻田，专注东北香米，是一个以优质东北大米、杂粮、干货为主营的农业品牌，致力于为国人提供大众化、优质化的健康食粮，其产品风格丰富多样，从不同角度诠释健康食粮的多样性，满足不同消费者的消费需求。
                </div>
                <div>
                  &nbsp;&nbsp;&nbsp;十月稻田，专注东北香米，是一个以优质东北大米、杂粮、干货为主营的农业品牌，致力于为国人提供大众化、优质化的健康食粮，其产品风格丰富多样，从不同角度诠释健康食粮的多样性，满足不同消费者的消费需求。
                </div>
              </el-collapse-item>

              <div class="hang1">
                <div><span>品牌：<span class="mi">福临门大米</span></span></div>
                <div>
                  <span class="nn">推荐：<img class="xx" v-for="item in imgUrl" :src="item.url" alt="" >
                  </span></div>
              </div>

              <el-collapse-item title="描述：">
                <div><span class="ly">推荐理由：</span>大米色泽光亮，颗粒饱满，米香浓郁，吃完了再来买</div>
                <div>&nbsp;&nbsp;&nbsp;多年来，福临门用自身的专业、创新和坚持，不断奉献安全、营养、健康、美味的产品给消费者，“福临门”系列食用油的销量在全国同业中名列前茅。</div>
              </el-collapse-item>

              <div class="hang1">
                <div><span>品牌：<span class="mi">国宝大米</span></span></div>
                <div><span class="nn">推荐：<img class="xx" v-for="item in imgUrl" :src="item.url" alt=""></span></div>
              </div>

              <el-collapse-item title="描述：">
                <div><span class="ly">推荐理由：</span>安全、营养、食味、健康四大要素，贯穿以高品质占领市场理念。</div>
                <div>&nbsp;&nbsp;&nbsp;开发了无公害、绿色食品、有机食品、专产品四类别，形成极品、珍品、精品、优质品四大系列45个单品。</div>
              </el-collapse-item>
            </el-collapse>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      activeNames: ["1"],
      imgUrl: [
        {
          url: require('@/assets/img/星星.png')
        },
        {
          url: require('@/assets/img/星星.png')
        },
        {
          url: require('@/assets/img/星星.png')
        },
        {
          url: require('@/assets/img/星星.png')
        },
        {
          url: require('@/assets/img/星星.png')
        },
      ]
    };
  },
  methods: {
    fan_my() {
      this.$router.push("/my");
    },
    handleChange(val) {
      console.log(val);
    },
  },
};
</script>
<style scoped>
.tj_box .el-icon-arrow-left {
  font-size: 23px;
  color: white;
}
.span1 {
  font-size: 20px;
  position: absolute;
  left: 43px;
}
.tj_box {
  width: 100%;
  height: 100%;
  position: absolute;
  z-index: 7777;
  overflow: hidden;
  background-color: #e5e4e4;
}
.cc_sz {
  width: 100vw;
  height: 48px;
  font-size: 18px;
  font-weight: 700;
  color: white;
  background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
}
.ly {
  color: red;
}

.cc_sz {
  width: 100vw;
  height: 55px;
  line-height: 55px;
  font-size: 19px;
  font-weight: 600;
  display: flex;
  justify-content: flex-start;
  color: white;
  text-align: center;
  background-color: #21528a;
}

.ly {
  color: red;
}

.f1 {
  width: 10%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.xx {
  width: 20px;
  height: 20px;
}

.f1>img {
  float: left;
  width: 28px;
  margin-top: 11px;
  overflow: hidden;
  transform: rotate(180deg);
}

.box3 {
  width: 100%;
  height: 170px;
  text-align: center;
}

.nn {
  float: right;
}

.img1 {
  width: 100%;
  height: 45vw;
}

.box4 {
  height: 441px;
  overflow: scroll;
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: rgba(246, 246, 246, 1);
}

.hang {
  width: 94%;
  height: 424px;
  margin-top: 3px;
  padding: 5px;
  margin-bottom: 5px;
  background-color: white;
  border-radius: 6px;
}

.nn {
  float: right;
}
.hang1 {
  display: flex;
}

.hang1>div {
  flex: 1;
}

.mi {
  font-weight: 600;
  font-size: 15px;
}

.tj_box {
  width: 100%;
  height: 100%;
  position: absolute;
  z-index: 8888;
  background-color: #e5e4e4;
}

.cc_sz {
  width: 100vw;
  height: 55px;
  line-height: 55px;
  font-size: 19px;
  font-weight: 600;
  display: flex;
  color: white;
  text-align: center;
  background-color: #21528a;
}

.ly {
  color: red;
}

.f1 > img {
  float: left;
  width: 40px;
  margin-top: 9px;
  overflow: hidden;
  transform: rotate(180deg);
}

.box3 {
  width: 100%;
  height: 170px;
  text-align: center;
}

.img1 {
  width: 100%;
  height: 45vw;
}

.box4 {
  height: 441px;
  overflow: scroll;
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: rgb(220, 233, 245);
}

.hang {
  width: 94%;
  height: 424px;
  margin-top: 3px;
  padding: 5px;
  margin-bottom: 5px;
  background-color: white;
  border-radius: 6px;
}

.mi {
  font-weight: 600;
  font-size: 15px;
}
</style>