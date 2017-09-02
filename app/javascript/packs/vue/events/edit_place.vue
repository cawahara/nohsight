<template>
   <div class="form-item">
      <input v-bind:name="getColumn('id')" type="hidden" v-bind:value="noh_event.id">
      <input v-bind:name="getColumn('mode')" type="hidden" value="update">
      <div class="lg-form">
         <label>地名</label>
         <input v-bind:name="getColumn('title')" v-bind:id="getColumn('title')" type="text" v-model:value="search_query.word">
         <places-index
            id="index"
            v-show="search_query.focus"
            :search_query="search_query.word"
            :pa_places="values.places"
            @return-value="setSearchValue"
         ></places-index>
      </div>
      <div class="lg-form">
         <label>住所</label>
         <input v-bind:name="getColumn('address')" v-bind:id="getColumn('address')" type="text" v-model:value="place.address">
      </div>

      <div class="lg-form">
         <label>公式サイト</label>
         <input v-bind:name="getColumn('official_url')" v-bind:id="getColumn('official_url')" type="text" v-model:value="place.official_url">
      </div>

   </div>

</template>

<script>
   import places_index from '../places/_index.vue'
   export default {
      props: [ 'values' ],
      data: function(){
         return {
            noh_event:     this.values.event,
            place:         this.values.place,
            search_query:  { word: this.values.place.title, focus: false }
         }
      },
      components: { 'places-index': places_index },
      methods: {
         toggleSelector: function(event){
            var input_tag    = document.getElementById(this.getColumn('title'))
            var selector_tag = document.getElementById('index')
            if(event.target == input_tag){
               this.search_query.focus = !this.search_query.focus
            }else if(!selector_tag.contains(event.target)){
               this.search_query.focus = false
            }
         },
         setSearchValue: function(return_msg){
            this.search_query.word = return_msg.title
            this.place = return_msg
            this.search_query.focus = false
         },
         getColumn: function(name){
            return 'event_place[' + name + ']'
         }
      },
      mounted: function(){
         window.addEventListener('click', this.toggleSelector)

         if(this.values.render_params != false){
            this.search_query.word = this.place.render_params.title
            this.place.address = this.place.render_params.address
            this.place.official_url = this.place.render_params.official_url

            var input_columns = { title:   this.place.render_params.title,
                                  address: this.place.render_params.address }
            for(var key in input_columns){
               if(input_columns[key].length == 0){
                  var input_tag = document.getElementById(this.getColumn(key))
                  input_tag.className = 'field_with_errors'
               }
            }
         }
      }
   }
</script>

<style scoped></style>
