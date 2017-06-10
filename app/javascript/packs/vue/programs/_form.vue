<template>
   <div>
      <div class="form-pointer"><div></div></div>
      <div class="form-item sub-form program-form">
         <h3 class="form-header">■演目の詳細情報</h3>
         <ul class="list-form">
            <li class="with-category">
               <label>曲目</label>
               <input v-bind:name="getColumn(id, 'category')" type="text" v-bind:value="inherit_program.category">
            </li>
            <li class="with-duration">
               <label>公演時間</label>
               <input v-bind:name="getColumn(id, 'duration')" type="text" v-bind:value="inherit_program.duration">
            </li>
            <li class="with-shimai">
               <label>仕舞</label>
               <input v-bind:name="getColumn(id, 'shimai')" type="checkbox" v-bind:value="inherit_program.shimai"
                v-bind:true-value="true" v-bind:false-value="false">
            </li>
         </ul>

         <div class="lg-form">
            <label>舞台</label>
            <div class="input-with-btn">
               <input v-bind:name="getColumn(id, 'place')" type="text" v-model:value="search_query.word"
               v-focus="search_query.focus" @focus="search_query.focus = true">
               <span v-bind:class="{ active: places_edit_component }" class="btn" v-on:click="toggleComponent()"><i class="fa fa-map-marker"></i></span>
               <places-index
                  v-show="search_query.focus == true"
                  :search_query="search_query.word"
                  @return-value="setSearchValue"
               ></places-index>
            </div>
         </div>

         <places-edit
            v-show="places_edit_component == true"
            :inherit_id="id"
            :inherit_place="place"
         ></places-edit>

      </div>
   </div>
</template>

<script>
   import mixins from '../event_programs/mixins.js'
   import { focus } from 'vue-focus'
   import places_index from '../places/_index.vue'
   import places_edit from '../places/_form.vue'

   export default {
      props: {
         inherit_id:         Number,
         inherit_program:    Object,
         inherit_place:      Object
      },
      data: function(){
         return {
            id:                     this.inherit_id,
            program:                this.inherit_program,
            place:                  this.inherit_place,
            places_edit_component:  false,
            search_query:           { word: this.inherit_place.title, focus: false }
         }
      },
      directives: { 'focus': focus },
      components: {
         'places-index': places_index,
         'places-edit':  places_edit
      },
      methods: {
         toggleComponent: function(){
            if(this.places_edit_component == false){
               this.places_edit_component = true
            }else{
               this.places_edit_component = false
            }
         },
         setSearchValue: function(return_msg){
            this.search_query.word = return_msg.title
            this.place = return_msg
            this.search_query.focus = false
         },
         getColumn: mixins.getColumn
      }
   }

</script>

<style scoped></style>
