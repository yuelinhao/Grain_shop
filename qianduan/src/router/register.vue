<template>
  <div class="wrapper">
    <div
      style="
        margin: 160px auto;
        background-color: rgb(240, 238, 238, 0.4);
        width:272px;
        height: 272px;
        padding: 20px;
        border-radius: 10px;
      "
    >
      <div style="margin: 20px 0; text-align: center; font-size: 20px">
        <b>注 册</b>
      </div>
      <el-form :model="user" ref="userForm">
        <el-form-item prop="username">
          <el-input prefix-icon="el-icon-user" placeholder="请输入账号" v-model="input" clearable>
          </el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            size="medium"
            style="margin: 10px 0"
            prefix-icon="el-icon-lock"
            show-password
            v-model="user.password"
          ></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            size="medium"
            style="margin:0"
            prefix-icon="el-icon-lock"
            show-password
            v-model="user.s_password"
          ></el-input>
        </el-form-item>
        <el-form-item style="margin: 60px 20px; text-align: center"
          ><el-button
            type="primary"
            size="medium"
            autocomplete="off"
            @click="$router.push('/login')"
            >登录</el-button
          >
          <el-button
            type="warning"
            size="medium"
            autocomplete="off"
            @click="register"
            >注册</el-button
          >
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>
<script>
export default {
  name: "register",
  data() {
    return {
      input:'',
      user: {},
    //   rules: {
    //     username: [
    //       { 
    //       required: true, 
    //       message: "请输入账号",
    //       trigger: "blur"
    //       },
    //       {
    //          min: 3, max: 10, message: "长度在 3 到 5 个字符", trigger: "blur" },
    //     ],
    //     password: [
    //       { 
    //         required: true, message: "请输入密码", trigger: "blur" },
    //       {
    //         min: 1,
    //         max: 20,
    //         message: "长度在 1 到 20 个字符",
    //         trigger: "blur",
    //       },
    //     ],
    //     validCode: [
    //       { required: true, trigger: "change", message: "验证码不能为空" },
    //     ],
    //   },
    };
  },
  createValidCode: "",
  methods: {
    createValidCode(data) {
      this.validCode = data;
    },
    register() {
      this.$refs["userForm"].validate((valid) => {
        if (valid) {
          // 表单校验合法
          
          if (!this.input) {
            this.$message.error("请填写账号");
            return;
          }
          if (!this.user.password) {
            this.$message.error("请填写密码");
            return;
          }
          if (!this.user.s_password) {
            this.$message.error("请确认密码");
            return;
          }
          if(this.user.password != this.user.s_password) {
            this.$message.error("请确认密码相同");
            return;
          }
          this.$http.post('http://localhost:3000/f_reg',{account:this.input,password:this.user.password}).then((res)=> {
            if(res.data.msg == '注册成功') {
                this.$message.success("注册成功");
                setTimeout(() => {
                    this.$router.push({name:'login',params:{input:this.input,password:this.user.password}})
                }, 1000);
                this.hx_conn.registerUser({ 'username': this.input, 'password': this.input })
                  .then((res) => {
                      console.log('注册成功');
                      console.log(res);
                  })
                  .catch((e) => {
                      console.log('注册失败');
                      console.log(e);
                  });
            }else {
                this.$message.warning("账号已被注册")
            }
          })
        //   this.request.post("/user/login", this.user).then((res) => {
        //     if (res.code === "200") {
        //       localStorage.setItem("user", JSON.stringify(res.data)); // 存储用户信息到浏览器
        //       this.$router.push("/");
        //       this.$message.success("登录成功");
        //     } else {
        //       this.$message.error(res.msg);
        //     }
        //   });
        }
      });
    },
  },
};
</script>
<style scoped>
.wrapper {
  width: 100vw;
  height: 100vh;
  /* background-image: linear-gradient(to bottom right, #26609b, #133b66); */
  background: url(@/assets/img/bi.png);
  background-size: cover;
  background-position: center;
  box-sizing: border-box;
  overflow: hidden;
}
.wrapper ,.el-button--medium {
    padding: 10px 30px;
    font-size: 14px;
    border-radius: 4px;
}
</style>
