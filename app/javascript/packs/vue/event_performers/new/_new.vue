<template>
   <div>
      <div v-bind:id="getTagId(ev_program.tag_id)">
         <div class="form-for-mount"></div>
      </div>
      <ul class="item-icons">
         <li v-on:click="addNewItem()">演者の追加<span class="btn"><i class="fa fa-plus"></i></span></li>
      </ul>
   </div>
</template>

<script>
   import Vue from 'vue'
   import mixins from '../mixins.js'
   import event_performers_form from '../render/_form.vue'
   export default {
      mixins: [ mixins ],
      props: {
         ev_program:        Object,
         performers:        Array,
         inherit_tag_id:    Number
      },
      data: function(){
         return {
            tag_id: this.inherit_tag_id
         }
      },
      methods: {
         getTagId: function(id){
            return 'new-items-' + id
         },
         addNewItem: function(){
            new Vue({
               el: '#new-items-' + this.ev_program.tag_id + ' > .form-for-mount',
               data: {
                     ev_program: this.ev_program,
                     ev_performer: {
                           full_name: '',
                           tag_id: this.tag_id,
                           mode: 'create'
                        },
                     performers: this.performers
                     },
               render(h){ return h(event_performers_form, { props: {
                                                                  ev_program: this.ev_program,
                                                                  ev_performer: this.ev_performer,
                                                                  performers: this.performers
                                                                  }}) }
            })
            var node = document.createElement('div')
            node.className = "form-for-mount"
            document.getElementById('new-items-' + this.ev_program.tag_id).appendChild(node)
            this.tag_id += 1
         }
      }
   }
</script>

<style scoped></style>
