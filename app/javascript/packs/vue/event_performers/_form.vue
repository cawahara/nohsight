<template>
   <div v-bind:id="getTagId(ev_program.id, ev_performer.element_id)" v-bind:class="ev_performer.mode" class="vertical-form">
      <div>
         <input v-bind:name="getColumn('event_performer-' + ev_program.element_id, ev_performer.element_id, 'id')" type="hidden" v-bind:value="ev_performer.id">
         <input v-bind:name="getColumn('event_performer-' + ev_program.element_id, ev_performer.element_id, 'event_program_id')" type="hidden" v-bind:value="ev_program.id">
         <input v-bind:name="getColumn('event_performer-' + ev_program.element_id, ev_performer.element_id, 'type')" type="hidden" v-model:value="ev_performer.mode">
         <input v-bind:id="getColumn('event_performer-' + ev_program.element_id, ev_performer.element_id, 'full_name')"
          v-bind:name="getColumn('event_performer-' + ev_program.element_id, ev_performer.element_id, 'full_name')" type="text" v-model:value="search_performer.query">
         <ul class="item-icons">
            <li v-on:click="switchMode()" v-if="ev_performer.mode != 'create'">削除<span class="btn"><i class="fa fa-minus"></i></span></li>
            <li v-on:click="deleteNewItem(ev_program.id, ih_ev_performer.element_id)" v-if="ev_performer.mode == 'create'">取消<span class="btn"><i class="fa fa-minus"></i></span></li>
         </ul>
      </div>
      <performers-index
         v-bind:id="getTagId('index')"
         v-show="search_performer.focus"
         :search_query="search_performer.query"
         :ih_performers="performers"
         @return-value="setSearchValue"
      ></performers-index>
   </div>

</template>

<script>
   import mixins from './mixins.js'
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
      components: { 'performers-index': performers_index },
      methods: {
         toggleSelector: function(event){
            var input_tag    = document.getElementById(this.getColumn('event_performer[' + this.ev_program.element_id + ']', this.ev_performer.element_id, 'name'))
            var selector_tag = document.getElementById(this.getTagId('index'))

            if(event.target == input_tag){
               this.search_performer.focus = !this.search_performer.focus
            }else if(!selector_tag.contains(event.target)){
               this.search_performer.focus = false
            }
         },
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
            window.removeEventListener('click', this.toggleSelector)
         },
         getColumn: mixins.getColumn
      },
      created: function(){
         window.addEventListener('click', this.toggleSelector)
      }
   }
</script>

<style scoped></style>
