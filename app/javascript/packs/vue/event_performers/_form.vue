<template>
   <div v-bind:id="getTagId(ev_program.id, ev_performer.element_id)" v-bind:class="ev_performer.mode" class="vertical-form">
      <div>
         <input v-bind:name="getColumn('event_performer[' + ev_program.element_id + ']', ev_performer.element_id, 'id')" type="hidden" v-bind:value="ev_performer.id">
         <input v-bind:name="getColumn('event_performer[' + ev_program.element_id + ']', ev_performer.element_id, 'ev_program_id')" type="hidden" v-bind:value="ev_program.id">
         <input v-bind:name="getColumn('event_performer[' + ev_program.element_id + ']', ev_performer.element_id, 'type')" type="hidden" v-model:value="ev_performer.mode">
         <input v-bind:name="getColumn('event_performer[' + ev_program.element_id + ']', ev_performer.element_id, 'name')" type="text" v-model:value="search_performer.query"
         v-focus="search_performer.focus" @focus=" search_performer.focus = true ">
         <ul class="item-icons">
            <li v-on:click="switchMode()" v-if="ev_performer.mode != 'create'">削除<span class="btn"><i class="fa fa-minus"></i></span></li>
            <li v-on:click="deleteNewItem(ev_program.id, ih_ev_performer.element_id)" v-if="ev_performer.mode == 'create'">取消<span class="btn"><i class="fa fa-minus"></i></span></li>
         </ul>
      </div>
      <performers-index
         v-show="search_performer.focus == true"
         :search_query="search_performer.query"
         :ih_performers="performers"
         @return-value="setSearchValue"
      ></performers-index>
   </div>

</template>

<script>
   import mixins from './mixins.js'
   import { focus } from 'vue-focus'
   import performers_index from '../performers/_index.vue'
   export default {
      mixins: [ mixins ],
      props: {
         ih_ev_program: Object,
         ih_ev_performer: Object,
         ih_performers: Array
      },
      data: function(){
         return {
            ev_program:   this.ih_ev_program,
            ev_performer: this.ih_ev_performer,
            performers:   this.ih_performers,
            search_performer: { query: this.ih_ev_performer.performer.full_name, focus: false }
         }
      },
      directives: { 'focus': focus },
      components: { 'performers-index': performers_index },
      methods: {
         setSearchValue: function(return_msg){
            this.search_performer.query = return_msg.full_name
            this.search_performer.focus = false
         },
         switchMode: function(){
            if(this.ev_performer.mode == 'update'){
               this.ev_performer.mode = 'destroy'
            }else if(this.ev_performer.mode == 'destroy'){
               this.ev_performer.mode = 'update'
            }
         },
         getTagId: function(ev_program_id, id){
            return 'create-' + ev_program_id +'-' + id
         },
         deleteNewItem: function(ev_program_id, id){
            var el = document.getElementById('create-' + ev_program_id + '-' + id)
            el.parentNode.removeChild(el)
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
