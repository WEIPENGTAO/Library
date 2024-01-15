<template>
  <div class="overtime">
    <el-container>
      <el-main>
        <!--        超时查询操作栏-->
        <el-row class="overtime-header">
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
        </el-row>
        <!--        超时查询表格栏-->
        <el-row class="overtime-table">
          <el-col>
            <el-table
              ref="tableRef"
              :data="overtimes"
              height="100%"
              empty-text="没有数据"
              @header-dragend="handleHeaderDragend"
              border
            >
              <el-table-column fixed prop="reserve_id" label="Id" width="50" />
              <el-table-column prop="book_name" label="书名" />
              <el-table-column prop="author" label="作者" />
              <el-table-column prop="ISBN" label="ISBN" />
              <el-table-column prop="reader_id" label="借阅人ID" />
              <el-table-column prop="reserve_date" label="预约时间" />
              <el-table-column fixed="right" label="操作">
                <template #default="overtimes">
                  <el-button
                    @click="overtimeBookDialog(overtimes.row)"
                    type="text"
                    >取消预约</el-button
                  >
                  <el-button @click="overtimeBookDao(overtimes.row)" type="text"
                    >发送预约到书提醒</el-button
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
        <!--        超时查询对话框-->
        <el-dialog
          v-model="overtimeBookDialogVisible"
          title="归还图书"
          width="500px"
        >
          <span
            >确认取消借阅人： {{ overtimeReader }} 对
            {{ overtimeName }} 的预约？</span
          >
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="overtimeBookDialogVisible = false"
                >取消</el-button
              >
              <el-button type="primary" @click="overtimeBook"> 确认 </el-button>
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

// 超时未归还图书信息
let overtimes = ref();
// 显示数据数量选项
let pageNum = ref(1);
let pageSize = ref(10);
let pageTotal = ref(0);
const page = (val: number) => {
  pageNum.value = val;
  searchOvertime();
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
  searchOvertime();
};

// 搜索框数据
const searchInput = ref();
// 搜索框按钮
const searchButton = () => {
  pageNum.value = 1;
  searchOvertime();
};
// 搜索超时未归还图书信息
const searchOvertime = () => {
  let obj = {
    reader_id: searchInput.value,
    page: pageNum.value,
    per_page: pageSize.value,
  };
  axios.post("/api/manager/queryreserve/", obj).then((resp) => {
    const code = resp.data.code;
    const message = resp.data.message;
    overtimes.value = resp.data.booktables;
    pageTotal.value = resp.data.total_count;
  });
};
// 超时查询
let overtimeName = ref("");
let overtimeId = ref(0);
let overtimeReader = ref(0);
let overtimeBookDialogVisible = ref(false);
const overtimeBookDialog = (row: any) => {
  overtimeId.value = row.reserve_id;
  overtimeName.value = row.book_name;
  overtimeReader.value = row.reader_id;
  overtimeBookDialogVisible.value = true;
};
// 取消预约
const overtimeBook = () => {
  if (overtimeId.value) {
    let obj = {
      id: overtimeId.value,
    };
    axios.post("/api/manager/deletereserve/", obj).then((resp) => {
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
          callback: () => {
            overtimeBookDialogVisible.value = false;
          },
        });
      }
    });
    searchOvertime();
  }
};
// 预约到书
const overtimeBookDao = (row: any) => {
  let obj = {
    reader_id: row.reader_id,
    ISBN: row.ISBN,
  };
  axios.post("/api/manager/reservenotice/", obj).then((resp) => {
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
  searchOvertime();
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
</script>

<style lang="scss">
@import "../assets/css/overtime";
</style>
