<template>
   <div>
      <div id="new-items">
         <div class="form-for-mount"></div>
      </div>
      <ul class="item-icons">
         <li v-on:click="addNewItem()">演目の追加<span class="btn"><i class="fa fa-plus"></i></span></li>
      </ul>
   </div>
</template>

<script>
   import Vue from 'vue'
   import mixins from './mixins.js'
   import event_programs_form from './_form.vue'

   export default {
      props: [ 'values' ],
      data: function(){
         return {
               programs: this.values.programs,
               element_id: this.values.id_num
         }
      },
      components: { 'event-programs-form': event_programs_form },
      methods: {
         addNewItem: function(){
            new Vue({
               el: '.form-for-mount',
               data: {ev_program: {
                        style: '',
                        genre: '',
                        mode: 'create',
                        element_id: this.element_id,
                        program: { title: '' }
                     },
                      programs: this.values.programs
                  },
               render(h){
                  return h(event_programs_form, { props: {
                                                            ih_ev_program:   this.ev_program,
                                                            ih_programs:     this.programs
                                                         }}) }
            })

            var node = document.createElement('div')
            node.className = "form-for-mount"
            document.getElementById('new-items').appendChild(node)
            this.element_id += 1
         }
      }
   }
</script>

<style scoped></style>
