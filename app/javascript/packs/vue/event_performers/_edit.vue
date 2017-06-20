<template>
   <div class="form-item">
      <div class="lg-form vertical-division">
         <label>演者：</label>
         <div class="vertical-section">
            <event-performers-form
               v-for="(ev_performer, per_idx) in ev_performers"
               :inherit_per_idx="per_idx"
               :inherit_pro_idx="pro_idx"
               :inherit_event_program="ev_program"
               :inherit_performer="ev_performer"
               :inherit_mode="mode"
            ></event-performers-form>
            <div v-bind:id="getTagId(ev_program.id)">
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
         inherit_pro_idx:             Number,
         inherit_ev_program:          Object,
         inherit_ev_performers:       Array,
      },
      data: function(){
         return {
            pro_idx:          this.inherit_pro_idx,
            ev_program:       this.inherit_ev_program,
            ev_performers:    this.inherit_ev_performers,
            new_idx:          this.inherit_ev_performers.length,
            mode:             "update"
         }
      },
      components: { 'event-performers-form': event_performers_form },
      methods: {
         getTagId: function(id){
            return 'new-' + id
         },
         addNewItem: function(){
            new Vue({
               el: '#new-' + this.ev_program.id + ' > .form-for-mount',
               data: {
                     pro_idx:          this.inherit_pro_idx,
                     ev_program:       this.inherit_ev_program,
                     ev_performers:    this.inherit_ev_performers,
                     new_idx:          this.new_idx,
                     mode:             "update"
                     },
               render(h){ return h(event_performers_form, { props: {
                                                                  inherit_per_idx: this.new_idx,
                                                                  inherit_pro_idx: this.pro_idx,
                                                                  inherit_event_program: this.ev_program,
                                                                  inherit_performer: { id: this.new_idx, ev_program_id: this.ev_program.id, full_name: '' },
                                                                  inherit_mode: 'create'
                                                                  }}) }
            })
            var node = document.createElement('div')
            node.className = "form-for-mount"
            document.getElementById('new-' + this.ev_program.id).appendChild(node)
            this.new_idx += 1
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
