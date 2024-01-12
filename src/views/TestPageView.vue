<template>
  <div class="draggable-table">
    <el-table
      ref="tableRef"
      :data="tableData.data"
      :key="'table' + tableData.key"
      @header-dragend="handleHeaderDragend"
      border
      style="width: 100%"
    >
      <el-table-column fixed prop="id" label="Id" width="50" />
      <el-table-column prop="url" label="图书封面" width="100">
        <template #default="scope">
          <el-image
            :src="scope.row.url"
            style="width: 70px; height: 70px"
          ></el-image>
        </template>
      </el-table-column>
      <el-table-column prop="name" label="书名" width="150" />
      <el-table-column prop="author" label="作者" width="130" />
      <el-table-column prop="publish" label="出版商" width="130" />
      <el-table-column prop="ISBN" label="ISBN号码" width="170" />
      <el-table-column label="出版年月" prop="pub_date" width="100">
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
      <el-table-column fixed="right" label="操作" width="150">
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
  </div>
</template>
<script lang="ts" setup>
import { nextTick, onMounted, reactive, ref } from "vue";
import Sortable from "sortablejs";

const tableData = reactive({
  key: new Date().getTime(),
  data: [
    {
      id: "id",
      name: "name",
      amount1: "amount1",
      amount2: "amount2",
      amount3: "amount3",
    },
    {
      id: "12987123",
      name: "Tom",
      amount1: "165",
      amount2: "4.43",
      amount3: 12,
    },
    {
      id: "12987124",
      name: "Tom",
      amount1: "324",
      amount2: "1.9",
      amount3: 9,
    },
    {
      id: "12987125",
      name: "Tom",
      amount1: "621",
      amount2: "2.2",
      amount3: 17,
    },
    {
      id: "12987126",
      name: "Tom",
      amount1: "539",
      amount2: "4.1",
      amount3: 15,
    },
  ],
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
<style scoped lang="scss"></style>
