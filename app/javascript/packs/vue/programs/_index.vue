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
         search_query: String
      },
      data: function(){
         return {
            grid_data: []
         }
      },
      created: function(){
         var self = this
         $.ajax({
            url: '',
            type: 'GET',
            dataType: 'json',
            success: function(data){
               self.grid_data = data.programs
            },
            error: function(data){
               console.log('An error occured')
            }
         })
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
