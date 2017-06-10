<template>
   <div class="item-component" v-bind:class="mode">
      <div class="show-item" v-show="mode != 'update'">
         <p class="item-info">
            {{ ev_program.style }}
            {{ ev_program.genre }}
            「{{ program.title }}」
         </p>
         <ul class="item-performers">
            <li>演者： </li>
            <li v-for="ev_performer in ev_performers">{{ ev_performer.full_name }} </li>
         </ul>
      </div>

      <event-programs-form
         v-show="mode == 'update'"
         :inherit_id="id"
         :inherit_ev_program="ev_program"
         :inherit_program="program"
         :inherit_place="place"
         :inherit_mode="mode"
      ></event-programs-form>

      <ul class="item-icons">
         <li v-on:click="changeClass('update')">編集<span class="btn"><i class="fa fa-pencil"></i></span></li>
         <li v-on:click="changeClass('destroy')">削除<span class="btn"><i class="fa fa-trash"></i></span></li>
      </ul>
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
            id:               this.values.id,
            ev_program:       this.values.ev_program,
            ev_performers:    this.values.ev_performers,
            program:          this.values.program,
            place:            this.values.place,
            mode:             ''
         }
      },
      components: { 'event-programs-form': event_programs_form },
      methods: {
         changeClass: function(mode){
            if(this.mode == mode){
               this.mode = ""
            }else{
               this.mode = mode
            }
         },

         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
