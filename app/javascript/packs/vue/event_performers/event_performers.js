// "vue" folder including this file has all vue components.

import Vue from 'vue'
import * as $ from 'jquery'
import mixins from './mixins.js'
import ListItem from './list_items.vue'

document.addEventListener('DOMContentLoaded', () => {

   // ListItem Vue instance
   const target_content = document.getElementById('event-performers-edit')
   if(target_content != null){

      $.ajax({
         url: '',
         type: 'GET',
         dataType: 'json',
         success: function(data){

            var data_ev_programs = data.event_programs
            for(var i = 0; i < data_ev_programs.length; i++){

               var data_ev_program = data.event_programs[i]
               var data_performers = []
               var j = 0

               for(var key in data.event_performers){
                  if(data.event_performers[key].event_program_id == data_ev_program.id){
                     data_performers.push(mixins.forInsert(data.performers, data.event_performers[key].performer_id))
                     data_performers[j].id = data.event_performers[key].id
                     j += 1
                  }
               }

               var data_program = mixins.forInsert(data.programs, data_ev_program.program_id)

               var list_items = new Vue({
                  el: '#event-performer-' + data_ev_program.id,
                  data: function() {
                     return {
                        values: {
                           id:             i,
                           ev_program:     data_ev_program,
                           ev_performers:  data_performers,
                           program:        data_program
                        }
                     }
                  },
                  // REVIEW: componentsからrender属性に変更したら、Vueインスタンス中の
                  //         データを子コンポーネント上に渡すことができた。なぜ？
                  render(h){
                     return h(ListItem, { props: { values: this.values } })
                  }
               })
            }

         },
         error: function(data){
            console.log("An error occured")
         }
      })
   }

})
