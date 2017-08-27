<template>
   <div v-bind:id="getTagId(ev_program.id, tag_id)" v-bind:class="mode" class="vertical-form">
      <div>
         <input v-bind:name="getColumn('event_performer-' + ev_program.tag_id, tag_id, 'id')" type="hidden" v-bind:value="id">
         <input v-bind:name="getColumn('event_performer-' + ev_program.tag_id, tag_id, 'event_program_id')" type="hidden" v-bind:value="ev_program.id">
         <input v-bind:name="getColumn('event_performer-' + ev_program.tag_id, tag_id, 'mode')" type="hidden" v-model:value="mode">
         <input v-bind:id="getColumn('event_performer-' + ev_program.tag_id, tag_id, 'full_name')"
          v-bind:name="getColumn('event_performer-' + ev_program.tag_id, tag_id, 'full_name')" type="text" v-model:value="search_query.word">
         <ul class="item-icons">
            <li v-on:click="switchMode()" v-if="mode != 'create'">削除<span class="btn"><i class="fa fa-minus"></i></span></li>
            <li v-on:click="deleteNewItem(ev_program.id, tag_id)" v-if="mode == 'create'">取消<span class="btn"><i class="fa fa-minus"></i></span></li>
         </ul>
      </div>
      <performers-index
         v-bind:id="getTagId('index')"
         v-show="search_query.focus"
         :search_query="search_query.word"
         :performers="performers"
         @return-value="setSearchValue"
      ></performers-index>
   </div>

</template>

<script>
   import mixins from '../mixins.js'
   import performers_index from '../../performers/_index.vue'
   export default {
      mixins: [ mixins ],
      props: {
         ev_program: Object,
         ev_performer: Object,
         performers: Array
      },
      data: function(){
         return {
            id:           this.ev_performer.id,
            mode:         this.ev_performer.mode,
            tag_id:       this.ev_performer.tag_id,
            search_query: { word: this.ev_performer.full_name, focus: false }
         }
      },
      components: { 'performers-index': performers_index },
      methods: {
         toggleSelector: function(event){
            var input_tag    = document.getElementById(this.getColumn('event_performer-' + this.ev_program.tag_id, this.tag_id, 'full_name'))
            var selector_tag = document.getElementById(this.getTagId('index'))

            if(event.target == input_tag){
               this.search_query.focus = !this.search_query.focus
            }else if(!selector_tag.contains(event.target)){
               this.search_query.focus = false
            }
         },
         setSearchValue: function(return_msg){
            this.search_query.word = return_msg.full_name
            this.search_query.focus = false
         },
         switchMode: function(){
            if(this.mode == 'update'){
               this.mode = 'destroy'
               this.search_query.word = this.ev_performer.full_name
            }else if(this.mode == 'destroy'){
               this.mode = 'update'
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
      mounted: function(){
         window.addEventListener('click', this.toggleSelector)

         if(this.ev_performer.render_params != false){
            this.search_query.word = this.ev_performer.render_params.full_name

            if(this.ev_performer.render_params.full_name.length == 0){
               var input_tag = document.getElementById(this.getColumn('event_performer-' + this.ev_program.tag_id, this.tag_id, 'full_name'))
               input_tag.className = 'field_with_errors'
            }
         }
      }
   }
</script>

<style scoped></style>
