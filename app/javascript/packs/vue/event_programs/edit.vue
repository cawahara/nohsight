<template>
   <div>
      <div v-for="(ev_program, idx) in ev_programs">
         <div class="item-component" v-bind:class="ev_program.mode">
            <div class="show-item" v-show="ev_program.mode != 'update'">
               <p class="item-info">
                  {{ ev_program.style }}
                  {{ ev_program.genre }}
                  「{{ ev_program.program.title }}」
               </p>
               <ul class="item-performers">
                  <li>演者： </li>
                  <li v-for="(ev_performer, performer_idx) in ev_performers[idx]">{{ ev_performer.performer.full_name }} </li>
               </ul>
            </div>

            <event-programs-form
               v-show="ev_program.mode == 'update'"
               :ih_ev_program="ev_program"
               :ih_programs="programs"
            ></event-programs-form>

            <ul class="item-icons">
               <li v-on:click="changeClass('update', idx)">編集<span class="btn"><i class="fa fa-pencil"></i></span></li>
               <li v-on:click="changeClass('destroy', idx)">削除<span class="btn"><i class="fa fa-trash"></i></span></li>
            </ul>
         </div>
      </div>
   </div>
</template>

<script>
   import mixins from './mixins.js'
   import event_programs_form from './_form.vue'
   export default {
      props: [ 'values' ],
      mixins: [ mixins ],
      data: function(){
         return {
            ev_programs:    this.values.event_programs,
            ev_performers:  this.values.event_performers,
            programs:       this.values.programs
         }
      },
      components: { 'event-programs-form': event_programs_form },
      methods: {
         changeClass: function(mode, idx){
            if(this.ev_programs[idx].mode == mode){
               this.ev_programs[idx].mode = ""
            }else{
               this.ev_programs[idx].mode = mode
            }
         },

         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
