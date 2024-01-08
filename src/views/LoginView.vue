<template>
  <!--  窗体代码  -->
  <div class="login">
    <el-container>
      <el-main>
        <!--  登录表单窗体  -->
        <el-row class="login-form">
          <!--  登陆表单左面板 -->
          <el-col :span="12" class="login-form-left">
            <p>图书管理系统</p>
            <p>管理员页面</p>
          </el-col>
          <!--  登陆表单右面板 -->
          <el-col :span="12" class="login-form-right">
            <!--  登录表单  -->
            <el-form
              ref="loginFormRef"
              :model="loginForm"
              :rules="loginRules"
              @keyup.enter="login(loginFormRef)"
            >
              <el-form-item>
                <p>图书管理系统-登录</p>
              </el-form-item>
              <el-form-item prop="email">
                <el-input
                  v-model="loginForm.email"
                  placeholder="用户名"
                ></el-input>
              </el-form-item>
              <el-form-item prop="password">
                <el-input
                  type="password"
                  v-model="loginForm.password"
                  placeholder="密码"
                ></el-input>
              </el-form-item>
              <el-form-item>
                <el-button
                  type="primary"
                  @click="login(loginFormRef)"
                  ref="loginButtonRef"
                  :disabled="loginState"
                  >登录</el-button
                >
              </el-form-item>
              <el-form-item>
                <el-button
                  type="primary"
                  @click="addFromButton(addUserFormRef)"
                  ref="loginButtonRef"
                  :disabled="loginState"
                  >注册</el-button
                >
              </el-form-item>
            </el-form>
          </el-col>
        </el-row>
        <!--添加用户表单 -->
        <el-dialog
          v-model="addUserFormVisible"
          title="添加用户"
          class="add-user-dialog"
          width="500px"
          :close-on-click-modal="false"
        >
          <el-form
            :model="addUserForm"
            :rules="userRules"
            ref="addUserFormRef"
            class="add-user-form"
          >
            <!-- <el-form-item
              label="所属组"
              :label-width="formLabelWidth"
              prop="groups"
            >
              <el-select
                v-model="addUserForm.groups"
                placeholder="请选择所属组"
              >
                <el-option
                  v-for="item in UserType"
                  :key="item.typeId"
                  :label="item.label"
                  :value="item.typeName"
                >
                </el-option>
              </el-select>
            </el-form-item> -->
            <el-form-item
              label="姓名"
              :label-width="formLabelWidth"
              prop="name"
            >
              <el-input
                v-model="addUserForm.name"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="邮箱"
              :label-width="formLabelWidth"
              prop="email"
            >
              <el-input
                v-model="addUserForm.email"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="验证码"
              :label-width="formLabelWidth"
              prop="code"
            >
              <div class="flex-container">
                <el-input
                  v-model="addUserForm.code"
                  autocomplete="off"
                  class="input-with-spacing"
                >
                </el-input>
                <el-button
                  type="warning"
                  @click="addEmailButton(addUserFormRef)"
                  class="button-with-spacing"
                >
                  获取验证码
                </el-button>
              </div>
            </el-form-item>
            <el-form-item
              label="密码"
              :label-width="formLabelWidth"
              prop="password"
            >
              <el-input
                v-model="addUserForm.password"
                type="password"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="性别"
              :label-width="formLabelWidth"
              prop="gender"
            >
              <el-select v-model="addUserForm.gender" placeholder="请选择性别">
                <el-option
                  v-for="item in GenderType"
                  :key="item.typeId"
                  :label="item.typeName"
                  :value="item.typeName"
                >
                </el-option>
              </el-select>
            </el-form-item>
          </el-form>
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="addUserFormVisible = false">取消</el-button>
              <el-button type="primary" @click="addUserButton(addUserFormRef)">
                注册
              </el-button>
            </span>
          </template>
        </el-dialog>
      </el-main>
    </el-container>
  </div>
</template>

<script lang="ts" setup>
import { reactive, ref } from "vue";
import type { FormInstance, FormRules } from "element-plus";
import { ElMessageBox, ElButton } from "element-plus";

