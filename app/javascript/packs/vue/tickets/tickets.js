// "vue" folder including this file has all vue components.

import Vue from 'vue'
import * as $ from 'jquery'
import mixins from './mixins.js'
import Edit from './edit/edit.vue'
import New from './new/new.vue'

document.addEventListener('DOMContentLoaded', () => {
   // ListItem Vue instance

   const target_content = document.getElementById('tickets-edit')
   if(target_content != null){
      const node = document.getElementById('tickets-edit-vue')
      const parsed_data = JSON.parse(node.getAttribute('data'))
      var id_num = 0

      var tickets = []
      for(var i = 0; i < parsed_data.tickets.length; i++){

         var ticket = {
                        id:       parsed_data.tickets[i].id,
                        event_id: parsed_data.tickets[i].event_id,
                        grade:    parsed_data.tickets[i].grade,
                        price:    parsed_data.tickets[i].price,
                        mode:     '',
                        tag_id:   id_num
                      }

         tickets.push(ticket)
         id_num += 1
      }

      var values = { tickets: tickets }

      var edit_item = new Vue({
         el: '#tickets-edit-vue',
         render(h){
            return h(Edit, { props: { values: values } })
         }
      })

      var new_values = { id_num: id_num,
                         event_id: parsed_data.event.id }
      var new_item = new Vue({
         el: '#tickets-new-vue',
         render(h){
            return h(New, { props: { values: new_values } })
         }
      })

   }

})
