<template>
    <div class="login-wrap">
        <div class="ms-login">
            <div class="ms-title">后台管理系统</div>
            <el-form v-if="isReg == 0" :model="param" :rules="rules" ref="login" label-width="0px" class="ms-content">
                <el-form-item prop="username">
                    <el-input v-model="param.username" placeholder="username">
                        <el-button slot="prepend" icon="el-icon-lx-people"></el-button>
                    </el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input
                        type="password"
                        placeholder="password"
                        v-model="param.password"
                    >
                        <el-button slot="prepend" icon="el-icon-lx-lock"></el-button>
                    </el-input>
                </el-form-item>
                <div class="login-btn">
                    <el-button type="primary" @click="submitForm()">登录</el-button>
                </div>
                <!-- <div class="login-btn2">
                    <el-button  type="primary" @click="submitForm2()">注册</el-button>
                </div> -->
                <p class="login-tips" @click="submitForm4()">忘记密码？</p>
            </el-form>

            <el-form v-if="isReg == 1" :model="param" :rules="rules" ref="reg" label-width="0px" class="ms-content">
                <el-form-item prop="username">
                    <el-input v-model="param.username" placeholder="username">
                        <el-button slot="prepend" icon="el-icon-lx-people"></el-button>
                    </el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input
                        type="password"
                        placeholder="password"
                        v-model="param.password"
                    >
                        <el-button slot="prepend" icon="el-icon-lx-lock"></el-button>
                    </el-input>
                </el-form-item>
                <div class="login-btn3">
                    <el-button type="primary" @click="submitForm3()">注册</el-button>
                </div>
            </el-form>

            <el-form v-if="isReg == 2" :model="param" :rules="ruless" ref="update" label-width="0px" class="ms-content">
                <el-form-item prop="username">
                    <el-input v-model="param.username" placeholder="账号">
                        <el-button slot="prepend" icon="el-icon-lx-people"></el-button>
                    </el-input>
                </el-form-item>
                <el-form-item prop="password">
                    <el-input
                        type="password"
                        placeholder="新密码"
                        v-model="param.password"
                    >
                        <el-button slot="prepend" icon="el-icon-lx-lock"></el-button>
                    </el-input>
                </el-form-item>
                <el-form-item prop="newPassword">
                    <el-input
                        type="password"
                        placeholder="再次输入新密码"
                        v-model="param.newPassword"
                    >
                        <el-button slot="prepend" icon="el-icon-lx-lock"></el-button>
                    </el-input>
                </el-form-item>
                <div class="login-btn4">
                    <el-button type="primary" @click="submitForm5()">提交</el-button>
                </div>
            </el-form>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    data: function() {
        return {
            param: {
                username: '',
                password: '',
                newPassword: ''
            },
            rules: {
                username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
                password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
            },
            ruless: {
                username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
                password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
                newPassword: [{ required: true, message: '请再次输入密码', trigger: 'blur' }]
            },
            isReg: 0
        };
    },
    methods: {
        submitForm() {
            this.$refs.login.validate(valid => {
                if (valid) {
                    axios({
                      method: 'POST',
                      url: 'http://localhost:3000/b_login',
                      data: {
                        account: this.param.username,
                        password: this.param.password
                      }
                    }).then((val) => {
                      if (val.data.msg == '登录成功') {
                        localStorage.setItem('boss_info', JSON.stringify(val.data.value[0]))
                        this.$message.success('登录成功');
                        this.hx_conn.registerUser({ 'username': this.param.username, 'password': this.param.username })
                          .then((res) => {
                              console.log('注册成功');
                              console.log(res);
                          })
                          .catch((e) => {
                              console.log('注册失败');
                              console.log(e);
                          });
                        this.hx_conn
                          .open({ 'user': this.param.username, 'pwd': this.param.username })
                          .then((res) => {
                              console.log('登录成功');
                              console.log(res);
                          })
                          .catch((e) => {
                              console.log('登录失败');
                              console.log(e);
                          });
                        this.$router.push('/dashboard');
                      } else {
                        this.$message.warning('账号或密码输入错误');
                      }
                      
                    })
                    
                } else {
                    this.$message.error('请输入账号和密码');
                    console.log('error submit!!');
                    return false;
                }
            });
        },
        submitForm2() {
          this.isReg = 1
        },
        submitForm3() {
          this.$refs.reg.validate(valid => {
            if (valid) {
                axios({
                  method: 'POST',
                  url: 'http://localhost:3000/b_reg',
                  data: {
                    account: this.param.username,
                    password: this.param.password
                  }
                }).then((val) => {
                  if (val.data.msg == '注册成功') {
                    this.$message.success('注册成功');
                    this.isReg = 0
                    
                  } else {
                    this.$message.warning('用户名已存在');
                  }
                  
                })
                
            } else {
                this.$message.error('请输入账号和密码');
                console.log('error submit!!');
                return false;
            }
          });
          
        },
        submitForm4() {
          this.isReg = 2
        },
        submitForm5() {
          this.$refs.update.validate(valid => {
            if (valid) {
                axios({
                  method: 'POST',
                  url: 'http://localhost:3000/hou_password',
                  data: {
                    account: this.param.username,
                    password: this.param.newPassword
                  }
                }).then((val) => {
                  if (val.data.msg == '更改成功') {
                    this.$message.success('更改密码成功');
                    this.isReg = 0
                  } else {
                    this.$message.warning('账号输入错误');
                  }
                  
                })
                
            } else {
                this.$message.error('请输入账号和密码');
                console.log('error submit!!');
                return false;
            }
          });
        },
    },
};
</script>

<style scoped>
.login-tips {
  cursor: pointer;
}
.login-btn2 button, .login-btn3 button, .login-btn4 button {
  width: 100%;
}
.login-wrap {
    position: relative;
    width: 100%;
    height: 100%;
    background-image: url(../../assets/img/login-bg.jpg);
    background-size: 100%;
}
.ms-title {
    width: 100%;
    line-height: 50px;
    text-align: center;
    font-size: 20px;
    color: #fff;
    border-bottom: 1px solid #ddd;
}
.ms-login {
    position: absolute;
    left: 50%;
    top: 50%;
    width: 350px;
    margin: -190px 0 0 -175px;
    border-radius: 5px;
    background: rgba(255, 255, 255, 0.3);
    overflow: hidden;
}
.ms-content {
    padding: 30px 30px;
}
.login-btn {
    text-align: center;
}
.login-btn button {
    width: 100%;
    height: 36px;
    margin-bottom: 10px;
}
.login-tips {
    font-size: 12px;
    line-height: 30px;
    color: #fff;
}
</style>