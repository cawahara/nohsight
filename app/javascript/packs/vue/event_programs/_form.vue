<template>
   <div class="new-item">
      <input v-bind:name="getItemId(id, 'type')" type="hidden" value="create">
      <h3>新規追加演目</h3>
      <div class="edit-item">
         <div class="sm-form">
            <label>演目</label>
            <input v-bind:name="getItemId(id, 'title')" type="text">
         </div>
         <div class="sm-form">
            <label>ジャンル</label>
            <input v-bind:name="getItemId(id, 'genre')" type="text">
         </div>
         <div class="sm-form">
            <label>流派</label>
            <input v-bind:name="getItemId(id, 'style')" type="text">
         </div>
         <div class="sm-form">
            <label>演者</label>
            <input v-bind:name="getItemId(id, 'performer')" type="text">
         </div>
      </div>
   </div>

</template>

<script>
   export default {
      props: [ 'values' ],
      data: function(){
         return {
            id: this.values.id
         }
      },
      methods: {
         getItemId: function(id, name){
            return 'ev_program[new-' + id + '][' + name + ']'
         }
      }
   }
</script>

<style scoped></style>
