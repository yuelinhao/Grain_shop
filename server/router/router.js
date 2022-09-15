
var mysql = require('mysql');
var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'admin123',
  database: 'vue_shop'
});

connection.connect();

const Router = require('koa-router');
const fs = require('fs')
const jwt = require("jsonwebtoken")
const router = new Router();
const crypto = require('crypto')

// 后台注册
router.post('/b_reg', async (ctx, next) => {
  let id = +new Date()
  let account = ctx.request.body.account
  let password = ctx.request.body.password
  ctx.body = await new Promise((resolve, reject) => {
    let sql = `select * from b_user where user_acc='${account}'`
    connection.query(sql, function (error, results, fields) {
      if (results.length > 0) {
        let bb = {
          msg: '用户名已存在'
        }
        resolve(bb)
      } else {
        let sql_str = `insert into b_user (user_id, user_acc, user_pw) values ('${id}', '${account}', '${password}')`
        connection.query(sql_str, function (error, results, fields) {
          if (error) {
            throw error
          } else {
            let aa = {
              msg: '注册成功'
              // value: results
            }
            resolve(aa)
          }
        })
      }
    })



  })
})

// 后台登录
router.post('/b_login', async (ctx, next) => {
  let account = ctx.request.body.account
  let password = ctx.request.body.password
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from b_user where user_acc='${account}' and user_pw='${password}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        if (results.length > 0) {
          let token = jwt.sign(
            { name: account },
            "yue",
            { expiresIn: 50 }
          )
          let aa = {
            msg: '登录成功',
            value: results,
            data: token
          }
          resolve(aa)
        } else {
          let aa = {
            msg: '账号或密码输入错误'
          }
          resolve(aa)
        }

      }
    })
  })
})

// 后台忘记密码
router.post('/hou_password', async (ctx, next) => {
  let { account, password } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update b_user set user_pw='${password}' where user_acc='${account}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '更改成功'
        })
      }
    })
  })
})

// 前台注册
router.post('/f_reg', async (ctx, next) => {
  let id = +new Date()
  let account = ctx.request.body.account
  let password = ctx.request.body.password
  ctx.body = await new Promise((resolve, reject) => {
    let sql = `select * from f_user where user_acc='${account}'`
    connection.query(sql, function(error, results, fields) {
      if (results.length > 0) {
        let bb = {
          msg: '用户名已存在'
        }
        resolve(bb)
      } else {
        let hasher = crypto.createHash("md5")
        let hashmsg = hasher.update(password).digest('yue')
        let hashmsg2 = hashmsg.toString()
        let sql_str = `insert into f_user (user_id, user_acc, user_pw) values ('${id}', '${account}', '${hashmsg2}')`
        connection.query(sql_str, function (error, results, fields) {
          if (error) {
            throw error
          } else {
            let sql_str2 = `insert into f_user_info (user_acc) values ('${account}')`
            connection.query(sql_str2, function(error, results, reject) {
              if (error) throw error
            })
            let aa = {
              msg: '注册成功'
              // value: results
            }
            resolve(aa)
          }
        })
      }
    })


    
  })
})

// 前台登录
router.post('/f_login', async (ctx, next) => {
  let account = ctx.request.body.account
  let password = ctx.request.body.password
  let hasher = crypto.createHash("md5")
  let hashmsg = hasher.update(password).digest('yue')
  let hashmsg2 = hashmsg.toString()
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from f_user where user_acc='${account}' and user_pw='${hashmsg2}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        if (results.length > 0) {
          let token = jwt.sign(
            { name: account },
            "yue",
            { expiresIn: 50 }
          )
          let aa = {
            msg: '登录成功',
            value: results,
            data: token
          }
          resolve(aa)
        } else {
          let aa = {
            msg: '账号或密码输入错误'
          }
          resolve(aa)
        }
        
      }
    })
  })
})

// 忘记密码
router.post('/re_password', async (ctx, next) => {
  let {account, password} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update f_user set user_pw='${password}' where user_acc='${account}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '更改成功'
        })
      }
    })
  })
})

