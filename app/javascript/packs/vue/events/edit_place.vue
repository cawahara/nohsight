<template>
   <div class="form-item">
      <input v-bind:name="getColumn('id')" type="hidden" v-bind:value="noh_event.id">
      <div class="lg-form">
         
         <label>演目</label>
         <input v-bind:name="getColumn('title')" type="text" v-model:value="search_query.word"
         v-focus="search_query.focus" @focus="search_query.focus = true">
         <places-index
            v-show="search_query.focus == true"
            :search_query="search_query.word"
            @return-value="setSearchValue"
         ></places-index>
      </div>
      <div class="lg-form">
         <label>種類</label>
         <input v-bind:name="getColumn('address')" type="text" v-model:value="place.address">
      </div>

      <div class="lg-form">
         <label>流派</label>
         <input v-bind:name="getColumn('official_url')" type="text" v-model:value="place.official_url">
      </div>

   </div>

</template>

<script>
   import { focus } from 'vue-focus'
   import places_index from '../places/_index.vue'
   export default {
      props: [ 'values'],
      data: function(){
         return {
            noh_event:        this.values.noh_event,
            place:            this.values.place,
            search_query:     { word: this.values.place.title, focus: false }
         }
      },
      directives: { 'focus': focus },
      components: { 'places-index': places_index },
      methods: {
         setSearchValue: function(return_msg){
            this.search_query.word = return_msg.title
            this.place = return_msg
            this.search_query.focus = false
         },
         getColumn: function(name){
            return 'event_place[' + name + ']'
         }
      }
   }
</script>

<style scoped></style>
