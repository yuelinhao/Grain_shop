<template>
  <div class="pwd">
    <div class="head">
      <i class="el-icon-arrow-left" @click="fan_home"></i>
      <span class="span2"><strong>设置登录密码</strong></span>
    </div>
    <div class="main">
      <el-form
        :model="ruleForm"
        status-icon
        :rules="rules"
        ref="ruleForm"
        label-width="100px"
        class="demo-ruleForm"
      >
        <el-form-item label="原密码" prop="checkthePass">
          <el-input
            type="password"
            v-model="ruleForm.checkthePass"
            autocomplete="off"
            show-password
          ></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="pass">
          <el-input
            type="password"
            v-model="ruleForm.pass"
            autocomplete="off"
            show-password
          ></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="checkPass">
          <el-input
            type="password"
            v-model="ruleForm.checkPass"
            autocomplete="off"
            show-password
          ></el-input>
        </el-form-item>

        <!-- <el-form-item label="年龄" prop="age">
              <el-input v-model.number="ruleForm.age"></el-input>
            </el-form-item> -->
        <el-form-item>
          <el-button
            type="primary"
            @click="submitForm('ruleForm')"
            style="background-color: #2964a0; width: 50px; height: 29px"
            >提交</el-button
          >
          <el-button
            @click="resetForm('ruleForm')"
            style="
              background-color: #2964a0;
              width: 50px;
              height: 29px;
              color: white;
            "
            >重置</el-button
          >
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    //   var checkAge = (rule, value, callback) => {
    //     if (!value) {
    //       return callback(new Error('年龄不能为空'));
    //     }
    //     setTimeout(() => {
    //       if (!Number.isInteger(value)) {
    //         callback(new Error('请输入数字值'));
    //       } else {
    //         if (value < 18) {
    //           callback(new Error('必须年满18岁'));
    //         } else {
    //           callback();
    //         }
    //       }
    //     }, 1000);
    //   };
    var validatePass = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        if (this.ruleForm.checkPass !== "") {
          this.$refs.ruleForm.validateField("checkPass");
        }
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.ruleForm.pass) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
      input: "",
      ruleForm: {
        pass: "",
        checkPass: "",
      },
      rules: {
        pass: [{ validator: validatePass, trigger: "blur" }],
        checkPass: [{ validator: validatePass2, trigger: "blur" }],
      },
    };
  },
  name: "pwd",
  methods: {
    fan_home() {
      this.$router.replace({ name: "safe" });
    },

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          alert("修改密码成功！");
        } else {
          alert("两次输入密码不一致!");
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
  },
};
</script>
<style scoped>
* {
  padding: 0;
  margin: 0;
  overflow: hidden;
}
.pwd {
  width: 100vw;
  height: 100vh;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  background-color: rgb(246, 246, 246);
}
.head .el-icon-arrow-left {
  font-size: 23px;
  color: white;
  margin: 0 2vw;
}
.head {
  flex: 2;
  line-height: 48px;
  background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
  color: white;
}
.main {
  flex: 25;
  display: flex;
  flex-direction: column;
}
.span2 {
  font-size: 20px;
}
.demo-ruleForm {
  position: relative;
  top: 124px;
  left: -21px;
}
</style>