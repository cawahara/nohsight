// "vue" folder including this file has all vue components.

import Vue from 'vue'
import * as $ from 'jquery'
import mixins from './mixins.js'
import Edit from './edit.vue'
import New from './new.vue'

document.addEventListener('DOMContentLoaded', () => {
   // ListItem Vue instance

   const target_content = document.getElementById('tickets-edit')
   if(target_content != null){
      const node = document.getElementById('tickets-edit-vue')
      const values = JSON.parse(node.getAttribute('data'))
      var id_num = 0
      for(var i = 0; i < values.tickets.length; i++){
         values.tickets[i].mode = ''
         values.tickets[i].element_id = id_num

         id_num += 1
      }

      var edit_item = new Vue({
         el: '#tickets-edit-vue',
         render(h){
            return h(Edit, { props: { values: values } })
         }
      })

      var new_values = { id_num: id_num,
                         event_id: values.event.id }
      var new_item = new Vue({
         el: '#tickets-new',
         render(h){
            return h(New, { props: { values: new_values } })
         }
      })

   }

})