import axios from "axios";
import jsCookie from "js-cookie";
import router from "@/router";

// 标签长度
let formLabelWidth = 120;

// 选项框属性
const GenderType = ref([
  {
    typeId: 1,
    typeName: "男",
  },
  {
    typeId: 2,
    typeName: "女",
  },
]);

// 添加用户表单
const addUserFormRef = ref<FormInstance>();
let addUserForm = reactive({
  groups: "",
  email: "",
  password: "",
  name: "",
  gender: "",
  code: "",
  phone: "",
  identity: "",
});

// 添加用户对话框显示
let addUserFormVisible = ref(false);
// 添加用户表单按钮
const addFromButton = (formEl: FormInstance | undefined) => {
  addUserFormVisible.value = true;
  if (!formEl) return;
  formEl.resetFields();
};

// 用户表单判断
const userRules = reactive<FormRules>({
  email: [{ required: true, message: "请输入用户名称", trigger: "blur" }],
});

// 判断用户登录状态
const userLoginState = jsCookie.get("email");
if (userLoginState != undefined) {
  router.push("/home");
}

// 登录表单
const loginButtonRef = ref();
let loginState = ref(false);

// 登陆表单
const loginFormRef = ref<FormInstance>();
const loginForm = reactive({
  email: "",
  password: "",
});

// 表单校验
const loginRules = reactive<FormRules>({
  email: [{ required: true, message: "请输入用户名", trigger: "blur" }],
  password: [{ required: true, message: "请输入密码", trigger: "blur" }],
});

// 登录操作
const login = (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  formEl.validate((valid) => {
    if (valid && !loginState.value) {
      loginState.value = true;
      // 发送客户端请求
      axios.post("/api/manager/login", loginForm).then((resp) => {
        const code = resp.data.code;
        // 登录失败
        if (code == 0) {
          ElMessageBox.alert("登录失败，账号或密码错误", "信息", {
            confirmButtonText: "重试",
          });
          loginState.value = false;
        }

        // 登录成功
        if (code == 200) {
          ElMessageBox.alert("登录成功", "信息", {
            confirmButtonText: "确认",
            callback: () => {
              // 设置Cookie
              jsCookie.set("email", resp.data.email, {
                expires: 1,
                path: "/",
              });
              // 页面跳转
              router.push("/home");
            },
          });
        }

        // 登录失败
        if (code == 2) {
          ElMessageBox.alert("登录失败，账号已被冻结", "信息", {
            confirmButtonText: "确定",
          });
          loginState.value = false;
        }
      });
    } else {
      return false;
    }
  });
};
// 邮箱验证按钮
const addEmailButton = (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  formEl.validate((valid) => {
    if (valid) {
      axios.post("/api/manager/captcha/", addUserForm).then((resp) => {
        console.log(resp);
        const code = resp.data.code;
        const message = resp.data.message;
        // 添加失败
        if (code == 400) {
          ElMessageBox.alert(message, {
            confirmButtonText: "确认",
          });
        }
        // 添加成功
        if (code == 200) {
          ElMessageBox.alert(message, {
            confirmButtonText: "确认",
          });
        }
      });
    } else {
      return false;
    }
  });
};
// 添加用户按钮
const addUserButton = (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  formEl.validate((valid) => {
    if (valid) {
      axios.post("/api/manager/register/", addUserForm).then((resp) => {
        const code = resp.data.code;
        const message = resp.data.message;
        // 添加失败
        if (code == 400) {
          ElMessageBox.alert(message, {
            confirmButtonText: "确认",
          });
        }
        // 添加成功
        if (code == 200) {
          ElMessageBox.alert(message, {
            confirmButtonText: "确认",
            callback: () => {
              addUserFormVisible.value = false;
            },
          });
        }
      });
    } else {
      return false;
    }
  });
};
</script>

<style lang="scss">
@import "../assets/css/login";
.flex-container {
  display: flex;
}

.input-with-spacing {
  margin-right: 10px; /* 调整输入框右侧间距 */
}

.button-with-spacing {
  margin-left: 10px; /* 调整按钮左侧间距 */
}
</style>
