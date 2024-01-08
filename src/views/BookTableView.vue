<template>
  <div class="book">
    <el-container>
      <el-main>
        <!--        图书操作栏-->
        <el-row class="book-header">
          <el-col :span="4" class="search-page-pane">
            <el-select
              v-model="pageSize"
              placeholder="数据显示"
              @change="changeSize"
              class="search-size"
            >
              <el-option
                v-for="item in sizeOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              >
              </el-option>
            </el-select>
          </el-col>
          <el-col :span="16" class="search-input-pane">
            <el-row>
              <el-col :span="4">
                <el-select
                  v-model="searchModel"
                  placeholder="搜索类型"
                  @change="changeSearch"
                  class="search-size"
                >
                  <el-option
                    v-for="item in searchOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-col>
              <el-col :span="14">
                <el-input
                  placeholder="请输入搜索内容"
                  v-model="searchInput"
                  :suffix-icon="Search"
                  class="search-input"
                >
                </el-input>
              </el-col>
              <el-col :span="6">
                <el-button
                  type="primary"
                  class="search-button"
                  @click="searchButton"
                >
                  搜索
                </el-button>
              </el-col>
            </el-row>
          </el-col>
          <el-col :span="4" class="add-button-pane">
            <el-button
              type="success"
              :icon="Plus"
              class="add-button"
              @click="addFromButton(addBookFormRef)"
            >
              添加图书
            </el-button>
          </el-col>
        </el-row>
        <!--        图书表格栏-->
        <el-row class="book-table">
          <el-col>
            <el-table :data="books" height="100%" empty-text="没有数据">
              <el-table-column fixed prop="id" label="Id" width="50" />
              <el-table-column prop="name" label="书名" width="130" />
              <el-table-column prop="author" label="作者" width="170" />
              <el-table-column prop="publish" label="出版商" width="130" />
              <el-table-column prop="ISBN" label="ISBN号码" width="170" />
              <el-table-column label="出版年月" prop="pub_date">
                <template v-slot="{ row }">
                  <span>{{ formatDate(row.pub_date) }}</span>
                </template>
              </el-table-column>
              <el-table-column prop="num" label="册数" />
              <el-table-column prop="manager_id" label="经办人" />
              <el-table-column label="价格" prop="price">
                <template v-slot="{ row }">
                  <span>{{ formatPrice(row.price) }}</span>
                </template>
              </el-table-column>
              <el-table-column fixed="right" label="操作">
                <template #default="books">
                  <el-button
                    @click="editFromButton(editBookFormRef, books.row)"
                    type="text"
                    >编辑</el-button
                  >
                  <el-button @click="deleteBookDialog(books.row)" type="text"
                    >删除</el-button
                  >
                </template>
              </el-table-column>
            </el-table>
            <el-pagination
              background
              v-model:current-page="pageNum"
              v-model:page-size="pageSize"
              layout="prev, pager, next"
              :total="pageTotal"
              @current-change="page"
            >
            </el-pagination>
          </el-col>
        </el-row>

        <!--         添加图书表单 -->
        <el-dialog
          v-model="addBookFormVisible"
          title="添加书籍"
          class="add-book-dialog"
          width="500px"
          :close-on-click-modal="false"
        >
          <el-form
            :model="addBookForm"
            :rules="bookRules"
            ref="addBookFormRef"
            class="add-book-form"
          >
            <el-form-item
              label="书名"
              :label-width="formLabelWidth"
              prop="name"
            >
              <el-input
                v-model="addBookForm.name"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="作者"
              :label-width="formLabelWidth"
              prop="author"
            >
              <el-input
                v-model="addBookForm.author"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="ISBN号码"
              :label-width="formLabelWidth"
              prop="ISBN"
            >
              <el-input
                v-model.number="addBookForm.ISBN"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="价格(人民币)"
              :label-width="formLabelWidth"
              prop="price"
            >
              <el-input
                v-model="addBookForm.price"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="出版社"
              :label-width="formLabelWidth"
              prop="publish"
            >
              <el-input
                v-model="addBookForm.publish"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="出版年月"
              :label-width="formLabelWidth"
              prop="pub_date"
            >
              <el-date-picker
                v-model="addBookForm.pub_date"
                type="date"
                placeholder="选择日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
                style="width: 100%"
                class="custom-datepicker"
              ></el-date-picker>
            </el-form-item>
            <el-form-item
              label="经办人"
              :label-width="formLabelWidth"
              prop="manager_id"
            >
              <el-input
                v-model="addBookForm.manager_id"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="版本"
              :label-width="formLabelWidth"
              prop="version"
            >
              <el-input
                v-model.number="addBookForm.version"
                autocomplete="off"
                maxlength="3"
              ></el-input>
            </el-form-item>
          </el-form>
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="addBookFormVisible = false">取消</el-button>
              <el-button type="primary" @click="addBookButton(addBookFormRef)">
                添加
              </el-button>
            </span>
          </template>
        </el-dialog>

        <!--        编辑图书表单-->
        <el-dialog
          v-model="editBookFormVisible"
          title="编辑书籍"
          class="edit-book-dialog"
          width="500px"
          :close-on-click-modal="false"
        >
          <el-form
            :model="editBookForm"
            :rules="bookRules"
            ref="editBookFormRef"
            class="edit-book-form"
          >
            <el-form-item
              label="书名"
              :label-width="formLabelWidth"
              prop="name"
            >
              <el-input
                v-model="editBookForm.name"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="作者"
              :label-width="formLabelWidth"
              prop="author"
            >
              <el-input
                v-model="editBookForm.author"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="ISBN号码"
              :label-width="formLabelWidth"
              prop="ISBN"
            >
              <el-input
                v-model.number="editBookForm.ISBN"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="价格(人民币)"
              :label-width="formLabelWidth"
              prop="price"
            >
              <el-input
                v-model="editBookForm.price"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="出版社"
              :label-width="formLabelWidth"
              prop="publish"
            >
              <el-input
                v-model="editBookForm.publish"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="出版年月"
              :label-width="formLabelWidth"
              prop="pub_date"
            >
              <el-date-picker
                v-model="editBookForm.pub_date"
                type="date"
                placeholder="选择日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
                style="width: 100%"
                class="custom-datepicker"
              ></el-date-picker>
            </el-form-item>
            <el-form-item
              label="经办人"
              :label-width="formLabelWidth"
              prop="manager_id"
            >
              <el-input
                v-model="editBookForm.manager_id"
                autocomplete="off"
              ></el-input>
            </el-form-item>
            <el-form-item
              label="版本"
              :label-width="formLabelWidth"
              prop="version"
            >
              <el-input
                v-model.number="editBookForm.version"
                autocomplete="off"
                maxlength="3"
              ></el-input>
            </el-form-item>
          </el-form>
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="editBookFormVisible = false">取消</el-button>
              <el-button
                type="primary"
                @click="editBookButton(editBookFormRef)"
              >
                编辑
              </el-button>
            </span>
          </template>
        </el-dialog>

        <!--        删除图书对话框-->
        <el-dialog
          v-model="deleteBookDialogVisible"
          title="删除图书"
          width="500px"
        >
          <span>确认删除 {{ deleteList.deleteName }}</span>
          <div>
            <span>ISBN: {{ deleteList.ISBN }}</span>
          </div>
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="deleteBookDialogVisible = false"
                >取消</el-button
              >
              <el-button type="danger" @click="deleteBook"> 确认 </el-button>
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
import { Plus, Search } from "@element-plus/icons-vue";
import axios from "axios";
import { ElMessageBox, ElMessage } from "element-plus";
import router from "@/router";
import { format } from "date-fns";
// 返回日期格式
const formatDate = (val: string) => {
  const formattedDate = format(new Date(val), "yyyy-MM-dd");
  return formattedDate;
};
// 定义价格格式化方法
const formatPrice = (value: string) => {
  return parseFloat(value).toFixed(2);
};

