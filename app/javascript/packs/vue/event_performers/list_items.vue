<template>
   <div class="item-component" v-bind:class="mode">
      <input v-bind:name="getColumn('event_program', pro_idx, 'id')" type="hidden" v-model:value="ev_program.id">
      <input v-bind:name="getColumn('event_program', pro_idx, 'type')" type="hidden" v-model:value="mode">
      <div class="show-item">
         <p class="item-info">
            {{ ev_program.style }}
            {{ ev_program.genre }}
            「{{ program.title }}」
         </p>
         <ul class="item-performers" v-show="mode != 'update'">
            <li>演者： </li>
            <li v-for="ev_performer in ev_performers">{{ ev_performer.full_name }} </li>
         </ul>
      </div>

      <div class="edit-item">
         <event-performers-edit
            v-show="mode == 'update'"
            :inherit_pro_idx="pro_idx"
            :inherit_ev_program="ev_program"
            :inherit_ev_performers="ev_performers"
         ></event-performers-edit>
      </div>
      <ul class="item-icons">
         <li v-on:click="changeClass('update')">編集<span class="btn"><i class="fa fa-pencil"></i></span></li>
      </ul>
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
            pro_idx:           this.values.id,
            ev_program:        this.values.ev_program,
            ev_performers:     this.values.ev_performers,
            program:           this.values.program,
            mode:              ''
         }
      },
      components: { 'event-performers-edit': event_performers_edit },
      directives: { 'focus': focus },
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

<style scoped>

</style>
