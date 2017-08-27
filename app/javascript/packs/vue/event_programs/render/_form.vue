<template>
   <div v-bind:id="getTagId(mode)" class="form-item">
      <input v-bind:name="getColumn(tag_id, 'mode')" type="hidden" v-bind:value="ev_program.mode">
      <input v-bind:name="getColumn(tag_id, 'id')" type="hidden" v-bind:value="id">
      <input v-bind:name="getColumn(tag_id, 'event_id')" type="hidden" v-bind:value="event_id">
      <div class="lg-form">
      <!-- FIXME: わかりやすいデザインにしたい(ボタンによる入力項目の拡張が行えるが、一目見ただけでは何を編集しているのかがわかりづらい) -->
         <label>演目</label>
         <input v-bind:id="getColumn(tag_id, 'title')" v-bind:name="getColumn(tag_id, 'title')" type="text" v-model:value="search_query.word">

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
         <input v-bind:id="getColumn(tag_id, 'genre')" v-bind:name="getColumn(tag_id, 'genre')" type="text" v-model:value="genre">
      </div>

      <div class="sm-form">
         <label>種類</label>
         <input>
      </div>

      <ul v-if=" mode == 'create' " class="item-icons">
         <li v-bind:id="getColumn(tag_id, 'delete')" v-on:click="deleteNewItem(tag_id)">取消<span class="btn"><i class="fa fa-times"></i></span></li>
      </ul>

   </div>

</template>

<script>
   import mixins from '../mixins.js'
   import programs_index from '../../programs/_index.vue'
   export default {
      mixins: [ mixins ],
      props: {
         ev_program:  Object,
         programs:    Array,
      },
      data: function(){
         return {
            id:           this.ev_program.id,
            mode:         this.ev_program.mode,
            tag_id:       this.ev_program.tag_id,
            event_id:     this.ev_program.event_id,
            genre:        this.ev_program.genre,
            search_query: { word: this.ev_program.title, focus: false }
         }
      },
      components: { 'programs-index': programs_index },
      methods: {
         toggleSelector: function(event){
            var input_tag    = document.getElementById(this.getColumn(this.tag_id, 'title'))
            var selector_tag = document.getElementById(this.getTagId('index'))
            if(event.target == input_tag){
               this.search_query.focus = !this.search_query.focus
            }else if(!selector_tag.contains(event.target)){
               this.search_query.focus = false
            }
         },
         getTagId: function(mode){
            return mode + '-' + this.tag_id
         },
         deleteNewItem: function(id){
            var el = document.getElementById('create-' + id)
            el.parentNode.removeChild(el)
            window.removeEventListener('click', this.toggleSelector)
         },
         setSearchValue: function(return_msg){
            this.search_query.word = return_msg
            this.search_query.focus = false
         },
         getColumn: mixins.getColumn
      },
      mounted: function(){
         window.addEventListener('click', this.toggleSelector)

         if(this.ev_program.render_params != false){
            this.genre = this.ev_program.render_params.genre
            this.search_query.word = this.ev_program.render_params.title
            var input_columns = { genre: this.ev_program.render_params.genre,
                                  title: this.ev_program.render_params.title }

            for(var key in input_columns){
               if(input_columns[key].length == 0){
                  var input_tag = document.getElementById(this.getColumn(this.tag_id, key))
                  input_tag.className = 'field_with_errors'
               }
            }
         }
      }
   }
</script>

<style scoped></style>
