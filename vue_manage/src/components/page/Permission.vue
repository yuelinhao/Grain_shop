<template>
    <div class="">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-lx-copy"></i>消息中心</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <el-tabs v-model="message">
                <el-tab-pane :label="`未读消息(${unread.length})`" name="first">
                    <template v-if="message === 'first'">
                      <el-table :data="unread" :show-header="false" style="width: 100%">
                        <el-table-column>
                            <template slot-scope="scope">
                                <span class="message-title1">{{scope.row.user_from}}</span>
                                <span v-if="scope.row.user_from == user_from2" style="color: blue" class="message-title2">{{message_list2[message_list2.length-1].user_message}}</span>
                            </template>
                        </el-table-column>
                        <el-table-column prop="m_time" width="160"></el-table-column>
                        <el-table-column width="180">
                            <template slot-scope="scope">
                                <el-button size="small" @click="handleRead(scope.$index, scope.row)">标为已读</el-button>
                                <el-button type="success" size="small" @click="huifu_fn(scope.row)">查看</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                    </template>
                    <div class="handle-row">
                        <el-button @click="all_change(0, 1)">全部标为已读</el-button>
                    </div>
                </el-tab-pane>
                <el-tab-pane :label="`已读消息(${read.length})`" name="second">
                    <template v-if="message === 'second'">
                        <el-table :data="read" :show-header="false" style="width: 100%">
                            <el-table-column>
                                <template slot-scope="scope">
                                    <span class="message-title1">{{scope.row.user_from}}</span>
                                    <span style="color: red" class="message-title2">消息已读</span>
                                    <!-- <span style="color: red" class="message-title2">{{new_message_list2[new_message_list2.length-1].new_message}}</span> -->
                                </template>
                            </el-table-column>
                            <el-table-column prop="date" width="150"></el-table-column>
                            <el-table-column width="180">
                                <template slot-scope="scope">
                                    <el-button type="danger" @click="handleDel(scope.$index, scope.row)">删除</el-button>
                                    <el-button type="success" size="small" @click="huifu_fn(scope.row)">查看</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                        <div class="handle-row">
                            <el-button type="danger" @click="all_change(1, 2)">全部删除</el-button>
                        </div>
                    </template>
                </el-tab-pane>
                <el-tab-pane :label="`回收站(${recycle.length})`" name="third">
                    <template v-if="message === 'third'">
                        <el-table :data="recycle" :show-header="false" style="width: 100%">
                            <el-table-column>
                                <template slot-scope="scope">
                                    <span class="message-title1">{{scope.row.user_from}}</span>
                                    <span style="color: red" class="message-title2">消息已删除</span>
                                </template>
                            </el-table-column>
                            <el-table-column prop="date" width="150"></el-table-column>
                            <el-table-column width="120">
                                <template slot-scope="scope">
                                    <el-button type="danger" @click="handleRestore(scope.$index, scope.row)">还原</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                        <div class="handle-row">
                            <el-button type="danger" @click="all_change(2, 3)">清空回收站</el-button>
                        </div>
                    </template>
                </el-tab-pane>
            </el-tabs>
        </div>
        <div class="chat">
          <el-dialog
            :title="user_from"
            :visible.sync="dialogVisible"
            width="80%">
            <div class="chat_message" ref="message">
              <div class="one_message" v-for="(item, index) in message_list" :key="index">
                <div v-if="item.user_from == user_from">
                  <span class="touxiang"><img :src="`http://localhost:3000/img/${item.client_img}.jpg`"></span>
                  <span class="neirong">{{item.user_message}}</span>
                  <span class="shijian">{{format_time(item.m_time)}}</span>
                </div>
                <div v-if="item.user_from != user_from" class="kefu_message">
                  <span class="shijian2">{{format_time(item.m_time)}}</span>
                  <span class="neirong2">{{item.user_message}}</span>
                  <span class="touxiang"><img :src="require('@/assets/img/img.jpg')"></span>                    
                </div>
              </div>
            </div>
            <span slot="footer" class="dialog-footer">
              <el-input
                type="textarea"
                :row='100'
                placeholder="请输入内容"
                v-model="textarea">
              </el-input>
              <el-button type="success" @click="send_fn">发 送</el-button>
            </span>
          </el-dialog>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'
    export default {
        name: 'tabs',
        data() {
            return {
                textarea: '',
                dialogVisible: false,
                message: 'first',
                showHeader: false,
                message_list: [],
                message_list2: [{user_message: '有新消息'}],
                unread: [],
                read: [],
                recycle: [],
                user_from: '',
                user_from2: '',
                
            }
        },
        created() {
            this.get_mesage(0)
            this.get_mesage(1)
            this.get_mesage(2)
            
            this.hx_conn.addEventHandler("connection&message", {
            // onConnected: () => {
            //   console.log("111111")
            // },
            onTextMessage: (message) => {
              console.log("收到消息了。。。")
              console.log(message)
              this.user_from2 = message.from
              this.get_mesage(0)
              this.get_chats()
            }
          })
        },
        methods: {
               
            get_mesage(index) {
              if (index == 0) {
                axios({
                  method: 'POST',
                  url: 'http://localhost:3000/get_allChat',
                  data: {
                    m_status: 0,
                    user_to: '666666'
                  }
                }).then((val) => {
                  console.log(val);
                  this.unread = val.data.value
                })
              } else if (index == 2) {
                axios({
                  method: 'POST',
                  url: 'http://localhost:3000/get_allChat',
                  data: {
                    m_status: 2,
                    user_to: '666666'
                  }
                }).then((value) => {
                  console.log(value);
                  this.recycle = value.data.value
                })
              } else if (index == 1) {
                axios({
                  method: 'POST',
                  url: 'http://localhost:3000/get_allChat',
                  data: {
                    m_status: 1,
                    user_to: '666666'
                  }
                }).then((value) => {
                  console.log(value);
                  this.read = value.data.value
                })
              }
            },
            format_time(timestamp) {
                var date = new Date(timestamp * 1)
                var h = date.getHours() < 10 ? '0' + date.getHours() : date.getHours()
                var f = date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()
                var s = date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds()
                return h + ':' + f + ':' + s
            },
            huifu_fn(aa) {
              this.dialogVisible = true
              this.user_from = aa.user_from
              this.get_chats()
            },
            get_chats() {
              axios({
                method: 'POST',
                url: 'http://localhost:3000/get_chat',
                data: {
                  user_from: this.user_from
                }
              }).then((val) => {
                console.log(val);
                this.message_list = val.data.value
              })
            },
            send_fn() {
              let option = {
                  chatType: 'singleChat',    // 会话类型，设置为单聊。
                  type: 'txt',               // 消息类型。
                  to: this.user_from,                // 消息接收方（用户 ID)。
                  msg: this.textarea           // 消息内容。
              }
              let msg = WebIM.message.create(option); 
              this.hx_conn.send(msg).then((res) => {
                  console.log('发送成功');
                  console.log(res);
                  axios({
                    method: 'POST',
                    url: 'http://localhost:3000/save_chat',
                    data: {
                      user_from: JSON.parse(localStorage.getItem('boss_info')).user_acc,
                      user_to: this.user_from,
                      user_message: this.textarea
                    }
                  }).then(() => {
                    this.get_chats()
                    this.$message.success('发送成功');
                    
                    axios({
                      method: 'POST',
                      url: 'http://localhost:3000/change_message',
                      data: {
                        user_from: this.user_from,
                        m_status: 1
                      }
                    }).then(() => {
                      this.get_mesage(0)
                      this.get_mesage(1)
                      this.get_mesage(2)
                      this.textarea = ''
                    })
                  })
              }).catch(() => {
                  console.log('send private text fail');
              })
              
            },
            handleRead(index, aa) {
                let bb = aa.user_from
                axios({
                  method: 'POST',
                  url: 'http://localhost:3000/change_message',
                  data: {
                    user_from: bb,
                    m_status: 1
                  }
                }).then((val) => {
                  console.log(val);
                  const item = this.unread.splice(index, 1);
                  this.read = item.concat(this.read);
                })
                
            },
            handleDel(index, aa) {
                let bb = aa.user_from
                axios({
                  method: 'POST',
                  url: 'http://localhost:3000/change_message',
                  data: {
                    user_from: bb,
                    m_status: 2
                  }
                }).then((val) => {
                  console.log(val);
                  const item = this.read.splice(index, 1);
                  this.recycle = item.concat(this.recycle);
                })
                
            },
            handleRestore(index, aa) {
                let bb = aa.user_from
                axios({
                  method: 'POST',
                  url: 'http://localhost:3000/change_message',
                  data: {
                    user_from: bb,
                    m_status: 1
                  }
                })
                const item = this.recycle.splice(index, 1);
                this.read = item.concat(this.read);
            },
            all_change(aa, bb) {
              axios({
                method: 'POST',
                url: 'http://localhost:3000/change_allMessage',
                data: {
                  now_status: aa,
                  m_status: bb
                }
              }).then(() => {
                this.get_mesage(0)
                this.get_mesage(1)
                this.get_mesage(2)
              })
            }
        }
    }

</script>

<style>
  .message-title1 {
    margin-right: 20px;
  }
  .el-dialog__body {
    width: 95%;
    height: 60%;
    overflow: auto;
  }
  .el-dialog__footer {
    width: 100%;
    position: absolute;
    right: 0;
    bottom: 0;
  }
  .el-dialog {
    height: 60%;
  }
  .message-title{
      cursor: pointer;
  }
  .handle-row{
      margin-top: 30px;
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
    max-width: 300px;
    border-radius: 4px;
  }
  .one_message {
    margin-bottom: 10px;
  }
  .shijian {
    margin-left: 20px;
  }
  .shijian2 {
    margin-right: 20px;
  }
  .kefu_message {
    text-align: right;
  }
</style>

