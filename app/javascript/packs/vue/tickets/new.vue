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
   import mixins from './mixins.js'
   import tickets_form from './_form.vue'

   export default {
      props: { id_num: Number },
      data: function(){
         return {
            values: { id: this.id_num }
         }
      },
      components: { 'tickets-form': tickets_form },
      methods: {
         addNewItem: function(){
            new Vue({
               el: '.form-for-mount',
               data: { id: this.values.id },
               render(h){ return h(tickets_form, { props: {
                                                            inherit_mode: 'create',
                                                            inherit_id:    this.id,
                                                            inherit_ticket:   {}
                                                                  }}) }
            })
            var node = document.createElement('div')
            node.className = "form-for-mount"
            document.getElementById('new-items').appendChild(node)
            this.values.id += 1
         }
      }
   }
</script>

<style scoped></style>
