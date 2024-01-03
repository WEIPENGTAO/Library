import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import axios from "axios";

const app = createApp(App);

//Element Plus
import ElementPlus from "element-plus";
import "element-plus/theme-chalk/index.css";
import zhCn from "element-plus/es/locale/lang/zh-cn";

axios.defaults.baseURL = "http://127.0.0.1:5000";
Vue.prototype.$ajax = axios;
app.use(ElementPlus, { locale: zhCn });

app.use(store).use(router).use(axios).mount("#app");
