<template>
   <div v-bind:id="getTagId(ticket.mode, ticket.element_id)" class="form-item">
      <input v-bind:name="getColumn(ticket.element_id, 'type')" type="hidden" v-model:value="ticket.mode">
      <input v-bind:name="getColumn(ticket.element_id, 'id')" type="hidden" v-bind:value="ticket.id">
      <input v-bind:name="getColumn(ticket.element_id, 'event_id')" type="hidden" v-bind:value="ticket.event_id">
      <!-- FIXME: わかりやすいデザインにしたい(ボタンによる入力項目の拡張が行えるが、一目見ただけでは何を編集しているのかがわかりづらい) -->
      <div class="sm-form">
         <label>客席</label>
         <input v-bind:name="getColumn(ticket.element_id, 'grade')" type="text" v-bind:value="ticket.grade">
      </div>

      <div class="sm-form">
         <label>料金</label>
         <input v-bind:name="getColumn(ticket.element_id, 'price')" type="text" v-bind:value="ticket.price">
      </div>

      <ul v-if=" ticket.mode == 'create' " class="item-icons">
         <li v-on:click="deleteNewItem(ticket.element_id)">取消<span class="btn"><i class="fa fa-times"></i></span></li>
      </ul>

   </div>

</template>

<script>
   import mixins from './mixins.js'
   export default {
      mixins: [ mixins ],
      props: {
         ih_ticket:   Object,
      },
      data: function(){
         return {
            ticket:  this.ih_ticket
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
