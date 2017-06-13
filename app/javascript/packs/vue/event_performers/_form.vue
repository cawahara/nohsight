<template>
   <div v-bind:class="mode">
      <input v-bind:name="getColumn('event_performer[' + inherit_pro_idx + ']', inherit_per_idx, 'id')" type="hidden" v-bind:value="ev_performer.id">
      <input v-bind:name="getColumn('event_performer[' + inherit_pro_idx + ']', inherit_per_idx, 'ev_program_id')" type="hidden" v-bind:value="ev_program.id">
      <input v-bind:name="getColumn('event_performer[' + inherit_pro_idx + ']', inherit_per_idx, 'type')" type="hidden" v-model:value="mode">
      <input v-bind:name="getColumn('event_performer[' + inherit_pro_idx + ']', inherit_per_idx, 'name')" type="text" v-model:value="search_performer.query"
      v-focus="search_performer.focus" @focus=" search_performer.focus = true ">
      <performers-index
         v-show="search_performer.focus == true"
         :search_query="search_performer.query"
         @return-value="setSearchValue"
      ></performers-index>
      <ul class="item-icons" v-if="inherit_mode != 'create'">
         <li v-on:click="switchMode()">削除<span class="btn"><i class="fa fa-minus"></i></span></li>
      </ul>
   </div>

</template>

<script>
   import mixins from './mixins.js'
   import { focus } from 'vue-focus'
   import performers_index from '../performers/_index.vue'
   export default {
      mixins: [ mixins ],
      props: {
         inherit_per_idx:           Number,
         inherit_pro_idx:           Number,
         inherit_event_program:     Object,
         inherit_performer:         Object,
         inherit_mode:              String
      },
      data: function(){
         return {
            ev_performer: this.inherit_performer,
            ev_program:   this.inherit_event_program,
            mode: this.inherit_mode,
            search_performer: { query: this.inherit_performer.full_name, focus: false }
         }
      },
      directives: { 'focus': focus },
      components: { 'performers-index': performers_index },
      methods: {
         setSearchValue: function(return_msg){
            this.search_performer.query = return_msg.full_name
            this.program = return_msg
            this.search_performer.focus = false
         },
         switchMode(){
            if(this.mode == 'update'){
               this.mode = 'destroy'
            }else if(this.mode == 'destroy'){
               this.mode = 'update'
            }
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
