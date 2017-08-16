<template>
   <div>
      <div id="new-items">
         <div class="form-for-mount"></div>
      </div>
      <ul class="item-icons">
         <li v-on:click="addNewItem()">チケットの追加<span class="btn"><i class="fa fa-plus"></i></span></li>
      </ul>
   </div>
</template>

<script>
   import Vue from 'vue'
   import mixins from '../mixins.js'
   import tickets_form from '../render/_form.vue'

   export default {
      props: [ 'values' ],
      data: function(){
         return {
            tag_id: this.values.id_num,
            event_id:  this.values.event_id
         }
      },
      components: { 'tickets-form': tickets_form },
      methods: {
         addNewItem: function(){
            new Vue({
               el: '.form-for-mount',
               data: {
                  ticket: {
                     event_id: this.event_id,
                     grade: '',
                     price: '',
                     mode: 'create',
                     tag_id: this.tag_id
                  }
               },
               render(h){ return h(tickets_form, { props: { ticket: this.ticket }}) }
            })
            var node = document.createElement('div')
            node.className = "form-for-mount"
            document.getElementById('new-items').appendChild(node)
            this.tag_id += 1
         }
      }
   }
</script>

<style scoped></style>
