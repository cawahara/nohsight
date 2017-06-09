<template>
   <div class="edit-item" v-show="mode == 'update'">
      <div class="lg-form">
         <label>演目</label>
         <div class="input-with-btn">
            <input v-bind:name="getColumn(id, 'title')" type="text" v-bind:value="program.title">
            <span class="btn"><i class="fa fa-bars"></i></span>
         </div>
      </div>

      <div class="sm-form">
         <label>種類</label>
         <input v-bind:name="getColumn(id, 'genre')" type="text" v-bind:value="ev_program.genre">
      </div>

      <div class="sm-form">
         <label>流派</label>
         <input v-bind:name="getColumn(id, 'style')" type="text" v-bind:value="ev_program.style">
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
