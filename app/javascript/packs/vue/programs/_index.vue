<template>
   <div class="search-records">
      <ul>
         <li v-for="record in getSearchResponse(search_query)" v-on:click="setSearchValue(record.title)">{{ record.title }}</li>
      </ul>
   </div>
</template>

<script>
   import * as $ from 'jquery'
   export default {
      props: {
         ih_performers:  Array,
         search_query: String
      },
      data: function(){
         return {
            grid_data: this.ih_performers
         }
      },
      methods: {
         getSearchResponse: function(query){
            var arr = []
            var datas = this.grid_data
            var reg_query = new RegExp(query)
            for(var i = 0; i < datas.length; i++){
               var data = datas[i]
               if(query.length > 0 && reg_query.test(data.title)){
                  arr.push(data)
               }
            }
            console.log(arr)
            return arr
         },
         setSearchValue: function(value){
            this.$emit('return-value', value)
         }
      }
   }
</script>

<style scoped></style>
