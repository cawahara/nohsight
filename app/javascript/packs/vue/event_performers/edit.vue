<template>
   <div>
      <div v-for="(ev_program, ev_program_idx) in ev_programs">
         <div class="item-component" v-bind:class="ev_program.mode">
            <input v-bind:name="getColumn('event_program', ev_program.element_id, 'id')" type="hidden" v-model:value="ev_program.id">
            <input v-bind:name="getColumn('event_program', ev_program.element_id, 'type')" type="hidden" v-model:value="ev_program.mode">
            <div class="show-item">
               <p class="item-info">
                  {{ ev_program.style }}
                  {{ ev_program.genre }}
                  「{{ ev_program.program.title }}」
               </p>
               <ul class="item-performers" v-show="ev_program.mode != 'update'">
                  <li>演者： </li>
                  <li v-for="(ev_performer, ev_performer_idx) in ev_performers[ev_program_idx]">{{ ev_performer.performer.full_name }} </li>
               </ul>
            </div>
            
            <div class="edit-item">
               <event-performers-edit
                  v-show="ev_program.mode == 'update'"
                  :ih_ev_program="ev_program"
                  :ih_ev_performers="ev_performers[ev_program_idx]"
                  :ih_performers="performers"
               ></event-performers-edit>

            </div>
            <ul class="item-icons">
               <li v-on:click="changeClass('update', ev_program_idx)">編集<span class="btn"><i class="fa fa-pencil"></i></span></li>
            </ul>
         </div>
      </div>
   </div>
</template>

<script>
   import event_performers_edit from './_edit.vue'
   import mixins from './mixins.js'
   import { focus } from 'vue-focus'
   export default {
      mixins: [ mixins ],
      props: [ 'values' ],
      data: function(){
         return {
            ev_programs:   this.values.event_programs,
            ev_performers: this.values.event_performers,
            performers:    this.values.performers
         }
      },
      components: { 'event-performers-edit': event_performers_edit },
      directives: { 'focus': focus },
      methods: {
         changeClass: function(mode, ev_program_idx){
            if(this.ev_programs[ev_program_idx].mode == mode){
               this.ev_programs[ev_program_idx].mode = ""
            }else{
               this.ev_programs[ev_program_idx].mode = mode
            }
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped>

</style>
