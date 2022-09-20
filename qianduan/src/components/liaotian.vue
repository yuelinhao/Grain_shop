<template>
  <div class="app">    
    <div class="top">
      <i class="el-icon-arrow-left" @click="fan_fn"></i>
      <span class="span1">客服</span>
      <i @click="fan_my" class="el-icon-arrow-left"></i>
    </div>
    <div class="message">
      <div class="one_message" v-for="(item, index) in message_list" :key="index">
        <div v-if="item.user_from == '666666'" class="xxxx">
          <span class="touxiang"><img :src="require('@/assets/img/img.jpg')"></span>
          <span class="neirong">{{item.user_message}}</span>
          <span class="shijian">{{format_time(item.m_time)}}</span>
        </div>
        <div v-if="item.user_from != '666666'" class="kefu_message">
          <span class="shijian2">{{format_time(item.m_time)}}</span>
          <span class="neirong2">{{item.user_message}}</span>
          <span class="touxiang"><img :src="`http://localhost:3000/img/${user_img}.jpg`"></span>                    
        </div>
      </div>
    </div>
    <div class="fasong">
      <input type="text" v-model="fasong_message" class="kuang" placeholder="请输入内容">
      <button @click="send_fn">发送</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data() {
    return {
      fasong_message: '',
      message_list: [],
      user_img: ''
    }
  },
  created() {
    this.get_message()
    axios({
      method: 'POST',
      url: 'http://localhost:3000/get_user_info',
      data: {
        user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc
      }
    }).then((val) => {
      this.user_img = val.data.value[0].user_img
    })
    axios({
      method: 'POST',
      url: 'http://localhost:3000/get_chat',
      data: {
        user_from: JSON.parse(sessionStorage.getItem('user'))[0].user_acc
      }
    }).then((val) => {
      console.log(val);
      this.message_list = val.data.value
    })
  },
  methods: {
    fan_fn(){
    console.log(111);
    this.$router.go(-1)
    },
    fan_my(){
      this.$router.push({name:'my'})
    },
    format_time(timestamp) {
        var date = new Date(timestamp * 1)
        var h = date.getHours() < 10 ? '0' + date.getHours() : date.getHours()
        var f = date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()
        var s = date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds()
        return h + ':' + f + ':' + s
    },
    send_fn() {
      let option = {
          chatType: 'singleChat',    // 会话类型，设置为单聊。
          type: 'txt',               // 消息类型。
          to: '666666',                // 消息接收方（用户 ID)。
          msg: this.fasong_message           // 消息内容。
      }
      let msg = WebIM.message.create(option); 
      this.hx_conn.send(msg).then((res) => {
          console.log('发送成功');
          console.log(res);
          axios({
                method: 'POST',
                url: 'http://localhost:3000/get_user_info',
                data: {
                  user_acc: JSON.parse(sessionStorage.getItem('user'))[0].user_acc
                }
              }).then((val) => {
                let {user_img} = val.data.value[0]
                axios({
                  method: 'POST',
                  url: 'http://localhost:3000/save_chat',
                  data: {
                    user_from: JSON.parse(sessionStorage.getItem('user'))[0].user_acc,
                    user_to: '666666',
                    user_message: this.fasong_message,
                    img_id: user_img
                  }
                }).then(() => {
                  console.log('保存成功');
                  axios({
                    method: 'POST',
                    url: 'http://localhost:3000/get_chat',
                    data: {
                      user_from: JSON.parse(sessionStorage.getItem('user'))[0].user_acc
                    }
                  }).then((val) => {
                    console.log(val);
                    this.message_list = val.data.value
                    this.fasong_message = ''
                  })
                })
              })
      }).catch(() => {
          console.log('send private text fail');
      })
    },
    get_message() {
      this.hx_conn.addEventHandler("connection&message", {
      onTextMessage: (message) => {
        console.log("收到消息了。。。")
        console.log(message)
        axios({
            method: 'POST',
            url: 'http://localhost:3000/get_chat',
            data: {
              user_from: JSON.parse(sessionStorage.getItem('user'))[0].user_acc
            }
          }).then((val) => {
            console.log(val);
            this.message_list = val.data.value
          })
      }
    })
    }
  },
}
</script>

<style scoped>
  .span1{
    position: absolute;
    top: -7px;
    left: 44px;
    font-size: 20px;
    font-weight: 600;
  }
  .xxx {
    padding-left: 2vw;
  }
  .top {
    width: 100%;
    height: 12vw;
    background: linear-gradient(58deg, #2964a0 13%, #1b375c 100%);
    text-align: center;
    line-height: 20vw;
    color: white;
    font-size: 5vw;
    margin-bottom: 2vw;
  }
  .el-icon-arrow-left {
    position: absolute;
    left: 2vw;
    top: 4vw;
    font-size: 24px;
  }
  .message {
    width: 100vw;
    height: 140vw;
    overflow: auto;
    padding: 3px;
  }
  .kuang {
    width: 70vw;
    height: 13vw;
    border: 0;
    border-radius: 2vw;
    padding: 0 15px;
    margin: 2vw;
    background-color: #eee;
    outline: 0;
  }
  button {
    width: 16vw;
    height: 10vw;
    border: 0;
    background-color:#2964a0;
    color: white;
    border-radius: 2vw;
  }
  .fasong{
    position:absolute;
    bottom: 1vw;
  }
  .touxiang {
    display: inline-block;
    width: 30px;
    height: 30px;
    border-radius: 4px;
    /* background-color: red; */
    vertical-align: top;
  }
  .touxiang img {
    width: 30px;
    height: 30px;
    border-radius: 4px;
  }
  .neirong {
    display: inline-block;
    padding: 10px;
    background-color: #eee;
    color: black;
    font-size: 16px;
    margin-left: 20px;
    max-width: 300px;
    border-radius: 4px;
  }
  .neirong2 {
    display: inline-block;
    padding: 10px;
    background-color: yellowgreen;
    color: black;
    font-size: 16px;
    margin-right: 20px;
    max-width: 213px;
    border-radius: 4px;
  }
  .one_message {
    margin-bottom: 10px;
  }
  .shijian {
    margin-left: 7px;
    font-size: 12px;
    color: rgba(0, 0, 0, .4);
  }
  .shijian2 {
    margin-right: 7px;
    font-size: 12px;
    color: rgba(0, 0, 0, .4);
  }
  .kefu_message {
    text-align: right;
    padding-right: 2vw;
  }
</style>