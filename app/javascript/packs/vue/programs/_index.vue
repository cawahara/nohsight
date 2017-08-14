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
         ih_programs:  Array,
         search_query: String
      },
      data: function(){
         return {
            grid_data: this.ih_programs
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
            console.log('setSearchValueFromProgram')
            this.$emit('return-value', value)
         }
      }
   }
</script>

<style scoped></style>
