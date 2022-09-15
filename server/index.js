
const Koa = require('koa');
const app = new Koa();
const koajwt = require("koa-jwt")
var cors = require('koa-cors');
app.use(cors())
const koaBody = require('koa-body');
app.use(koaBody(
  {
    multipart: true,
    formidable: {
      maxFileSize: 1024 * 1024 * 2000
    }
  }
));
const serve = require('koa-static');
app.use(serve(__dirname + '/static'));

// Custom 401 handling if you don't want to expose koa-jwt errors to users
// app.use(function (ctx, next) {
//   return next().catch((err) => {
//     if (401 == err.status) {
//       ctx.status = 401;
//       ctx.body = 'Protected resource, use Authorization header to get access\n';
//     } else {
//       throw err;
//     }
//   });
// });

// app.use(
//   koajwt({ secret: "yue" })
//     .unless({
//       path: [/\/f_login/, /\/f_reg/, /\/b_login/, /\/b_reg/]
//     }
// ));


import {router} from './router/router'


app
  .use(router.routes())
  .use(router.allowedMethods());

app.listen(3000, () => {
  console.log('server is runing on 3000 port....');
});