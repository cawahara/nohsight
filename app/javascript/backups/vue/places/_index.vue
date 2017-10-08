<template>
   <div class="search-records">
      <ul>
         <li v-for="record in getSearchResponse(search_query)" v-on:click="setSearchValue(record)">{{ record.title }}</li>
      </ul>
   </div>
</template>

<script>
   import * as $ from 'jquery'
   export default {
      props: {
         search_query: String,
         pa_places:    Array
      },
      data: function(){
         return {
            grid_data: this.pa_places
         }
      },
      methods: {
         getSearchResponse: function(query){
            var arr = []
            var datas = this.grid_data
            for(var i = 0; i < datas.length; i++){
               var data = datas[i]
               if(query.length > 0 && data.title.includes(query)){
                  arr.push(data)
               }
            }
            return arr
         },
         setSearchValue: function(value){
            this.$emit('return-value', value)
         }
      }

   }
</script>

<style scoped>

</style>