//获取所有商品信息
router.get('/all_goods', async (ctx, next) => {
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from goods`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          value: results
        })
      }
    })
  })
})

// 添加商品
router.post('/add_goods', async (ctx, next) => {
  let {g_name, g_size, g_price, g_num, g_type} = ctx.request.body
  let g_img = ctx.request.files.g_img
  let g_img_xinxi = ctx.request.files.g_img_xinxi
  let img_id = new Date().getTime()
  let r = fs.createReadStream(g_img.filepath)
  let m = fs.createWriteStream('./static/img/' + img_id + '.jpg')
  r.pipe(m)
  let a = fs.createReadStream(g_img_xinxi.filepath)
  let b = fs.createWriteStream('./static/g_imgs_xinxi/' + img_id + '.jpg')
  a.pipe(b)
  // let n = new Date().getFullYear()

  let r1 = new Date().getDay()
  let h = new Date().getHours()
  let h1 = h < 10 ? '0' + h : h
  let f = new Date().getMinutes()
  let f1 = f < 10 ? '0' + f : f
  let s = new Date().getSeconds()
  let s1 = s < 10 ? '0' + s : s

  let g_bianhao = r1 + h1 + f1 + s1

  ctx.body = await new Promise((resolve, reject) => {
    let sql = `select * from goods where g_name='${g_name}'`
    connection.query(sql, function(error, results, fields) {
      if (error) {
        throw error
      } else {
        if (results.length > 0) {
          resolve({
            msg: '该商品已存在'
          })
        } else {
          let sql_str = `insert into goods (g_name, g_price, g_num, g_img, g_bianhao, g_type, g_size, g_img_xinxi) values ('${g_name}', '${g_price}', ${g_num}, '${img_id}', '${g_bianhao}', '${g_type}', '${g_size}', '${img_id}')`
          connection.query(sql_str, function (error, results, fields) {
            if (error) {
              throw error
            } else {
              resolve({
                msg: '添加商品成功'
              })
            }
          })
        }
      }
    })
    
  })
})

// 添加商品宣传图片
router.post('/add_goods_imgs', async (ctx, next) => {
  let {g_name} = ctx.request.body
  let g_img_lun = ctx.request.files.g_img_lun
  let img_id = new Date().getTime()
  let r = fs.createReadStream(g_img_lun.filepath)
  let m = fs.createWriteStream('./static/goods_imgs/' + img_id + '.jpg')
  r.pipe(m)

  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `insert into goods_imgs (g_name, g_img_lun) values ('${g_name}','${img_id}')`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '添加成功'
        })
      }
    })
  })
})

//修改商品信息
router.post('/m_goods', async (ctx, next) => {
  let {g_price, g_num, g_bianhao} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update goods set g_price=${g_price}, g_num=${g_num} where g_bianhao='${g_bianhao}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '修改成功'
        })
      }
    })
  })

})

//删除商品 将商品编号包装成数组传递
router.post('/re_goods', async (ctx, next) => {
  let {g_bianhao_arr} = ctx.request.body
  let arr = JSON.parse(g_bianhao_arr)
  let arr2 = arr.join(',')
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `delete from goods where g_bianhao in (${arr2})`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '删除成功'
        })
      }
    })
  })
})

//根据商品名查询
router.post('/s_goods_name', async (ctx, next) => {
  let {g_type} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from goods where g_name='${g_type}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 获取商品详情页轮播图图片
router.post('/get_imgs_lunbo', async (ctx, next) => {
  let { g_name } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from goods_imgs where g_name='${g_name}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 根据商品类别进行查询
router.post('/s_goods_type', async (ctx, next) => {
  let {g_type} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from goods where g_type='${g_type}' order by g_sell desc`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 添加搜索历史记录
router.post('/add_history', async (ctx, next) => {
  let {user_acc, search_info} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql = `select search_history.history from search_history where search_history.user_acc='${user_acc}' and search_history.history='${search_info}'`
    connection.query(sql, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        if (results.length == 0) {
          let sql_str = `insert into search_history (user_acc,history) values ('${user_acc}','${search_info}')`
          connection.query(sql_str, function (error, results, fields) {
            if (error) {
              throw error
            } else {
              resolve({
                msg: '添加成功'
              })
            }
          })
        }
      }
    })
    
  })
})

// 获取历史搜素记录
router.post('/get_history', async(ctx,next)=> {
  let {user_acc} = ctx.request.body
  ctx.body = await new Promise((resolve,reject)=> {
    let sql_str =`select history from search_history where user_acc = '${user_acc}'`
    connection.query(sql_str,(error,results,fileds)=> {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '搜索成功',
          value: results
        })
      }
    }) 
  })
})

