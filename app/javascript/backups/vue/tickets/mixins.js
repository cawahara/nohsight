export default {
   getColumn: function(id, name){
      return 'ticket[' + id + '][' + name + ']'
   },

   forInsert: function(array, idx){
      for(var key in array){
         if(array[key].id == idx){
            return array[key]
            break
         }
      }
   }
}
