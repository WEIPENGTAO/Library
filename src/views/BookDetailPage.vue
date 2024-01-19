<template>
  <router-view :key="router.path"></router-view>
</template>

<script lang="ts" setup>
import router from "@/router";
</script>

<style scoped></style>
