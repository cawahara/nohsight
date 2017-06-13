<template>
   <div v-bind:id="getTagId(inherit_mode, id)" class="form-item">
      <input v-bind:name="getColumn(id, 'type')" type="hidden" v-model:value="inherit_mode">
      <input v-bind:name="getColumn(id, 'id')" type="hidden" v-bind:value="ev_program.id">
      <div class="lg-form">
      <!-- FIXME: わかりやすいデザインにしたい(ボタンによる入力項目の拡張が行えるが、一目見ただけでは何を編集しているのかがわかりづらい) -->
         <label>演目</label>
         <input v-bind:name="getColumn(id, 'title')" type="text" v-model:value="search_query.word"
         v-focus="search_query.focus" @focus="search_query.focus = true">
         <programs-index
            v-show="search_query.focus == true"
            :search_query="search_query.word"
            @return-value="setSearchValue"
         ></programs-index>
      </div>
      <div class="sm-form">
         <label>種類</label>
         <input v-bind:name="getColumn(id, 'genre')" type="text" v-bind:value="ev_program.genre">
      </div>

      <div class="sm-form">
         <label>流派</label>
         <input v-bind:name="getColumn(id, 'style')" type="text" v-bind:value="ev_program.style">
      </div>

      <ul v-if=" inherit_mode == 'create' " class="item-icons">
         <li v-on:click="deleteNewItem(id)">取消<span class="btn"><i class="fa fa-times"></i></span></li>
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
         inherit_id:         Number,
         inherit_ev_program: Object,
         inherit_program:    Object,
         inherit_mode:       String
      },
      data: function(){
         return {
            id:                       this.inherit_id,
            ev_program:               this.inherit_ev_program,
            program:                  this.inherit_program,
            programs_edit_component:  false,
            search_query:              { word: this.inherit_program.title, focus: false }
         }
      },
      directives: { 'focus': focus },
      components: { 'programs-index': programs_index },
      methods: {
         getTagId: function(mode, id){
            return mode + '-' + id
         },
         deleteNewItem: function(id){
            var el = document.getElementById('create-' + id)
            el.parentNode.removeChild(el)
         },
         setSearchValue: function(return_msg){
            this.search_query.word = return_msg.title
            this.program = return_msg
            this.search_query.focus = false
         },
         getColumn: mixins.getColumn
      }
   }
</script>

<style scoped></style>
