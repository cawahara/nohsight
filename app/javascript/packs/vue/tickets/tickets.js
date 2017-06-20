// "vue" folder including this file has all vue components.

import Vue from 'vue'
import * as $ from 'jquery'
import mixins from './mixins.js'
import ListItem from './list_items.vue'
import New from './new.vue'

document.addEventListener('DOMContentLoaded', () => {
   // ListItem Vue instance

   const target_content = document.getElementById('tickets-edit')
   if(target_content != null){

      $.ajax({
         url: '',
         type: 'GET',
         dataType: 'json',
         success: function(data){

            var id_num = 0
            var data_tickets = data.tickets
            while(id_num < data_tickets.length){

               var data_ticket     = data_tickets[id_num]

               var list_items = new Vue({
                  el: '#ticket-' + data_ticket.id,
                  data: function() {
                     return {
                        values: {
                           id:             id_num,
                           ticket:         data_ticket
                        }
                     }
                  },
                  // REVIEW: componentsからrender属性に変更したら、Vueインスタンス中の
                  //         データを子コンポーネント上に渡すことができた。なぜ？
                  render(h){
                     return h(ListItem, { props: { values: this.values } })
                  }
               })
               id_num += 1
            }

            // New Vue instance
            var new_item = new Vue({
               el: '#tickets-new',
               render(h){
                  return h(New, { props: { id_num: id_num } })
               }
            })

         },
         error: function(data){
            console.log("An error occured")
         }
      })
   }

})
