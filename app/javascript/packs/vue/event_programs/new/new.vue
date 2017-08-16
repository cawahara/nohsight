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
   import mixins from '../mixins.js'
   import event_programs_form from '../render/_form.vue'

   export default {
      props: [ 'values' ],
      data: function(){
         return {
               programs:   this.values.programs,
               tag_id:     this.values.id_num,
               event_id:   this.values.event_id
         }
      },
      components: { 'event-programs-form': event_programs_form },
      methods: {
         addNewItem: function(){
            new Vue({
               el: '.form-for-mount',
               data: {
                      ev_program: {
                        event_id:    this.event_id,
                        tag_id:      this.tag_id,
                        mode:        'create',
                        style:       '',
                        genre:       '',
                        title:       ''
                     },
                      programs: this.values.programs
                  },
               render(h){
                  return h(event_programs_form, { props: {
                                                            ev_program:   this.ev_program,
                                                            programs:     this.programs
                                                         }}) }
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
