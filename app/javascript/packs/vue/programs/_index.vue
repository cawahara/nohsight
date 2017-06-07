<template>
   <div class="search-records">
      <ul>
         <li v-for="record in getSearchResponse(search_query)" v-on:click="setValue(record)">{{ record }}</li>
      </ul>
   </div>
</template>

<script>
   export default {
      props: {
         search_query:　String
      },
      data: function(){
         return {
            grid_data: []
         }
      },
      created: function(){
         // REVIEW: 主に子コンポーネントとして使われる為、親から連続してpropsを受け取らず、
         //         直接DOMを参照してデータを引き取る方法をとった
         var data_container = document.getElementById('program-items')
         var programs = JSON.parse(data_container.getAttribute('data-programs'))

         this.grid_data = programs
      },
      methods: {
         getSearchResponse: function(query){
            var arr = []
            var datas = this.grid_data
            var reg_query = new RegExp(query)
            for(var i = 0; i < datas.length; i++){
               var data = datas[i]
               if( query.length > 0 && reg_query.test(data.title)){
                  arr.push(data.title)
               }
            }
            return arr
         },
         setSearchValue: function(value){
            this.$emit('return-value', value)
         },
         getProgramInfo: function(){

         }
      }

   }
</script>

<style scoped>

</style>
