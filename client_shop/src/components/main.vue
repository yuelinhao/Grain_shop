<template>
  <div id="app" style="font-family:Hiragino Sans GB">
    <div class="app_content">
      <router-view></router-view>
    </div>
    <div class="app_bottom">
      <navigation/>
    </div>
    <!-- <router-view></router-view> -->
    <div>
    </div>
  </div>
</template>

<script>
import navigation from './navigation.vue'
export default {
  name: "App",
  data() {
    return {
      
    }
  },
  components: {
    navigation
  },
};
</script>

<style scoped>
#app {
  width: 100vw;
  height: 100vh;
  position: relative;
  top: 0;
  left: 0;
  display: flex;
  overflow: hidden;
  flex-direction: column;
}
#app > .app_content {
  flex: 12.2;
  overflow: hidden;
}
#app > .app_bottom {
  flex: 1;
  display: flex;
  border-top: 2px solid rgba(220, 220, 220, 0.5);
  box-sizing: border-box;
}
</style>
