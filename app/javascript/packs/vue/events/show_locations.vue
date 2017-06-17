<template>

   <div>
      <div class="nearby_location">
         <img src="">
         <ul>
            <li></li>
            <li></li>
         </ul>
      </div>
   </div>

</template>

<script>
   import * as $ from 'jquery'
   export default {
      props: [ 'values' ],
      data: function(){
         return {
            address: this.values.ev_location,
            locations: []
         }
      },
      created: function(){
         /*$.ajax({
            url: 'https://maps.googleapis.com/maps/api/geocode/json?address=#{location.address}&key=#{ENV['GOOGLE_API_KEY']}"',
            type: 'GET',
            dataType: 'json',
            success: function(data){
               var data_location = data.locations[i]

               var nearby_location = new Vue({
                  el: '#' + id + '> ul',
                  data: function(){
                     return {
                        values: {
                           ev_location: data_location
                        }
                     }
                  },
                  render(h){
                     return h(ShowLocations, { props: { values: this.values } })
                  }
               })
            },
            error: function(data){
               console.log("An error occured")
            }
         }) */
         console.log(ENV['GOOGLE_API_KEY'])
      }
   }

</script>

<style scoped></style>
