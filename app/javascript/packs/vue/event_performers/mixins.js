export default {
   getColumn: function(field, id, name){
      return field + '[' + id + '][' + name + ']'
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