// 删除搜索历史记录
router.post('/delete_history', async (ctx, next) => {
  let {user_acc} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `delete from search_history where user_acc='${user_acc}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '删除成功'
        })
      }
    })
  })
})

// 获取商品重量
router.get('/all_size', async (ctx, next) => {
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select goods.g_size from goods`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 获取商品类别
router.get('/all_type', async (ctx, next) => {
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select goods.g_type from goods`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 根据商品重量进行查询 0升序 1降序
router.post('/s_goods_sort', async (ctx, next) => {
  let { num } = ctx.request.body
  if (num == 0) {
    ctx.body = await new Promise((resolve, reject) => {
      let sql_str = `select * from goods order by g_size*1 asc`
      connection.query(sql_str, function (error, results, fields) {
        if (error) {
          throw error
        } else {
          resolve({
            msg: '查询成功',
            value: results
          })
        }
      })
    })
  } else {
    ctx.body = await new Promise((resolve, reject) => {
      let sql_str = `select * from goods order by g_size*1 desc`
      connection.query(sql_str, function (error, results, fields) {
        if (error) {
          throw error
        } else {
          resolve({
            msg: '查询成功',
            value: results
          })
        }
      })
    })
  }
})

// 根据商品价格进行排序 0升序 1降序
router.post('/sort_goods', async (ctx, next) => {
  let {num} = ctx.request.body
  if (num == 0) {
    ctx.body = await new Promise((resolve, reject) => {
      let sql_str = `select * from goods order by g_price asc`
      connection.query(sql_str, function (error, results, fields) {
        if (error) {
          throw error
        } else {
          resolve({
            msg: '查询成功',
            value: results
          })
        }
      })
    })
  } else {
    ctx.body = await new Promise((resolve, reject) => {
      let sql_str = `select * from goods order by g_price desc`
      connection.query(sql_str, function (error, results, fields) {
        if (error) {
          throw error
        } else {
          resolve({
            msg: '查询成功',
            value: results
          })
        }
      })
    })
  }
  
})

// 获取热销产品
router.get('/hot_goods', async (ctx, next) => {
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from goods where g_sell > 0 order by g_sell desc`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '获取成功',
          value: results
        })
      }
    })
  })
})

// 获取新品
router.get('/new_goods', async (ctx, next) => {
  let aa = new Date().getTime()
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from goods where (${aa} - g_img*1) < 1886400000 order by g_sell desc`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '获取成功',
          value: results
        })
      }
    })
  })
})


// 订单状态 0待付款  1待发货  2已发货  3已收货

// 添加地址
router.post('/add_address', async (ctx, next) => {
  let { user_acc, user_address, address_id, more_address, user_name, user_phone } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `insert into user_address (user_acc,user_ress,address_id,more_address,user_name2,user_phone3) values ('${user_acc}','${user_address}','${address_id}','${more_address}','${user_name}','${user_phone}')`
    connection.query(sql_str, function(error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '添加成功'
        })
      }
    })
  })
})

// 获取地址
router.post('/get_address', async (ctx, next) => {
  let { user_acc } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from user_address where user_acc='${user_acc}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '添加成功',
          value: results
        })
      }
    })
  })
})

// 修改地址
router.post('/re_address', async (ctx, next) => {
  let { user_acc, user_address, address_id, more_address, user_name, user_phone } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update user_address set user_ress='${user_address}',more_address='${more_address}',user_name='${user_name}',user_phone='${user_phone}' where user_acc='${user_acc}' and address_id=${address_id}`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '修改成功'
        })
      }
    })
  })
})

// 改为默认
router.post('/moren_address', async (ctx, next) => {
  let { user_acc, address_id } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update user_address set status=1 where user_acc='${user_acc}' and address_id='${address_id}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '修改成功'
        })
      }
    })
  })
})



// 删除地址
router.post('/delete_address', async (ctx, next) => {
  let { user_acc, address_id } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `delete from user_address where user_acc='${user_acc}' and address_id=${address_id}`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '删除成功'
        })
      }
    })
  })
})

