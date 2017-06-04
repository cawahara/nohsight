<template>
   <div v-bind:id="getTagId(id)" class="new-item">
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
      <ul class="item-icons">
         <li v-on:click="removeItem(id)">取消<span class="btn"><i class="fa fa-minus"></i></span></li>
      </ul>
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
         getTagId: function(id){
            return 'ev_program-new-' + id
         },
         getItemId: function(id, name){
            return 'ev_program[new-' + id + '][' + name + ']'
         },
         removeItem: function(id){
            var el = document.getElementById('ev_program-new-' + id)
            el.parentNode.removeChild(el)
         }
      }
   }
</script>

<style scoped></style>
