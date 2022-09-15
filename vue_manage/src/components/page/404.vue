<!-- <template>
	<div v-if="isShow" class="sub-wrapper">
      <PieChart :chartData="list" />
  	</div>
</template>
<script>
export default{
	data(){
		return{
			isShow: true,
		}
	},
	methods: {
		reload () {//局部刷新
			this.isShow = false;
			this.$nextTick(() => {
				this.isShow = true
			})
		},
	}
}
</script> -->