// 获取用户姓名 电话  地址
router.post('/get_info', async (ctx, next) => {
  let {user_acc} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select f_user_info.user_name,f_user_info.user_phone,f_user_info.user_address from f_user_info where f_user_info.user_acc='${user_acc}'`
    connection.query(sql_str, function(error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '获取成功',
          value: results
        })
      }
    })
  })
})

// 创建待付款订单 g_arr:[{g_name: '', g_number: }, {g_name: '', g_number: }]
router.post('/o_wait_pay', async (ctx, next) => {
  let { o_id, g_arr, o_price, u_name, u_phone, u_address, user_acc, g_sum } = ctx.request.body
  let g_list = JSON.parse(g_arr)
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `insert into f_order (o_id, o_time, o_price, u_name, u_phone, u_address, user_acc, g_sum, o_status) values ('${o_id}', '${o_id}', ${o_price}, '${u_name}', '${u_phone}', '${u_address}', '${user_acc}', '${g_sum}', '0')`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        for (let i = 0; i < g_list.length; i++) {
          let sql = `insert into order_detail (o_id, g_name, g_number) values ('${o_id}', '${g_list[i].g_name}', ${g_list[i].g_number})`
          connection.query(sql, function (error, results, fields) {
            if (error) throw error
          })
        }
        resolve({
          msg: '创建成功'
        })
      }
    })
  })
})

// 创建待发货订单 1 g_arr:[{g_name: '', g_number: }, {g_name: '', g_number: }]
router.post('/o_pay', async (ctx, next) => {
  let {o_id, o_status, g_arr, user_acc, o_price} = ctx.request.body
  let g_list = JSON.parse(g_arr)
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update f_order set o_status='${o_status}' where o_id='${o_id}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        for (let i = 0; i < g_list.length; i++) {
          let sql = `update goods set g_sell=(g_sell + ${g_list[i].g_number}) where g_name='${g_list[i].g_name}'`
          connection.query(sql, function (error, results, fields) {
            if (error) throw error
          })
        }
        let sql_str2 = `update f_user_info set user_money = (user_money - ${o_price}),user_integral=(user_integral + ${o_price}) where user_acc = '${user_acc}'`
        connection.query(sql_str2, function (error, results, fields) {
          if (error) throw error
        })
        let sql_str3 = `select f_user_info.user_money from f_user_info where f_user_info.user_acc='${user_acc}'`
        connection.query(sql_str3, function (error, results, fields) {
          if (error) {
            throw error
          } else {
            let aa = JSON.parse(JSON.stringify(results[0]))
            let sql_str4 = `update f_order set user_balance=${aa.user_money} where f_order.o_id='${o_id}'`
            connection.query(sql_str4, function (error, results, fields) {
              if (error) throw error
            })
          }
        })
        resolve({
          msg: '创建成功'
        })
      }
    })
    
  })
})

// 更改订单状态为已发货 2
router.post('/o_shipped', async (ctx, next) => {
  let {o_id, o_status} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update f_order set o_status='${o_status}' where o_id='${o_id}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
          resolve({
            msg: '已发货'
          })
      }
    })

  })
})

// 更改订单状态为已收货 3
router.post('/o_received', async (ctx, next) => {
  let {o_id, o_status} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update f_order set o_status='${o_status}' where o_id='${o_id}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
          resolve({
            msg: '已收货'
          })
      }
    })

  })
})

// 删除订单 将订单编号包装成数组传递
router.post('/o_delete', async (ctx, next) => {
  let { o_id_arr } = ctx.request.body
  let o_id_arr1 = o_id_arr.replaceAll('"', '\'')
  let o_id_arr2 = o_id_arr1.replace('[', '')
  let o_id_arr3 = o_id_arr2.replace(']', '')
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `delete a,b from f_order a join order_detail b on a.o_id=b.o_id where a.o_id in (${o_id_arr3})`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '删除成功'
        })
      }
    })

  })
})

//前台 查询订单 接收o_status
router.post('/o_select', async (ctx, next) => {
  let { o_status, user_acc } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select f_order.o_id,f_order.o_price,f_order.o_status,goods.g_name,goods.g_size,goods.g_img,goods.g_type,goods.g_price,order_detail.g_number from f_order,order_detail,goods where f_order.o_status='${o_status}' and f_order.o_id=order_detail.o_id and order_detail.g_name=goods.g_name and f_order.user_acc='${user_acc}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })

  })
})

//前台 查询全部订单
router.post('/o_selectAll', async (ctx, next) => {
  let {user_acc} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select f_order.o_id,f_order.o_price,f_order.o_status,goods.g_name,goods.g_size,goods.g_img,goods.g_type,goods.g_price,order_detail.g_number from f_order,order_detail,goods where f_order.o_id=order_detail.o_id and order_detail.g_name=goods.g_name and f_order.user_acc='${user_acc}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })

  })
})

// 后台 查询全部订单
router.get('/o_selectAll_b', async (ctx, next) => {
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from f_order`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })

  })
})

