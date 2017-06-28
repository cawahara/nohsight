<template>
   <div class="form-item">
      <div class="lg-form vertical-division">
         <label>演者：</label>
         <div class="vertical-section">
            <event-performers-form
               v-for="(ev_performer, ev_performer_idx) in ev_performers"
               :ih_ev_program="ev_program"
               :ih_ev_performer="ev_performer"
               :ih_performers="performers"
            ></event-performers-form>

            <div v-bind:id="getTagId(ev_program.element_id)">
               <div class="form-for-mount"></div>
            </div>
         </div>
         <ul class="item-icons">
            <li v-on:click="addNewItem()">演者の追加<span class="btn"><i class="fa fa-plus"></i></span></li>
         </ul>
      </div>
   </div>
</template>

<script>
   import Vue from 'vue'
   import mixins from './mixins.js'
   import event_performers_form from './_form.vue'
   export default {
      mixins: [ mixins ],
      props: {
         ih_ev_program:    Object,
         ih_ev_performers: Array,
         ih_performers:    Array
      },
      data: function(){
         return {
            ev_program:    this.ih_ev_program,
            ev_performers: this.ih_ev_performers,
            performers:    this.ih_performers,
            element_id:    this.ih_ev_performers.length
         }
      },
      components: { 'event-performers-form': event_performers_form },
      methods: {
         getTagId: function(id){
            return 'new-items-' + id
         },

         addNewItem: function(){
            new Vue({
               el: '#new-items-' + this.ev_program.element_id + ' > .form-for-mount',
               data: {
                     ev_program: this.ev_program,
                     ev_performer: {
                           performer: { full_name: '' },
                           element_id: this.element_id,
                           mode: 'create'
                        },
                     performers: this.performers
                     },
               render(h){ return h(event_performers_form, { props: {
                                                                  ih_ev_program: this.ev_program,
                                                                  ih_ev_performer: this.ev_performer,
                                                                  ih_performers: this.performers
                                                                  }}) }
            })
            var node = document.createElement('div')
            node.className = "form-for-mount"
            document.getElementById('new-items-' + this.ev_program.element_id).appendChild(node)
            this.element_id += 1
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
