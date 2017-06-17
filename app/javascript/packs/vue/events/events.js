import Vue from 'vue'
import * as $ from 'jquery'
import EDIT from './edit_place.vue'

document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('event-place-edit')
   if(target_content != null){

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
                  return h(EDIT, { props: { values: this.values } })
               }
            })
         },
         error: function(data){
            console.log("An error occured")
         }
      })
   }
})