// 后台 根据订单编号查询订单
router.post('/o_select_id', async (ctx, next) => {
  let {o_id} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from f_order where o_id='${o_id}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })

  })
})

// 完善个人信息
router.post('/user_info', async (ctx, next) => {
  let {user_acc, user_name, user_phone, user_sex, user_address_name, user_phone2, user_ress2, more_address2} = ctx.request.body
  let user_img = ctx.request.files.user_img
  if (user_img) {
    let img_id = new Date().getTime()
    let r = fs.createReadStream(user_img.filepath)
    let m = fs.createWriteStream('./static/img/' + img_id + '.jpg')
    r.pipe(m)
    ctx.body = await new Promise((resolve, reject) => {
      let sql_str = `update f_user_info set user_img='${img_id}',user_ress2='${user_ress2}',more_address2='${more_address2}',user_name='${user_name}',user_phone='${user_phone}',user_sex='${user_sex}',user_address_name='${user_address_name}',user_phone2='${user_phone2}' where user_acc='${user_acc}'`
      connection.query(sql_str, function (error, results, fields) {
        if (error) {
          throw error
        } else {
          resolve({
            msg: '提交成功'
          })
        }
      })
    })
  } else {
    ctx.body = await new Promise((resolve, reject) => {
      let sql_str = `update f_user_info set user_ress2='${user_ress2}',more_address2='${more_address2}',user_name='${user_name}',user_phone='${user_phone}',user_sex='${user_sex}',user_address_name='${user_address_name}',user_phone2='${user_phone2}' where user_acc='${user_acc}'`
      connection.query(sql_str, function (error, results, fields) {
        if (error) {
          throw error
        } else {
          resolve({
            msg: '提交成功'
          })
        }
      })
    })
  }
  
})

// 获取所有用户信息
router.get('/getAll_user_info', async (ctx, next) => {
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from f_user_info`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '获取成功',
          value: results
        })
      }
    })
  })
})

// 获取个人信息
router.post('/get_user_info', async (ctx, next) => {
  let {user_acc} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select f_user_info.*,user_address.user_ress,user_address.more_address,user_address.user_name2,user_address.user_phone3 from f_user_info,user_address where f_user_info.user_acc='${user_acc}' and f_user_info.user_acc=user_address.user_acc`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '获取成功',
          value: results
        })
      }
    })
  })
})

// 获取个人信息 切换地址
router.post('/get_user_info2', async (ctx, next) => {
  let {user_acc,user_name} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select f_user_info.*,user_address.user_ress,user_address.more_address,user_address.user_name2,user_address.user_phone3 from f_user_info,user_address where f_user_info.user_acc='${user_acc}' and f_user_info.user_acc=user_address.user_acc and user_address.user_name2='${user_name}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '获取成功',
          value: results
        })
      }
    })
  })
})

// 后台根据用户名进行查询
router.post('/select_user', async (ctx, next) => {
  let {user_name} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from f_user_info where user_name='${user_name}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 删除用户 将用户账号包装成数组传递
router.post('/user_delete', async (ctx, next) => {
  let { user_acc_arr } = ctx.request.body
  let user_acc_arr1 = user_acc_arr.replaceAll('"', '\'')
  let user_acc_arr2 = user_acc_arr1.replace('[', '')
  let user_acc_arr3 = user_acc_arr2.replace(']', '')
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `delete a,b from f_user a join f_user_info b on a.user_acc=b.user_acc where a.user_acc in (${user_acc_arr3})`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '删除成功'
        })
      }
    })

  })
})

// 充值
router.post('/f_money', async (ctx, next) => {
  let {user_acc, user_money} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update f_user_info set user_money = (user_money + ${user_money}) where user_acc = '${user_acc}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '充值成功'
        })
      }
    })

  })
})
// 付钱
router.post('/pay_money', async (ctx, next) => {
  let {user_acc, user_money} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update f_user_info set user_money = (user_money - ${user_money}) where user_acc = '${user_acc}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '支付成功'
        })
      }
    })

  })
})

