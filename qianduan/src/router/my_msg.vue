<template>
  <div class="gerenxinxi">
    <div class="page">
      <div class="page_up">
        <!-- <div class="up_img"><img src="./assets/返回.png" alt=""></div> -->
        <i class="el-icon-arrow-left" @click="fanhui"></i>
        <div class="info"><span class="info_p">详细资料</span></div>
      </div>
      <div class="middle">
        <!-- <el-upload class="el_inp avatar-uploader" action=""
            :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload">
            <img v-if="imageUrl" :src="imageUrl" class="avatar tou_xiang">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload> -->
        <div class="sc">
          <div class="uploader">
            <input
              type="file"
              class="fonts"
              name=""
              @change="afterRead"
              ref="updata"
              accept="image/*"
              id="upload"
            />
          </div>

          <label for="upload">
            <div class="laber-up">
              <div v-show="src"><img :src="src" alt="" srcset="" /></div>
              <div v-show="!src">
                <p><span class="step-color">点击</span>上传头像</p>
              </div>
            </div>
          </label>
        </div>
        <div class="zi_liao">
          <div class="i_i i_id">
            <div class="i_span">账号</div>
            <input
              class="id_num"
              placeholder="账号"
              type="text"
              v-model="msg.user_acc"
            />
          </div>
          <div class="i_i i_name">
            <div class="i_span">名称</div>
            <input
              class="name_name"
              placeholder="名称"
              type="text"
              v-model="msg.user_name"
            />
          </div>
          <div class="i_i i_gender">
            <div class="i_span">性别</div>
            <input
              class="gender_gender"
              placeholder="性别"
              type="text"
              v-model="msg.user_sex"
            />
          </div>
          <div class="i_i i_number">
            <div class="i_span">电话</div>
            <input
              class="number_number"
              placeholder="电话"
              type="text"
              v-model="msg.user_phone"
            />
          </div>
        </div>
        <div class="address">
          <div class="add">
            <span class="i_span">默认地址</span>
            <div @click="add_fn" class="add_info">
              <div class="add_info_a" v-if="status == 1">
                <div class="a_name">{{ msg.user_address_name }}</div>
                <div class="a_number">{{ msg.user_phone2 }}</div>
              </div>
              <div class="add_info_a" v-if="status == 0">
                <div class="a_name">{{ items.user_name2 }}</div>
                <div class="a_number">{{ items.user_phone3 }}</div>
              </div>
              <div class="add_info_b" v-if="status == 1">
                <div class="b_address">{{ msg.user_ress2 }}</div>
              </div>
              <div class="add_info_b" v-if="status == 0">
                <div class="b_address">{{ items.user_ress }}</div>
              </div>
              <div class="add_info_c" v-if="status == 1">
                <div class="c_info huan_hang">{{ msg.more_address2 }}</div>
              </div>
              <div class="add_info_c" v-if="status == 0">
                <div class="c_info huan_hang">{{ items.more_address }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="page_down">
        <div @click="fn(msg, items)" class="save">保存修改</div>
      </div>
    </div>
  </div>
</template>
  
  <script>
  import Vue from 'vue'
export default {
  created() {
    this.$http
      .post("http://192.168.0.135:3000/get_user_info", {
        user_acc: JSON.parse(sessionStorage.getItem("user"))[0].user_acc,
      })
      .then((res) => {
        this.msg = res.data.value[0];
        // console.log(this.msg);
        this.src = `http://192.168.0.135:3000/img/${res.data.value[0].user_img}.jpg`
      });
    this.items = this.$route.params.item;
    this.status = Vue.prototype.$status
  },
  data() {
    return {
      src: "",
      imageUrl: "",
      msg: [],
      user_addres: null,
      items: [],
      status: ''
    };
  },
  beforeRouteEnter (to, from, next) {
    // console.log(to, from);
    if (from.name == 'detail_addres') {
      Vue.prototype.$status = 0
    } else{
      Vue.prototype.$status = 1
    }
    next()
  },
  methods: {
    afterRead() {
      let that = this;
      let file = this.$refs.updata.files[0];
        // console.log(file);
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function (e) {
        //   console.log(e);
        that.src = this.result; //显示缩略图
      };
    },
    add_fn() {
      this.$router.push({ name: "detail_addres" });
    },
    fanhui() {
      this.$router.push({ name: "my" });
    },
    handleAvatarSuccess(res, file) {
      this.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === "image/jpeg";
      const isLt2M = file.size / 1024 / 1024 < 2;
      if (!isJPG) {
        this.$message.error("上传头像图片只能是 JPG 格式!");
      }
      if (!isLt2M) {
        this.$message.error("上传头像图片大小不能超过 2MB!");
      }
      return isJPG && isLt2M;
    },
    fn(msg, items) {
      let fd = new FormData()
      if (items) {       
        fd.append('user_img', this.$refs.updata.files[0])
        fd.append('user_acc', JSON.parse(sessionStorage.getItem("user"))[0].user_acc)
        fd.append('user_name', msg.user_name)
        fd.append('user_phone', msg.user_phone)
        fd.append('user_sex', msg.user_sex)
        fd.append('user_address_name', items.user_name2)
        fd.append('user_phone2', items.user_phone3)
        fd.append('user_ress2', items.user_ress)
        fd.append('more_address2', items.more_address)
      } else {
        fd.append('user_img', this.$refs.updata.files[0])
        fd.append('user_acc', JSON.parse(sessionStorage.getItem("user"))[0].user_acc)
        fd.append('user_name', msg.user_name)
        fd.append('user_phone', msg.user_phone)
        fd.append('user_sex', msg.user_sex)
        fd.append('user_address_name', msg.user_address_name)
        fd.append('user_phone2', msg.user_phone2)
        fd.append('user_ress2', msg.user_ress2)
        fd.append('more_address2', msg.more_address2)
      }
      
      
      this.$http
        .post("http://192.168.0.135:3000/user_info", fd)
        .then((res) => {
          // this.msg = res.data.value
          console.log(res.data);
          this.$http
            .post("http://192.168.0.135:3000/get_user_info", {
              user_acc: JSON.parse(sessionStorage.getItem("user"))[0].user_acc,
            })
            .then((res) => {
              this.msg = res.data.value[0];
              // console.log(this.msg);
            });
        });
    },
  },
};
</script>
  
  <style scoped>
/* 返回按钮 */
.gerenxinxi .el-icon-arrow-left {
  color: white;
  font-size: 24px;
  padding: 0 2vw;
}


.uploader {
  display: none;
}
.laber-up {
  width: 100%;
  height: 3.5rem;
  /* background: skyblue; */
  margin-bottom: 0.4rem;
}
.laber-up > div {
  width: 140px;
  height: 140px;
  margin-top: -64px;
  line-height: 56px;
  border: 1px solid rgb(176, 176, 176);
  border-radius: 50%;
  box-sizing: border-box;
  background-size: cover;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: rgb(232, 232, 232);
  position: relative;
}
.laber-up > div > p {
  font-size: 0.4rem;
  position: absolute;
  top: 2.6rem;
  color: #333;
}
.laber-up > div > img {
  width: 140px;
  height: 140px;
  border-radius: 50%;
}



.gerenxinxi .page {
  width: 100vw;
  height: 100vh;
  background-color: #f0f2f5;
}

.page_up {
  width: 100%;
  height: 8%;
  display: flex;
  align-items: center;
  color: white;
  background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
}

.up_img {
  width: 10%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.up_img > img {
  width: 20px;
  height: 20px;
}

.info {
  width: 80%;
  height: 100%;
}

.info_p {
  font-family: "微软雅黑";
  font-size: 18px;
  font-weight: 700;
  letter-spacing: 2px;
  position: relative;
  top: 17px;
}

.middle {
  width: 100%;
  height: 84%;
  background-color: #f0f2f5;
  overflow-y: scroll;
  overflow-x: hidden;
}
.sc {
  width: 100%;
  height: 160px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.el_inp {
  display: flex;
  justify-content: center;
  margin-top: 10px;
  background-color: #ffffff;
  padding-top: 5px;
  padding-bottom: 5px;
}

.avatar-uploader .el-upload {
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}

.avatar-uploader-icon {
  border: 1px dashed #c0bebe;
  font-size: 28px;
  color: #8c939d;
  width: 125px;
  height: 125px;
  line-height: 125px;
  text-align: center;
}

.avatar {
  width: 125px;
  height: 125px;
  display: block;
}

.zi_liao {
  width: 100%;
  height: 40%;
  background-color: #ffffff;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px;
  box-sizing: border-box;
}

.i_i {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 90%;
  height: 25%;
  border-bottom: 1px solid #e9ebed;
}

.i_span {
  font-family: "微软雅黑";
  font-size: 16px;
  color: #333333;
  letter-spacing: 2px;
}

.i_i > input {
  width: 80%;
  height: 60%;
  font-family: "微软雅黑";
  font-size: 16px;
  color: #333333;
  border-color: transparent;
  outline: none;
  caret-color: #8c939d;
}

.address {
  width: 100%;
  height: 20%;
  margin-top: 10px;
  background-color: #ffffff;
  display: flex;
  justify-content: center;
  align-items: center;
}
.add {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 90%;
  height: 90%;
}
.add_info {
  width: 120%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.add_info_a {
  width: 100%;
  height: 20%;
  display: flex;
  align-items: center;
}
.a_name {
  font-family: "微软雅黑";
  font-size: 16px;
  color: #333333;
  font-weight: 550;
  letter-spacing: 1px;
  margin-right: 5px;
}
.a_number {
  font-family: "微软雅黑";
  font-size: 14px;
  color: #a1a0a0;
  /* letter-spacing: 2px; */
}
.add_info_b {
  width: 100%;
  height: 20%;
  display: flex;
  align-items: center;
}
.add_info_c {
  width: 100%;
  /* height: 60%; */
  margin-top: 3px;
}
.b_address,
.c_info {
  font-family: "微软雅黑";
  font-size: 14px;
  color: #333333;
}
.huan_hang {
  clear: both; /* 清除左右浮动 */
  width: 100%; /* 必须定义宽度 */
  /* border:1px solid;定义容器外边框 */
  word-break: break-word; /* 文本行的任意字内断开，就算是一个单词也会分开 */
}
.page_down {
  width: 100%;
  height: 8%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.save {
  width: 30%;
  height: 70%;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #2964a0;
  border-radius: 5px;
  font-family: "微软雅黑";
  font-size: 16px;
  color: white;
  font-weight: 550;
  letter-spacing: 1px;
}
</style>
  