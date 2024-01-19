<template>
  <div class="return">
    <el-container>
      <el-main>
        <!--        归还图书操作栏-->
        <el-row class="return-header">
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
              <el-col :span="18">
                <el-input
                  placeholder="请输入读者ID"
                  v-model="searchInput.reader_id"
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
            <el-row>
              <div>
                <el-checkbox-group
                  v-model="searchInput.status"
                  :min="0"
                  :max="1"
                >
                  <el-checkbox
                    v-for="item in bookstatus"
                    :key="item"
                    :label="item"
                    >{{ item }}</el-checkbox
                  >
                </el-checkbox-group>
              </div>
            </el-row>
          </el-col>
        </el-row>
        <!--        归还图书表格栏-->
        <el-row class="return-table">
          <el-col>
            <el-table
              ref="tableRef"
              :data="borrows"
              height="100%"
              empty-text="没有数据"
              @header-dragend="handleHeaderDragend"
              border
            >
              <el-table-column
                type="index"
                :index="Nindex"
                label="序号"
                width="60"
              ></el-table-column>
              <el-table-column fixed prop="book_id" label="图书ID" />
              <el-table-column prop="book_name" label="书名" />
              <el-table-column prop="author" label="作者" />
              <el-table-column prop="ISBN" label="ISBN号码" />
              <el-table-column prop="reader_id" label="借阅人" />
              <el-table-column prop="lend_date" label="借阅时间" />
              <el-table-column
                v-if="searchInput.status[0] == '已还'"
                prop="return_date"
                label="还书时间"
              />
              <el-table-column
                v-if="searchInput.status[0] != '已还'"
                prop="due_date"
                label="应归还时间"
              />
              <el-table-column prop="status" label="图书状态" />
              <el-table-column
                v-if="searchInput.status[0] != '已还'"
                fixed="right"
                label="操作"
                width="200px"
              >
                <template #default="borrows">
                  <el-button @click="returnBookDialog(borrows.row)" type="text"
                    >归还</el-button
                  >
                  <el-button @click="overtimeBookDao(borrows.row)" type="text"
                    >发送归还图书提醒</el-button
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
        <!--        归还图书对话框-->
        <el-dialog
          v-model="returnBookDialogVisible"
          title="归还图书"
          width="500px"
        >
          <span>确认归还： {{ returnName }}</span>
          <div>
            <span>借阅人： {{ returnReaderID }}</span>
          </div>
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="returnBookDialogVisible = false"
                >取消</el-button
              >
              <el-button type="primary" @click="returnBook"> 确认 </el-button>
            </span>
          </template>
        </el-dialog>
      </el-main>
    </el-container>
  </div>
</template>

<script lang="ts" setup>
import { nextTick, reactive, ref, onMounted } from "vue";
import Sortable from "sortablejs";
import { Search } from "@element-plus/icons-vue";
import axios from "axios";
import { ElMessageBox } from "element-plus";

// 借阅图书信息
let borrows = ref();
// 显示数据数量选项
let pageNum = ref(1);
let pageSize = ref(10);
let pageTotal = ref(0);
const page = (val: number) => {
  pageNum.value = val;
  searchBorrow();
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
  searchBorrow();
};

// 搜索框数据
const searchInput = reactive({
  reader_id: "",
  status: [],
});
const bookstatus = ["未还", "已还", "超期未还"];
// 搜索框按钮
const searchButton = () => {
  pageNum.value = 1;
  searchBorrow();
};
// 搜索借阅信息
const searchBorrow = () => {
  let obj = {
    reader_id: searchInput.reader_id,
    status: searchInput.status[0],
    page: pageNum.value,
    per_page: pageSize.value,
  };
  axios.post("/api/manager/querylend/", obj).then((resp) => {
    borrows.value = resp.data.booktables;
    pageTotal.value = resp.data.total_count;
  });
};

// 归还图书
let returnName = ref("");
let returnId = ref(0);
let returnReaderID = ref(0);
let returnBookDialogVisible = ref(false);
const returnBookDialog = (row: any) => {
  returnId.value = row.book_id;
  returnName.value = row.book_name;
  returnReaderID.value = row.reader_id;
  returnBookDialogVisible.value = true;
};
const returnBook = () => {
  if (returnId.value) {
    let obj = {
      book_id: returnId.value,
      reader_id: returnReaderID.value,
    };
    console.log("caefaf", obj);
    axios.post("/api/manager/returnbook/", obj).then((resp) => {
      const code = resp.data.code;
      const message = resp.data.message;
      // 归还失败
      if (code == 400) {
        ElMessageBox.alert(message, {
          confirmButtonText: "确认",
        });
      }
      // 归还成功
      if (code == 200) {
        ElMessageBox.alert("归还图书成功", "信息", {
          confirmButtonText: "确认",
          callback: () => {
            returnBookDialogVisible.value = false;
          },
        });
        searchBorrow();
      }
    });
  }
};
// 邮箱还书
const overtimeBookDao = (row: any) => {
  let obj = {
    reader_id: row.reader_id,
    book_id: row.book_id,
    book_name: row.book_name,
  };
  axios.post("/api/manager/returnnotice/", obj).then((resp) => {
    const code = resp.data.code;
    const message = resp.data.message;

    // 取消预约失败
    if (code == 400) {
      ElMessageBox.alert(message, {
        confirmButtonText: "确认",
      });
    }
    // 取消预约成功
    if (code == 200) {
      ElMessageBox.alert(message, {
        confirmButtonText: "确认",
      });
    }
  });
};
// 初始化
const init = () => {
  searchBorrow();
};
init();
// 表格可变长
const tableData = reactive({
  key: new Date().getTime(),
  columnList: [
    {
      label: "ID",
      prop: "id",
      width: "180",
    },
    {
      label: "Name",
      prop: "name",
      width: "180",
    },
    {
      label: "Amount1",
      prop: "amount1",
      width: "180",
    },
    {
      label: "Amount2",
      prop: "amount2",
      width: "180",
    },
    {
      label: "Amount3",
      prop: "amount3",
      width: "180",
    },
  ],
});
const tableRef = ref();
let sortable: Sortable;
onMounted(() => {
  initTableHeaderDrag(); // 初始化拖拽事件
});

function initTableHeaderDrag() {
  if (sortable) {
    sortable.destroy();
  }
  let el = tableRef.value.$el.querySelector(".el-table__header-wrapper tr");
  sortable = Sortable.create(el, {
    animation: 150,
    onEnd(evt: any) {
      const oldItem = tableData.columnList[evt.oldIndex];
      tableData.columnList.splice(evt.oldIndex, 1);
      tableData.columnList.splice(evt.newIndex, 0, oldItem);
      tableData.key = new Date().getTime(); // 变更key，强制重绘table。如果不强制变更的话，会出现一些奇奇怪怪的问题，列宽度调整也会出现问题
      nextTick(() => {
        initTableHeaderDrag(); // 因为table被强制重新绘制，因此需要重新监听
      });
    },
  });
}
function handleHeaderDragend(newWidth, oldWidth, column, event) {
  for (let item of tableData.columnList) {
    if (item.label == column.label) {
      item.width = newWidth;
    }
  }
  initTableHeaderDrag(); // 重新注册，防止变更宽度后无法拖动
}
const Nindex = (index: number) => {
  // 当前页数 - 1 * 每页数据条数 + 1
  const page = pageNum.value; // 当前页码
  const pagesize = pageSize.value; // 每页条数
  return index + 1 + (page - 1) * pagesize;
};
</script>

<style lang="scss">
@import "../assets/css/return";
</style>
