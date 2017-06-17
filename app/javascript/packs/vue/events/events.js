import Vue from 'vue'
import * as $ from 'jquery'
import EditPlace from './edit_place.vue'
import ShowLocations from './show_locations.vue'

document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('main').children[0]
   if(target_content == document.getElementById('event-place-edit')){
      $.ajax({
         url: '',
         type: 'GET',
         dataType: 'json',
         success: function(data){
            var data_event = data.event
            var data_place = data.place

            var edit = new Vue({
               el: '#event-place-' + data_event.id,
               data: function(){
                  return {
                     values: {
                        noh_event:  data_event,
                        place:      data_place
                     }
                  }
               },
               render(h){
                  return h(EditPlace, { props: { values: this.values } })
               }
            })
         },
         error: function(data){
            console.log("An error occured")
         }
      })
   }else if(target_content == document.getElementById('event-show')){

      function createNearbyElement(id, i){
         $.ajax({
            url: '',
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
         })
      }


      var ev_nearby_locations = document.getElementsByClassName('nearby-item')
      var clicked = []
      for(let i = 0; i < ev_nearby_locations.length; i++){
         clicked[i] = false
         ev_nearby_locations[i].addEventListener('click', () => {
            if(clicked[i] == false){
               createNearbyElement(ev_nearby_locations[i].id, i)
               clicked[i] = true
            }

         })
      }
   }
})
