<template>
   <div v-bind:id="getTagId(inherit_mode, id)" class="form-item">
      <input v-bind:name="getColumn(id, 'type')" type="hidden" v-model:value="inherit_mode">
      <input v-bind:name="getColumn(id, 'id')" type="hidden" v-bind:value="ticket.id">
      <!-- FIXME: わかりやすいデザインにしたい(ボタンによる入力項目の拡張が行えるが、一目見ただけでは何を編集しているのかがわかりづらい) -->
      <div class="sm-form">
         <label>客席</label>
         <input v-bind:name="getColumn(id, 'grade')" type="text" v-bind:value="ticket.grade">
      </div>

      <div class="sm-form">
         <label>料金</label>
         <input v-bind:name="getColumn(id, 'price')" type="text" v-bind:value="ticket.price">
      </div>

      <ul v-if=" inherit_mode == 'create' " class="item-icons">
         <li v-on:click="deleteNewItem(id)">取消<span class="btn"><i class="fa fa-times"></i></span></li>
      </ul>

   </div>

</template>

<script>
   import mixins from './mixins.js'
   export default {
      mixins: [ mixins ],
      props: {
         inherit_mode:     String,
         inherit_id:       Number,
         inherit_ticket:   Object,
      },
      data: function(){
         return {
            id:          this.inherit_id,
            ticket:      this.inherit_ticket
         }
      },
      methods: {
         getTagId: function(mode, id){
            return mode + '-' + id
         },
         deleteNewItem: function(id){
            var el = document.getElementById('create-' + id)
            el.parentNode.removeChild(el)
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
