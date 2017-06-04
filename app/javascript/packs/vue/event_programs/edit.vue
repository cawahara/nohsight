<template>
   <div class="edit-item" v-show="mode == 'update'">
      <div class="sm-form">
         <label>演目</label>
         <input v-bind:name="getItemId(id, 'title')" type="text" v-bind:value="program.title">
      </div>
      <div class="sm-form">
         <label>ジャンル</label>
         <input v-bind:name="getItemId(id, 'genre')" type="text" v-bind:value="ev_program.genre">
      </div>
      <div class="sm-form">
         <label>流派</label>
         <input v-bind:name="getItemId(id, 'style')" type="text" v-bind:value="ev_program.style">
      </div>
      <div class="sm-form">
         <label>演者</label>
         <input v-bind:name="getItemId(id, 'performer')" type="text" v-bind:value="ev_performers[0].full_name">
      </div>
   </div>
</template>

<script>
   export default {
      props: [ 'values' ],
      data: function(){
         return {

         }
      },
      methods: {

      }
   }
</script>

<style scoped></style>
