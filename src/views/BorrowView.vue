<template>
  <div class="borrow">
    <el-container>
      <el-main>
        <!--        借阅图书面板-->
        <el-row class="borrow-pane">
          <el-col>
            <el-col><span class="title">借阅图书</span></el-col>
            <!--            图书搜索框-->
            <el-col class="search-book-pane"
              ><el-input
                class="search-book-input"
                placeholder="请输入要搜索的ISBN号码"
                v-model="searchBookInput.ISBN"
              ></el-input
              ><el-button
                class="search-book-button"
                type="primary"
                @click="searchBook"
                >搜索</el-button
              ></el-col
            >
          </el-col>
          <el-col>
            <el-row>
              <!--              图书信息面板-->
              <el-col :span="12" class="book-info-pane">
                <span class="title">图书信息</span>
                <span class="sub-title">图书名称：{{ book.name }}</span>
                <span class="sub-title">作者名称：{{ book.author }}</span>
                <span class="sub-title">出版社名称：{{ book.publish }}</span>
                <span class="sub-title">ISBN号码：{{ book.ISBN }}</span>
                <span class="sub-title">库存（本）：{{ book.num }}</span>
                <sapn class="sub-title"
                  >可借阅（本）：{{ book.remaining }}</sapn
                >
              </el-col>
              <!--              用户表单-->
              <el-col :span="12" class="user-form-pane">
                <el-form v-model="userInfo" ref="userInfoRef">
                  <span class="title">用户信息</span>
                  <el-input
                    placeholder="借阅人卡号"
                    v-model="userInfo.reader_id"
                  ></el-input>
                  <el-date-picker
                    v-model="userInfo.reserve_time"
                    type="date"
                    placeholder="选择还书日期"
                    format="YYYY-MM-DD"
                    value-format="YYYY-MM-DD"
                    style="width: 100%"
                    class="custom-datepicker"
                  ></el-date-picker>
                  <el-select v-model="userInfo.book_id" placeholder="图书ID">
                    <el-option
                      v-for="item in bookIDselect"
                      :value="item"
                      :key="item"
                      :label="item"
                    >
                    </el-option>
                  </el-select>
                  <el-button type="primary" @click="borrowBook"
                    >借阅图书</el-button
                  >
                </el-form>
              </el-col>
            </el-row>
          </el-col>
        </el-row>
        <!--         添加图书表单 -->
        <el-dialog
          v-model="attentionVisible"
          title="预约图书提醒"
          class="add-book-dialog"
          width="500px"
          :close-on-click-modal="false"
        >
          <span>此ISBN无剩余可借图书，是否预约图书？</span>
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="attentionVisible = false">取消</el-button>
              <el-button
                type="primary"
                @click="
                  reserveBookFormVisible = true;
                  attentionVisible = false;
                "
              >
                预约
              </el-button>
            </span>
          </template>
        </el-dialog>
        <el-dialog
          v-model="reserveBookFormVisible"
          title="预约图书"
          class="add-book-dialog"
          width="500px"
          :close-on-click-modal="false"
        >
          <el-form
            :model="reserveBookForm"
            :rules="bookRules"
            ref="reserveBookFormRef"
            class="add-book-form"
          >
            <el-form-item
              label="读者ID"
              :label-width="formLabelWidth"
              prop="reader_id"
            >
              <el-input
                v-model="reserveBookForm.reader_id"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="预约期限"
              :label-width="formLabelWidth"
              prop="reserve_deadline"
            >
              <el-input
                v-model="reserveBookForm.reserve_deadline"
                autocomplete="off"
              ></el-input>
            </el-form-item>
          </el-form>
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="reserveBookFormVisible = false"
                >取消</el-button
              >
              <el-button
                type="primary"
                @click="reserveBookButton(reserveBookFormRef)"
              >
                预约
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
import axios from "axios";
import { ElMessageBox } from "element-plus";
import { removeClass } from "element-plus/es/utils";
// 图书信息
let book = reactive({
  name: "",
  author: "",
  num: "",
  ISBN: "",
  publish: "",
  remaining: "",
  version: "",
});
// 搜索图书输入框
const searchBookInput = reactive({
  ISBN: "",
});
let bookIDselect = ref([]);
const searchBook = () => {
  axios.post("api/manager/querybooktable/", searchBookInput).then((resp) => {
    const code = resp.data.code;
    const message = resp.data.message;
    // 查询成功
    if (code == 200) {
      let array = reactive([]);
      book.name = resp.data.result_list.name;
      book.author = resp.data.result_list.author;
      book.num = resp.data.result_list.num;
      book.ISBN = resp.data.result_list.ISBN;
      book.publish = resp.data.result_list.publish;
      book.remaining = resp.data.remaining;
      array = resp.data.remain_book_id;
      bookIDselect.value = array.map((item) => item.replace(/'/g, '"'));
      if (book.remaining == 0) {
        attentionVisible.value = true;
      }
    }
    // 查询失败
    if (code == 400) {
      ElMessageBox.alert(message);
    }
  });
};
// 用户信息
const userInfoRef = ref<FormInstance>();
const userInfo = reactive({
  reader_id: "",
  book_id: "",
  reserve_time: "",
});
// 借阅图书按钮
const borrowBook = () => {
  let obj = {
    ISBN: searchBookInput.ISBN,
    reader_id: userInfo.reader_id,
    book_id: userInfo.book_id,
    due_date: userInfo.reserve_time,
  };
  axios.post("/api/manager/borrowbook/", obj).then((resp) => {
    console.log("cafaf", obj);
    const code = resp.data.code;
    const message = resp.data.message;

    // 借阅失败
    if (code == 400) {
      ElMessageBox.alert(message, {
        confirmButtonText: "确认",
      });
      searchBook();
    }
    // 借阅成功
    if (code == 200) {
      ElMessageBox.alert(message, {
        confirmButtonText: "确认",
      });
    }
  });
};
// 预约图书
const reserveBookFormRef = ref<FormInstance>();
// 标签长度
let formLabelWidth = 120;
const reserveBookFormVisible = ref(false);
const attentionVisible = ref(false);
let reserveBookForm = reactive({
  ISBN: searchBookInput.ISBN,
  reader_id: "",
  reserve_deadline: "",
});
const bookRules = reactive<FormRules>({
  reader_id: [{ required: true, message: "请输入读者ID", trigger: "blur" }],
  reserve_deadline: [
    { required: true, message: "请输入预约期限", trigger: "blur" },
  ],
});
// 图书预约按钮
const reserveBookButton = (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  formEl.validate((valid) => {
    if (valid) {
      let obj = {
        ISBN: searchBookInput.ISBN,
        reader_id: reserveBookForm.reader_id,
        reserve_deadline: reserveBookForm.reserve_deadline,
      };
      axios.post("/api/manager/reservebook/", obj).then((resp) => {
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
              reserveBookFormVisible.value = false;
            },
          });
          searchBook();
        }
      });
    } else {
      return false;
    }
  });
};
</script>

<style lang="scss">
@import "../assets/css/borrow";
</style>
