<template>
   <div>
      <img v-bind:src="thumbnail_url" alt="thumbnail">
   </div>
</template>

<script>
   export default {
      props: { thumbnail_url: String }
   }
</script>

<style scoped></style>
