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
      // Vueコンポーネント上で扱いやすくするためにデータを修飾
      var tickets = []

      // renderアクションの代わりに失敗時に送信したparamsを取得
      var render_ticket_params
      var params_exist = false
      if(parsed_data.render_params != null){
         render_ticket_params = parsed_data.render_params['ticket']
         params_exist = true
      }
      var id_num = 0

      for(var i = 0; i < parsed_data.tickets.length; i++){

         var mode = params_exist == true ? render_ticket_params[i.toString()].mode : ''

         var ticket = {
                        id:       parsed_data.tickets[i].id,
                        event_id: parsed_data.tickets[i].event_id,
                        grade:    parsed_data.tickets[i].grade,
                        price:    parsed_data.tickets[i].price,
                        mode:     mode,
                        tag_id:   id_num,
                        render_params: params_exist == true ? render_ticket_params[i.toString()] : false
                      }

         tickets.push(ticket)

         if(params_exist == true){
            delete(render_ticket_params[i.toString()])
         }
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
                         event_id: parsed_data.event.id,
                         render_params:  params_exist == true ? render_ticket_params : false }

      var new_item = new Vue({
         el: '#tickets-new-vue',
         render(h){
            return h(New, { props: { values: new_values } })
         }
      })

   }

})
