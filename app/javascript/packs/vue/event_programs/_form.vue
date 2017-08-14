<template>
   <div v-bind:id="getTagId(ev_program.mode)" class="form-item">
      <input v-bind:name="getColumn(ev_program.element_id, 'type')" type="hidden" v-model:value="ev_program.mode">
      <input v-bind:name="getColumn(ev_program.element_id, 'id')" type="hidden" v-bind:value="ev_program.id">
      <input v-bind:name="getColumn(ev_program.element_id, 'event_id')" type="hidden" v-bind:value="ev_program.event_id">
      <div class="lg-form">
      <!-- FIXME: わかりやすいデザインにしたい(ボタンによる入力項目の拡張が行えるが、一目見ただけでは何を編集しているのかがわかりづらい) -->
         <label>演目</label>
         <input v-bind:id="getColumn(ev_program.element_id, 'title')" v-bind:name="getColumn(ev_program.element_id, 'title')" type="text" v-model:value="search_query.word">
         <programs-index
            v-bind:id="getTagId('index')"
            v-show="search_query.focus"
            :ih_programs="programs"
            :search_query="search_query.word"
            @return-value="setSearchValue"
         ></programs-index>
      </div>
      <div class="sm-form">
         <label>種類</label>
         <input v-bind:name="getColumn(ev_program.element_id, 'genre')" type="text" v-model:value="genre">
      </div>

      <div class="sm-form">
         <label>流派</label>
         <input v-bind:name="getColumn(ev_program.element_id, 'style')" type="text" v-model:value="style">
      </div>

      <ul v-if=" ev_program.mode == 'create' " class="item-icons">
         <li v-bind:id="getColumn(ev_program.element_id, 'delete')" v-on:click="deleteNewItem(ev_program.element_id)">取消<span class="btn"><i class="fa fa-times"></i></span></li>
      </ul>

   </div>

</template>

<script>
   import mixins from './mixins.js'
   import programs_index from '../programs/_index.vue'
   export default {
      mixins: [ mixins ],
      props: {
         ih_ev_program:  Object,
         ih_programs:    Array,
      },
      data: function(){
         return {
            ev_program:   this.ih_ev_program,
            genre:         this.ih_ev_program.genre,
            style:         this.ih_ev_program.style,
            programs:     this.ih_programs,
            search_query: { word: this.ih_ev_program.program.title, focus: false }
         }
      },
      components: { 'programs-index': programs_index },
      methods: {
         toggleSelector: function(event){
            var input_tag    = document.getElementById(this.getColumn(this.ev_program.element_id, 'title'))
            var selector_tag = document.getElementById(this.getTagId('index'))

            if(event.target == input_tag){
               this.search_query.focus = !this.search_query.focus
            }else if(!selector_tag.contains(event.target)){
               this.search_query.focus = false
            }
         },
         getTagId: function(mode){
            return mode + '-' + this.ev_program.element_id
         },
         deleteNewItem: function(id){
            console.log('deleteNewItem')
            var el = document.getElementById('create-' + id)
            el.parentNode.removeChild(el)
            window.removeEventListener('click', this.toggleSelector)
         },
         setSearchValue: function(return_msg){
            console.log('setSearchValue')
            this.search_query.word = return_msg
            this.search_query.focus = false
         },
         getColumn: mixins.getColumn
      },
      created: function(){
         window.addEventListener('click', this.toggleSelector)
      }
   }
</script>

<style scoped></style>
