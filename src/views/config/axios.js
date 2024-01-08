import axios from "axios";

// if判断生产环境和开发环境
if (process.env.NODE_ENV === "production") {
  // if，根据.env文件中的process.env.VUE_APP_BASE_URL判断是生产环境还是测试环境
  if (process.env.VUE_APP_BASE_URL === "build") {
    //production 生产环境
    axios.defaults.baseURL = "http://127.0.0.1:5000/";
  } else {
    //test 测试环境
    axios.defaults.baseURL = "http://127.0.0.1:5000/";
  }
} else {
  //serve 开发环境
  axios.defaults.baseURL = "http://127.0.0.1:5000/";
}
