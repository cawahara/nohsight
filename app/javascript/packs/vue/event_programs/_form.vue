<template>
   <div v-bind:id="getTagId(ev_program.mode)" class="form-item">
      <input v-bind:name="getColumn(ev_program.element_id, 'type')" type="hidden" v-model:value="ev_program.mode">
      <input v-bind:name="getColumn(ev_program.element_id, 'id')" type="hidden" v-bind:value="ev_program.id">
      <div class="lg-form">
      <!-- FIXME: わかりやすいデザインにしたい(ボタンによる入力項目の拡張が行えるが、一目見ただけでは何を編集しているのかがわかりづらい) -->
         <label>演目</label>
         <input v-bind:name="getColumn(ev_program.element_id, 'title')" type="text" v-model:value="search_query.word"
         v-focus="search_query.focus" @focus="search_query.focus = true">
         <programs-index
            v-show="search_query.focus == true"
            :ih_programs="programs"
            :search_query="search_query.word"
            @return-value="setSearchValue"
         ></programs-index>
      </div>
      <div class="sm-form">
         <label>種類</label>
         <input v-bind:name="getColumn(ev_program.element_id, 'genre')" type="text" v-bind:value="ev_program.genre">
      </div>

      <div class="sm-form">
         <label>流派</label>
         <input v-bind:name="getColumn(ev_program.element_id, 'style')" type="text" v-bind:value="ev_program.style">
      </div>

      <ul v-if=" ev_program.mode == 'create' " class="item-icons">
         <li v-on:click="deleteNewItem(ev_program.element_id)">取消<span class="btn"><i class="fa fa-times"></i></span></li>
      </ul>

   </div>

</template>

<script>
   import mixins from './mixins.js'
   import { focus } from 'vue-focus'
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
            programs:     this.ih_programs,
            search_query: { word: this.ih_ev_program.program.title, focus: false }
         }
      },
      created: function(){
         console.log(this.ih_ev_program)
      },
      directives: { 'focus': focus },
      components: { 'programs-index': programs_index },
      methods: {
         getTagId: function(mode){
            return mode + '-' + this.ev_program.element_id
         },
         deleteNewItem: function(id){
            var el = document.getElementById('create-' + id)
            el.parentNode.removeChild(el)
         },
         setSearchValue: function(return_msg){
            this.search_query.word = return_msg
            this.search_query.focus = false
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