// 加入购物车
router.post('/add_shop_car', async (ctx, next) => {
  let {user_acc, g_name, g_number} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql = `select * from shop_car where user_acc='${user_acc}' and g_name='${g_name}'`
    connection.query(sql, function (error, results, fileds) {
      if (results.length > 0) {
        let sql_str2 = `update shop_car set g_number=(g_number+${g_number}) where user_acc='${user_acc}' and g_name='${g_name}'`
        connection.query(sql_str2, function (error, results, fileds) {
          if (error) {
            throw error
          } else {
            resolve({
              msg: '加入购物车成功'
            })
          }
        })
      } else {
        let sql_str = `insert into shop_car (user_acc, g_name, g_number) values ('${user_acc}', '${g_name}', ${g_number})`
        connection.query(sql_str, function (error, results, fields) {
          if (error) {
            throw error
          } else {
            resolve({
              msg: '加入购物车成功'
            })
          }
        })
      }
    })
    

  })
})

// 获取购物车信息
router.post('/get_shop_car', async (ctx, next) => {
  let {user_acc} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select shop_car.g_name,shop_car.g_number,goods.g_size,goods.g_img,goods.g_price from shop_car,goods where shop_car.g_name=goods.g_name and shop_car.user_acc='${user_acc}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '获取成功',
          value: results
        })
      }
    })

  })

})

// 删除购物车信息 将购物车中商品名包装成数组传递
router.post('/delete_shop_car', async (ctx, next) => {
  let { g_name_arr, user_acc } = ctx.request.body
  let g_name_list = g_name_arr.replaceAll('"', '\'')
  let g_name_list2 = g_name_list.replace('[', '')
  let g_name_list3 = g_name_list2.replace(']', '')
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `delete from shop_car where g_name in (${g_name_list3}) and user_acc='${user_acc}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '删除成功'
        })
      }
    })

  })
})

// 修改购物车信息
router.post('/re_shop_car', async (ctx, next) => {
  let {user_acc, g_name, g_number} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update shop_car set g_number=${g_number} where g_name='${g_name}' and user_acc='${user_acc}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '修改成功'
        })
      }
    })

  })
})

// 账单
router.post('/get_bill', async (ctx, next) => {
  let {user_acc} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select f_order.o_id,f_order.g_sum,f_order.o_price,f_order.user_balance from f_order where f_order.user_acc='${user_acc}' and o_status<>'0'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })

  })
})

// 添加收藏
router.post('/add_collect', async (ctx, next) => {
  let {user_acc, g_name} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `insert into g_collects (user_acc, g_name) values ('${user_acc}', '${g_name}')`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        let sql = `update goods set isCollect=1 where g_name='${g_name}'`
        connection.query(sql, function (error, results, fields) {
          if (error) throw error
        })
        let sql_str2 = `update f_user_info set user_collect=(user_collect+1) where user_acc='${user_acc}'`
        connection.query(sql_str2, function (error, results, fields) {
          if (error) throw error
        })
        resolve({
          msg: '添加成功'
        })
      }
    })

  })
})

// 取消收藏
router.post('/cancel_collect', async (ctx, next) => {
  let { user_acc, g_name } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `delete from g_collects where g_name='${g_name}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        let sql = `update goods set isCollect=0 where g_name='${g_name}'`
        connection.query(sql, function (error, results, fields) {
          if (error) throw error
        })
        let sql_str2 = `update f_user_info set user_collect=(user_collect-1) where user_acc='${user_acc}'`
        connection.query(sql_str2, function (error, results, fields) {
          if (error) throw error
        })
        resolve({
          msg: '取消成功'
        })
      }
    })

  })
})
//获取收藏
router.post('/get_collect',async (ctx,next)=> {
  let {user_acc} = ctx.request.body
  ctx.body = await new Promise((resolve,reject)=> {
    let sql = `select goods.* from g_collects,goods where g_collects.user_acc='${user_acc}' and g_collects.g_name=goods.g_name`
    connection.query(sql,(error,results,fields)=> {
      if(error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
    
  }) 
})

// 订单统计

// 已开票 
router.post('/get_all_bill', async (ctx, next) => {
  let {user_acc} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select f_order.o_time,f_order.o_status,f_order.g_sum,f_order.o_price from f_order where user_acc='${user_acc}'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 已开票按物品
router.post('/get_all_bill_goods', async (ctx, next) => {
  let { user_acc } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select goods.g_bianhao,goods.g_name,goods.g_price,order_detail.g_number,f_order.o_status from f_order,goods,order_detail where f_order.user_acc='${user_acc}' and f_order.o_id=order_detail.o_id and order_detail.g_name=goods.g_name`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 订单
router.post('/get_all_order', async (ctx, next) => {
  let { user_acc } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select f_order.o_time,f_order.o_id,f_order.o_price,f_order.o_status from f_order where user_acc='${user_acc}' and o_status<>'0'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 订单按物品 
router.post('/get_all_order_goods', async (ctx, next) => {
  let { user_acc } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select goods.g_bianhao,goods.g_name,goods.g_price,order_detail.g_number,f_order.o_status from f_order,goods,order_detail where f_order.user_acc='${user_acc}' and f_order.o_id=order_detail.o_id and order_detail.g_name=goods.g_name and f_order.o_status<>'0'`
    connection.query(sql_str, function (error, results, fields) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 客服聊天

// 保存聊天记录
router.post('/save_chat', async (ctx, next) => {
  let {user_from, user_to, user_message, img_id} = ctx.request.body
  let m_time = new Date().getTime()
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `insert into client_messages (user_from, user_to, user_message, m_time, client_img) values ('${user_from}', '${user_to}', '${user_message}', '${m_time}', '${img_id}')`
    connection.query(sql_str, function (error, results, fileds) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '保存成功'
        })
      }
    })
  })
})

// 获取聊天记录 点击查看
router.post('/get_chat', async (ctx, next) => {
  let {user_from} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from client_messages where user_from='${user_from}' or user_to = '${user_from}'`
    connection.query(sql_str, function (error, results, fileds) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '获取成功',
          value: results
        })
      }
    })
  })
})

// 获取所有记录 0 未读  1 已读  2 回收站
router.post('/get_allChat', async (ctx, next) => {
  let {m_status, user_to} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select distinct client_messages.user_from from client_messages where m_status=${m_status} and user_to='${user_to}'`
    connection.query(sql_str, function (error, results, fileds) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '获取成功',
          value: results
        })
      }
    })
  })
})

