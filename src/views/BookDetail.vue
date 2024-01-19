<template>
  <div id="wrap">
    <div id="page-header">
      <el-page-header
        @back="goBack"
        content="详情页面"
        title="返回查询"
      ></el-page-header>
    </div>
    <el-divider></el-divider>
    <div id="detail-container">
      <!-- 商品详情 -->
      <div id="detail">
        <div id="img">
          <img :src="book.url" />
        </div>
        <div id="descriptions">
          <el-descriptions
            :title="'《 ' + book.name + ' 》'"
            :column="3"
            :colon="false"
            style="font-size: 16px"
          >
            <el-descriptions-item
              label="作者 :"
              :contentStyle="{ color: '#409EFF' }"
              >{{ book.author }}
            </el-descriptions-item>
            <el-descriptions-item
              label="出版社 :"
              :contentStyle="{ color: '#409EFF' }"
              >{{ book.publish }}
            </el-descriptions-item>
            <el-descriptions-item
              label="版本 :"
              :contentStyle="{ color: '#409EFF' }"
              >{{ book.version }}
            </el-descriptions-item>
            <el-descriptions-item
              label="经办人 :"
              :contentStyle="{
                'margin-top': '10px',
                'font-size': '20px',
                color: '#222222',
                'font-weight': '400',
                width: '750px',
                height: '115px',
                display: '-webkit-box',
                overflow: 'hidden',
                '-webkit-box-orient': 'vertical',
                '-webkit-line-clamp': '4',
              }"
            >
              {{ book.manager_id }}
            </el-descriptions-item>
            <el-descriptions-item
              label="出版日期 :"
              :contentStyle="{ color: '#409EFF' }"
              >{{ formatDate(book.pub_date) }}
            </el-descriptions-item>
          </el-descriptions>
          <div>
            <span style="font-size: 18px">¥ </span
            ><span class="discountPrice">{{
              Number(book.price).toFixed(2)
            }}</span>
            <el-button
              style="margin-left: 300px"
              @click="searchInfo()"
              type="primary"
              plain
              :icon="ShoppingCart"
              >借书</el-button
            >
            <el-popover
              placement="bottom"
              title="收藏"
              :width="150"
              trigger="hover"
              content="添加该商品到收藏夹"
              style="margin-left: 180px; margin-right: 10px"
            >
              <template #reference>
                <el-button
                  @click="addToCollection(book.bookId)"
                  type="warning"
                  :icon="Star"
                  circle
                ></el-button>
              </template>
            </el-popover>
            <el-popover
              placement="bottom"
              title="分享"
              :width="150"
              trigger="hover"
              content="复制商品链接以分享"
            >
              <template #reference
                ><el-button stype="success" :icon="Link" circle></el-button
              ></template>
            </el-popover>
          </div>

          <el-divider></el-divider>
        </div>
      </div>
      <el-dialog title="借书" v-model="checkTable" :loading="true">
        <div class="borrow">
          <el-col :span="8" class="book-info-pane2">
            <el-form v-model="userInfo" ref="userInfoRef">
              <span style="font-size: 20px">用户信息</span>
              <el-input
                style="margin-top: 30px"
                placeholder="借阅人卡号"
                v-model="userInfo.reader_id"
              ></el-input>
              <el-date-picker
                v-model="userInfo.reserve_time"
                type="date"
                placeholder="选择还书日期"
                format="YYYY-MM-DD"
                value-format="YYYY-MM-DD"
                style="margin-top: 30px; width: 100%"
                class="custom-datepicker"
              ></el-date-picker>
              <el-select
                v-model="userInfo.book_id"
                style="margin-top: 30px"
                placeholder="图书ID"
              >
                <el-option
                  v-for="item in bookIDselect"
                  :value="item"
                  :key="item"
                  :label="item"
                >
                </el-option>
              </el-select>
              <el-button
                style="margin-top: 30px"
                type="primary"
                @click="borrowBook"
                >借阅图书</el-button
              >
            </el-form>
          </el-col>
          <el-container>
            <el-main>
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
                    <el-button
                      @click="
                        attentionVisible = false;
                        checkTable = false;
                      "
                      >取消</el-button
                    >
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
                    <el-button
                      @click="
                        reserveBookFormVisible = false;
                        checkTable = false;
                      "
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
      </el-dialog>

      <!-- 分隔线 -->
      <div style="margin: 60px auto 100px">
        <el-divider content-position="right"></el-divider>
      </div>

      <!-- 推荐 -->
      <div id="recommendation">
        <el-divider content-position="left">
          <span style="font-size: 20px"
            ><el-icon><Present /></el-icon> 同类推荐</span
          >
        </el-divider>
        <div id="recommendBooks">
          <el-row :gutter="25">
            <el-col
              :span="4"
              v-for="(book, index) in recommendBooks"
              :key="index"
            >
              <div @click="bookDetail(book.ISBN)" style="cursor: pointer">
                <el-card :body-style="{ padding: '0px' }" shadow="hover">
                  <img :src="book.url" class="image" />
                  <div style="padding: 12px">
                    <span>{{ book.name }}</span
                    ><br />
                    <span>作者：{{ book.author }}</span>
                  </div>
                </el-card>
              </div>
            </el-col>
          </el-row>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { Link, Star, ShoppingCart } from "@element-plus/icons-vue";
