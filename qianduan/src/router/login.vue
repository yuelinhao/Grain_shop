<template>
  <div class="wrapper">
    <i
      class="el-icon-arrow-left"
      style="position: absolute; left: 2vw; top: 2vw"
      @click="$router.push('/home')"
    ></i>
    <div
      style="
        margin: 160px auto;
        background-color: rgb(240, 238, 238, 0.4);
        width: 272px;
        height: 272px;
        padding: 20px;
        border-radius: 10px;
      "
    >
      <div style="margin: 20px 0; text-align: center; font-size: 20px">
        <b>登 录</b>
      </div>
      <el-form :model="user" ref="userForm">
        <el-form-item prop="username">
          <el-input
            prefix-icon="el-icon-user"
            placeholder="请输入账号"
            v-model="input"
            clearable
          >
          </el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            size="medium"
            style="margin: 10px 0; "
            prefix-icon="el-icon-lock"
            show-password
            clearable
            v-model="user.password"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <div style="display: flex">
            <el-input
              size="medium"
              prefix-icon="el-icon-key"
              v-model="user.validCode"
              style="width: 50%;"
            ></el-input>
            <ValidCode @input="createValidCode" />
          </div>
        </el-form-item>
        <el-form-item style="margin: 60px 20px; text-align: center"
          ><el-button
            type="primary"
            size="medium"
            autocomplete="off"
            @click="login"
            >登录</el-button
          >
             
          <el-button
            type="warning"
            size="medium"
            autocomplete="off"
            @click="$router.push('/register')"
            >注册</el-button
          >
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>
<script>
// 验证码插件
import ValidCode from "../components/validCode";
export default {
  name: "login",
  components: {
    ValidCode,
  },
  data() {
    return {
      input: "",
      user: {},
      // rules: {
      //   username: [
      //     {
      //     required: true,
      //     message: "请输入账号",
      //     trigger: "blur"
      //     },
      //     {
      //        min: 3, max: 10, message: "长度在 3 到 5 个字符", trigger: "blur" },
      //   ],
      //   password: [
      //     {
      //       required: true, message: "请输入密码", trigger: "blur" },
      //     {
      //       min: 1,
      //       max: 20,
      //       message: "长度在 1 到 20 个字符",
      //       trigger: "blur",
      //     },
      //   ],
      //   validCode: [
      //     { required: true, trigger: "change", message: "验证码不能为空" },
      //   ],
      // },
    };
  },
  createValidCode: "",
  created() {
    let { input, password } = this.$route.params;
    this.input = input;
    //this.user.password = this.user.password || password;
  },
  methods: {
    createValidCode(data) {
      this.validCode = data;
    },
    login() {
      this.$refs["userForm"].validate((valid) => {
        if (valid) {
          // 表单校验合法
          if (!this.user.validCode) {
            this.$message.error("请填写验证码");
            return;
          }
          if (
            this.user.validCode.toLowerCase() !== this.validCode.toLowerCase()
          ) {
            this.$message.error("验证码错误");
            return;
          }
          if (!this.input) {
            this.$message.error("请填写账号");
            return;
          }
          if (!this.user.password) {
            this.$message.error("请填写密码");
            return;
          }
          this.$http
            .post("http://localhost:3000/f_login", {
              account: this.input,
              password: this.user.password,
            })
            .then((res) => {
              if (res.data.msg == "登录成功") {
                this.$message.success("登录成功,赶快购物吧");
                sessionStorage.setItem("user", JSON.stringify(res.data.value));
                localStorage.setItem("token_liu", res.data.data);
                setTimeout(() => {
                  this.$router.push({ name: "home" });
                }, 1000);
                this.hx_conn
                  .open({ user: this.input, pwd: this.input })
                  .then((res) => {
                    console.log("登录成功");
                  })
                  .catch((e) => {
                    console.log("登录失败");
                  });
              } else {
                this.$message.error("账号或密码有误");
              }
            });
          // this.request.post("/user/login", this.user).then((res) => {
          //   if (res.code === "200") {
          //     localStorage.setItem("user", JSON.stringify(res.data)); // 存储用户信息到浏览器
          //     this.$router.push("/");
          //     this.$message.success("登录成功");
          //   } else {
          //     this.$message.error(res.msg);
          //   }
          // });
          // if()
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