// 标签长度
let formLabelWidth = 120;

// 获取图书数据
let books = ref();

// 显示数据数量选项
let pageNum = ref(1);
let pageSize = ref(10);
let pageTotal = ref(0);
const page = (val: number) => {
  pageNum.value = val;
  searchBook();
};

// 数据显示框
let sizeOptions = [
  {
    value: 10,
    label: "10条数据/页",
  },
  {
    value: 50,
    label: "50条数据/页",
  },
  {
    value: 100,
    label: "100条数据/页",
  },
];
// 修改显示数据量
const changeSize = (value: number) => {
  pageSize.value = value;
  searchBook();
};

// 搜索框选项
let searchModel = ref("name");
let searchOptions = [
  {
    value: "name",
    label: "图书名称",
  },
  {
    value: "author",
    label: "作者名称",
  },
  {
    value: "publish",
    label: "出版社名称",
  },
  {
    value: "ISBN",
    label: "ISBN号码",
  },
];
const changeSearch = (value: string) => {
  searchModel.value = value;
};

// 搜索框数据
const searchInput = ref();
// 搜索框按钮
const searchButton = () => {
  pageNum.value = 1;
  searchBook();
};
// 搜索图书
const searchBook = () => {
  if (searchInput.value != "") {
    axios
      .get(
        "/api/manager/showbooktable?pageNum=" +
          // searchModel.value +
          // "/" +
          // searchInput.value +
          // "/" +
          pageNum.value +
          "&pageSize=" +
          pageSize.value
      )
      .then((resp) => {
        books.value = resp.data.booktables;
        pageTotal.value = resp.data.totalElements;
        const code = resp.data.code;
        const message = resp.data.message;
        // 查询失败
        if (code == 400) {
          ElMessage({
            message: message,
            type: "error",
          });
        }
        // 查询成功
        if (code == 200) {
          ElMessage({
            message: message,
            type: "success",
          });
        }
      });
  }
};

