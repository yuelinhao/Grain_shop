var routes = [
    {
        path: '/',
        component: () => import('../components/main.vue'),
        children: [
            {
                path: "/found",
                // 懒加载
                component: () => import("./found"),
                name: "found",
                meta: { aa: true },
                children: [
                    {
                        path: 'search',
                        component: () => import('./search'),
                        name: 'search',
                        children: [
                            {
                                path: 'goods',
                                component: () => import('./goods'),
                                name: 'goods',
                            }
                        ]
                    }
                ]
            },
            {
                path: '/',
                redirect: '/home'
            },
            {
                path: "/home",
                component: () => import("./home"),
                name: "home",
                meta: { aaa: true },
                children: [
                    {
                        path: 'search',
                        component: () => import('./search'),
                        name: 'search',
                        children: [
                            {
                                path: 'goods',
                                component: () => import('./goods'),
                                name: 'goods',
                            }
                        ]
                    },
                    // {
                    //     path:'goods',
                    //     component: ()=>import('./goods'),
                    //     name:'goods',
                    // }
                ]
            },
            {
                path: "/my",
                component: () => import("./my"),
                name: "my",
                meta: { aaa: true }
            },
            {
                path: "/shopping",
                component: () => import("./shopping"),
                name: "shopping",
                meta: { aaa: true }
            },

        ]
    },
    
    {
        path: "/tong_ji",
        component: () => import("../components/tong_ji"),
        name: "tong_ji",
        meta: { aaa: true },
        children: [
            {
                path: '/',
                redirect: 'yi'
            },
            {
                path: "yi",
                component: () => import("../components/page/yi"),
                name: "yi",
                meta: { aaa: true }
            },
            {
                path: "er",
                component: () => import("../components/page/er"),
                name: "er",
                meta: { aaa: true }
            },
            {
                path: "san",
                component: () => import("../components/page/san"),
                name: "san",
                meta: { aaa: true }
            },
            {
                path: "si",
                component: () => import("../components/page/si"),
                name: "si",
                meta: { aaa: true }
            },
        ]
    },
    {
        path: "/aa",
        component: () => import("../components/aa"),
        name: "aa",
        meta: { aaa: true }
    },

    {
        path: "/dui_zhang",
        component: () => import("../components/dui_zhang"),
        name: "dui_zhang",
        meta: { aaa: true }
    },
    {
        path: "/tui_jian",
        component: () => import("../components/tui_jian"),
        name: "tui_jian",
        meta: { aaa: true }
    },
    {
        path: '/goods_detail',
        component: () => import("./goods_detail"),
        name: 'goods_detail'
    },
    {
        path: '/safe',
        component: () => import('../components/safe'),
        name: 'safe'
    },
    {
        path: '/msg',
        component: () => import('../components/msg'),
        name: 'msg'
    },
    {
        path: '/jie',
        component: () => import('../components/jiesuan'),
        name: 'jie'
    },
    {
        path: '/my_msg',
        component: () => import('./my_msg'),
        name: 'my_msg'
    },
    {
        path: '/detail_addres',
        component: () => import('./detail_addres'),
        name: 'detail_addres'
    },
    {
        path: '/balance',
        component: () => import('./balance'),
        name: 'balance'
    },
    {
        path: '/chongzhi',
        component: () => import('./chongzhi'),
        name: 'chongzhi'
    },
    {
        path: '/collection',
        component: () => import('./collection'),
        name: 'collection'
    },
    {
        path:'/pwd',
        component: ()=> import('../components/pwd'),
        name:'pwd'
    },
    {
        path:'/login',
        component: ()=>import('./login'),
        name:'login'
    },
    {
        path:'/register',
        component: ()=>import('./register'),
        name:'register'
    },
    {    
        path: '/liaotian',
        component: () => import('../components/liaotian.vue'),
        name:'liaotian'
    },
    {
        path:'/add_address',
        component: ()=> import('./add_address.vue'),
        name:'add_address'
    },
    {
        path: '/lock_account',
        component: () => import('../components/lock_account'),
        name: 'lock_account'

    },
    {
        path: '/jiesuan',
        component: () => import('../components/jiesuan'),
        name: 'jiesuan'
    },

]

export default routes