import { ref, reactive, onMounted, watch } from "vue";
import axios from "axios";
import { useRoute, useRouter } from "vue-router";
import { ElMessageBox } from "element-plus";
const router = useRouter();
const route = useRoute();
const checkTable = ref(false);
const checkData = reactive([
  { bookName: "", quantity: 0, discountPrice: 0, img: "" },
]);
const userInfo = ref({
  id: "",
  userName: "",
  phoneNumber: "",
  shippingAddress: "",
});
const loadingBtn = ref(false);
const commentData = ref([]);
let pageNum = ref(1);
let pageSize = ref(10);
const total = ref("");
let book = ref({
  id: "",
  bookName: "",
  author: "",
  price: 0,
  discount: 1,
  press: "",
  publicationDate: "",
  brief: "",
  img: "",
});
const recommendBooks = ref([
  { id: "", bookName: "", price: 0, discount: 0, img: "" },
]);
// 借书
let reserveBookForm = reactive({
  ISBN: book.value.ISBN,
  reader_id: "",
  reserve_deadline: "",
});
const attentionVisible = ref(false);
function searchInfo() {
  searchBook();
  checkTable.value = true;
}
const searchBook = () => {
  let obj = {
    ISBN: book.value.ISBN,
  };
  axios.post("/api/manager/querybooktable/", obj).then((resp) => {
    const code = resp.data.code;
    // 查询成功
    if (code == 200) {
      if (resp.data.remaining == 0) {
        attentionVisible.value = true;
      }
    }
  });
};
const reserveBookFormVisible = ref(false);
// 页面初始化时执行，根据编号查询图书
const initData = async (bookId) => {
  try {
    let searchObj = {
      ISBN: bookId,
      page: pageNum.value,
      per_page: pageSize.value,
    };
    const response = await axios.post("/api/manager/showbooktable", searchObj);
    book.value = response.data.booktables[0];
    checkData[0] = response.data.booktables[0];
    await initDataCategory();
    // 处理成功的响应
  } catch (error) {
    // 处理请求错误
    console.error("请求失败：", error);
  }
};
function goBack() {
  router.push("/bookTable");
}
// 图书预约按钮
const reserveBookButton = () => {
  let obj = {
    ISBN: book.value.ISBN,
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
          checkTable.value = false;
        },
      });
    }
  });
};
// 页面初始化时执行，查询同类
const initDataCategory = async () => {
  try {
    let searchObj = {
      ISBN: "",
      page: pageNum.value,
      per_page: 6,
    };
    const response = await axios.post("/api/manager/showbooktable", searchObj);
    recommendBooks.value = response.data.booktables;
    // 处理成功的响应
    console.log("成功：", recommendBooks.value);
  } catch (error) {
    // 处理请求错误
    console.error("请求失败：", error);
  }
};
// 格式化日期
function formatDate(time) {
  let date = new Date(time);
  let year = date.getFullYear();
  let month = date.getMonth() + 1;
  let day = date.getDate();
  return year + "-" + month + "-" + day;
}
// 从同类推荐跳转到图书详情页
function bookDetail(id) {
  router.push({ name: "BookDetail", params: { id: id } });
}
// 在组件挂载时执行查询图书的函数
onMounted(async () => {
  const bookId = route.params.id;
  router.afterEach((to, from, next) => {
    window.scrollTo(0, 0);
  });
  await initData(bookId);
  // 在这里可以执行其他操作，确保 initData 函数执行完成后再执行
});
// 使用 watch 监听路由变化
watch(
  () => route.params.id,
  (to, from) => {
    console.log(`Route changed from ${from.path} to ${to.path}`);
    window.location.reload();
  }
);
</script>
<style>
#wrap {
  margin: 80px auto;
  width: 1200px;
}

#detail-container #detail {
  margin: 30px auto 0;
  width: 1200px;
  height: 400px;
}

#detail-container #detail #img {
  margin-right: 50px;
  margin-left: 15px;
  width: 300px;
  float: left;
  border: 1px #dcdfe6 solid;
  padding: 10px;
}

#detail-container #detail #img img {
  margin-left: 15px;
  width: 260px;
  height: 360px;
}

#detail-container #detail #descriptions {
  width: 800px;
  float: left;
  font-size: 25px;
  margin-top: 20px;
}

.discountPrice {
}

.price {
  margin-left: 20px;
  text-decoration: line-through;
  color: rgba(151, 151, 151, 0.9);
  font-size: 16px;
}

#btn-group {
  margin: 40px auto 0;
}

#recommendation .image {
  width: 160px;
  height: 200px;
  display: block;
  margin-left: 10px;
  margin-top: 5px;
}

#recommendBooks {
  margin-top: 60px;
}

#detail-comment {
  margin: 100px auto;
}

#detail-comment .comment-content {
  padding: 15px;
}

#detail-comment .comment-content .userInfo img {
  width: 80px;
  height: 80px;
  margin-top: 10px;
  margin-left: 50px;
}

#detail-comment .comment-content .userInfo p {
  text-align: center;
  font-size: 16px;
  color: #409eff;
}

#detail-comment .comment-content .userGrade {
  margin: 0 auto 10px;
  width: 140px;
}
#detail-comment .comment-content .createTime {
  margin-left: 0px;
}

#detail-comment .comment-content .userComment {
  height: 80px;
  display: -webkit-box;
  overflow: hidden;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 4;
  text-indent: 30px;
}

#detail-comment .comment-content .date {
  margin-left: 1100px;
}

#pageBtn {
  float: right; /* 使用 float: right; 将元素靠右 */
  display: table;
}
#pinglun {
  margin-top: 40px;
}
.book-info-pane2 {
  margin-left: 35%;
}
</style>