// 图书表单判断
const checkISBN = (rule: any, value: any, callback: any) => {
  if (!value) {
    return callback(new Error("请输入ISBN号码"));
  } else {
    if (!Number.isInteger(value)) {
      callback(new Error("请输入正确的ISBN号码"));
    } else {
      let isbnReg = /^[1-9]\d{12}$/;
      if (!isbnReg.test(value)) {
        callback(new Error("请输入13位ISBN号码"));
      } else {
        callback();
      }
    }
  }
};
// 图书表单规则
const bookRules = reactive<FormRules>({
  pub_date: [{ required: true, message: "请输入出版日期", trigger: "blur" }],
  name: [{ required: true, message: "请输入图书名称", trigger: "blur" }],
  author: [{ required: true, message: "请输入作者名称", trigger: "blur" }],
  publish: [{ required: true, message: "请输入出版社名称", trigger: "blur" }],
  price: [{ required: true, message: "请输入价格(人民币)", trigger: "blur" }],
  version: [{ required: true, message: "请输入数量(本)", trigger: "blur" }],
  ISBN: [{ required: true, message: "请输入ISBN", trigger: "blur" }],
  manager_id: [{ required: true, message: "请输入经办人", trigger: "blur" }],
});

// 添加图书对话框显示
let addBookFormVisible = ref(false);
// 添加表单按钮
const addFromButton = (formEl: FormInstance | undefined) => {
  addBookFormVisible.value = true;
  if (!formEl) return;
  formEl.resetFields();
};

// 添加图书表单
const addBookFormRef = ref<FormInstance>();
let addBookForm = reactive({
  name: "",
  author: "",
  publish: "",
  price: "",
  version: "",
  ISBN: "",
  pub_date: "",
  manager_id: "",
});

// 添加图书按钮
const addBookButton = (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  formEl.validate((valid) => {
    if (valid) {
      axios.post("/api/manager/addbooktable/", addBookForm).then((resp) => {
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
              addBookFormVisible.value = false;
              searchBook();
            },
          });
        }
      });
    } else {
      return false;
    }
  });
};

// 编辑图书对话框
let editBookFormVisible = ref(false);
const editFromButton = (formEl: FormInstance | undefined, row: any) => {
  editBookFormVisible.value = true;
  editBookForm = reactive(JSON.parse(JSON.stringify(row)));
  editBookForm.pub_date = formatDate(row.pub_date);
  if (!formEl) return;
  formEl.resetFields();
};

// 编辑图书表单
const editBookFormRef = ref<FormInstance>();
let editBookForm = reactive({
  name: "",
  author: "",
  publish: "",
  price: "",
  version: "",
  ISBN: "",
  pub_date: "",
  manager_id: "",
  num: 1,
});

// 编辑图书按钮
const editBookButton = (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  formEl.validate((valid) => {
    if (valid) {
      axios.post("/api/manager/updatebooktable/", editBookForm).then((resp) => {
        console.log("caf", editBookForm);
        const code = resp.data.code;
        const message = resp.data.message;
        // 编辑失败
        if (code == 400) {
          ElMessageBox.alert(message, {
            confirmButtonText: "确认",
          });
        }
        // 编辑成功
        if (code == 200) {
          ElMessageBox.alert(message, {
            confirmButtonText: "确认",
            callback: () => {
              editBookFormVisible.value = false;
              searchBook();
            },
          });
        }
      });
    } else {
      return false;
    }
  });
};

// 删除图书
let deleteList = reactive({
  ISBN: "",
  deleteName: "",
});
let deleteBookDialogVisible = ref(false);
const deleteBookDialog = (row: any) => {
  deleteList.deleteName = row.name;
  deleteList.ISBN = row.ISBN;
  deleteBookDialogVisible.value = true;
};

// 删除图书按钮
const deleteBook = () => {
  if (deleteList.deleteName) {
    axios.post("/api/manager/deletebooktable/", deleteList).then((resp) => {
      const code = resp.data.code;
      const message = resp.data.message;

      // 删除成功
      if (code == 200) {
        ElMessageBox.alert(message, {
          confirmButtonText: "确认",
          callback: () => {
            deleteBookDialogVisible.value = false;
            searchBook();
          },
        });
      }
      // Id 不存在// 删除失败
      if (code == 400) {
        ElMessageBox.alert(message, {
          confirmButtonText: "确认",
        });
      }
    });
  }
};

// 初始化
const init = () => {
  // 获取图书种类
  searchBook();
};
init();
</script>

<style lang="scss">
@import "../assets/css/book";
</style>
