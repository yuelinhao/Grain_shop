<template>
    <div>
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item> <i class="el-icon-lx-calendar"></i> 表单 </el-breadcrumb-item>
                <el-breadcrumb-item>增加商品</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="form-box">
                <el-form ref="form" :model="form" label-width="80px">
                    <el-form-item label="名称">
                        <el-input v-model="form.region"></el-input>
                    </el-form-item>
                    <el-form-item label="价格">
                        <el-input v-model="form.date1"></el-input>
                    </el-form-item>
                    <el-form-item label="库存">
                        <el-input v-model="form.date2"></el-input>
                    </el-form-item>
                    <el-form-item label="重量">
                        <el-input v-model="form.desc"></el-input>
                    </el-form-item>
                    <el-form-item label="类别">
                        <el-input v-model="form.date3"></el-input>
                    </el-form-item>
                    <el-form-item label="商品图片" class="tupian">
                        <el-upload
                          class="upload-demo"
                          action=""
                          :on-change="handleChange"
                          :on-remove="handleRemove"
                          :auto-upload="false"
                          list-type="picture">
                          <el-button size="small" type="primary">点击上传</el-button>
                        </el-upload>
                    </el-form-item><br>
                    <el-form-item label="商品宣传" class="tupian">
                        <el-upload
                          multiple
                          class="upload-demo3"
                          action=""
                          :on-change="handleChange3"
                          :on-remove="handleRemove3"
                          :auto-upload="false"
                          list-type="picture">
                          <el-button size="small" type="primary">点击上传</el-button>
                        </el-upload>
                    </el-form-item><br>
                    <el-form-item label="商品详情" class="tupian">
                        <el-upload
                          class="upload-demo2"
                          action=""
                          :on-change="handleChange2"
                          :on-remove="handleRemove2"
                          :auto-upload="false"
                          list-type="picture">
                          <el-button size="small" type="primary">点击上传</el-button>
                        </el-upload>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onSubmit">表单提交</el-button>
                        <el-button>取消</el-button>
                    </el-form-item>
                </el-form>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
import VueCropper from 'vue-cropperjs';
export default {
    name: 'upload',
    data() {
        return {
            form: {
                region: '',
                date1: '',
                date2: '',
                date3: '',
                desc: '',
                type: ['步步高'],
                resource: '小天才',
                // defaultSrc: require('../../assets/img/img.jpg'),
                fileList: [],
                imgSrc: '',
                cropImg: '',
                dialogVisible: false
            },
            img_arr:[],
            img_detail:[],
            img_lunbo:[]
        };
    },
    components: {
        VueCropper
    },
    methods: {
        handleRemove(file, fileList) {
          console.log(file, fileList);
        },
        handleChange(file) {
          let arr = []
          arr.push(file.raw)
          this.img_arr = arr
        },
        handleRemove2(file, fileList) {
          console.log(file, fileList);
        },
        handleChange2(file) {
          let arr2 = []
          arr2.push(file.raw)
          this.img_detail = arr2
        },
        handleRemove3(file, fileList) {
          console.log(file, fileList);
        },
        handleChange3(file) {
          this.img_lunbo.push(file.raw)
          console.log(this.img_lunbo);
        },
        onSubmit() {
            let fd = new FormData();
            fd.append('g_name', this.form.region);
            fd.append('g_size', this.form.desc);
            fd.append('g_price', this.form.date1);
            fd.append('g_num', this.form.date2);
            fd.append('g_type', this.form.date3);
            fd.append('g_img', this.img_arr[0]);
            fd.append('g_img_xinxi', this.img_detail[0]);
            axios({
                method: 'POST',
                url: 'http://localhost:3000/add_goods',
                data: fd
            }).then((val) => {
                console.log(val);
                if (val.data.msg == '添加商品成功') {
                    // this.$router.push({ path: '/table' });
                    this.$message.success('提交成功！');

                    // this.form.region =''
                    // this.form.desc=''
                    // this.form.date1 = ''
                    // this.form.date2 =''
                    // this.form.date3= ''
                    // this.$refs.img.value =''
                } else {
                    this.$message.warning('商品已存在,请修改库存!');
                }
            });

            this.tijiao()
            
        },
        tijiao() {
          
          for (let i = 0; i < this.img_lunbo.length; i++) {
              let fs = new FormData()
              fs.append('g_name', this.form.region);
              fs.append('g_img_lun', this.img_lunbo[i])
              axios({
                method: 'POST',
                url: 'http://localhost:3000/add_goods_imgs',
                data: fs
              }).then((val) => {
                console.log(val);
              })
            }
            this.img_lunbo = []
        },
        setImage(e) {
            const file = e.target.files[0];
            if (!file.type.includes('image/')) {
                return;
            }
            const reader = new FileReader();
            reader.onload = (event) => {
                this.dialogVisible = true;
                this.imgSrc = event.target.result;
                this.$refs.cropper && this.$refs.cropper.replace(event.target.result);
            };
            reader.readAsDataURL(file);
        },
        change_fn() {
            let aa = this.$refs.img;
            var file_arr = aa.files[0];
            console.log(file_arr);
            var img_src = URL.createObjectURL(file_arr);
            var img_ele = `<img src="` + img_src + `" />`;
            this.$refs.kuai.innerHTML = img_ele;
        },
        cancelCrop() {
            this.dialogVisible = false;
            this.cropImg = this.defaultSrc;
        }
    }
};
</script>
<style>
.crop-demo {
    display: flex;
    align-items: flex-end;
}

.pre-img {
    width: 100px;
    height: 100px;
    background: #f8f8f8;
    border: 1px solid #eee;
    border-radius: 5px;
}

.crop-demo-btn {
    position: relative;
    width: 100px;
    height: 40px;
    line-height: 40px;
    padding: 0 20px;
    margin-left: 30px;
    background-color: #409eff;
    color: #fff;
    font-size: 14px;
    border-radius: 4px;
    box-sizing: border-box;
}

.crop-input {
    position: absolute;
    width: 100px;
    height: 40px;
    left: 0;
    top: 0;
    opacity: 0;
    cursor: pointer;
}
.tupian {
    display: inline-block;
}

.sss > img {
    width: 100%;
    height: 100%;
    background-position: center;
    background-size: cover;
}
</style>