// 改变消息记录状态 0 未读  1 已读  2 回收站 3 清空回收站
router.post('/change_message', async (ctx, next) => {
  let {user_from, m_status} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update client_messages set m_status=${m_status} where user_from='${user_from}'`
    connection.query(sql_str, function(error, results, fileds) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '成功'
        })
      }
    })
  })
})

// 改变全部消息记录
router.post('/change_allMessage', async (ctx, next) => {
  let { m_status, now_status } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `update client_messages set m_status=${m_status} where m_status=${now_status}`
    connection.query(sql_str, function (error, results, fileds) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '成功'
        })
      }
    })
  })
})

// 添加最新消息
router.post('/add_new_message', async (ctx, next) => {
  let {user_from, user_to, new_message} = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `insert into new_messages (user_from,user_to,new_message) values ('${user_from}','${user_to}','${new_message}')`
    connection.query(sql_str, function (error, results, fileds) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '添加成功'
        })
      }
    })
  })
})

// 查询最新消息
router.post('/select_new_message', async (ctx, next) => {
  let { user_from } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select new_messages.new_message from new_messages where user_from='${user_from}'`
    connection.query(sql_str, function (error, results, fileds) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})
router.post('/select_new_message2', async (ctx, next) => {
  let { user_from, user_to } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select new_messages.new_message from new_messages where user_from='${user_from}' and user_to='${user_to}'`
    connection.query(sql_str, function (error, results, fileds) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '查询成功',
          value: results
        })
      }
    })
  })
})

// 判断支付密码
router.post('/pay_password', async (ctx, next) => {
  let { user_acc, user_pay_pw } = ctx.request.body
  ctx.body = await new Promise((resolve, reject) => {
    let sql_str = `select * from pay_pw where user_acc='${user_acc}' and user_pay_pw='${user_pay_pw}'`
    connection.query(sql_str, function (error, results, fileds) {
      if (error) {
        throw error
      } else {
        resolve({
          msg: '密码正确',
          value: results
        })
      }
    })
  })
})

export {
  router
}