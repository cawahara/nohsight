// "vue" folder including this file has all vue components.

import Vue from 'vue'
import * as $ from 'jquery'
import mixins from './mixins.js'
import Edit from './edit.vue'

document.addEventListener('DOMContentLoaded', () => {

   // ListItem Vue instance
   const target_content = document.getElementById('event-performers-edit')
   if(target_content != null){
         const node = document.getElementById('event-performers-edit-vue')
         const values = JSON.parse(node.getAttribute('data'))
         // Vueコンポーネント上で扱いやするするためにデータを修飾
         var event_program_id_num = 0
         for(var i = 0; i < values.event_programs.length; i++){
            // event_program.programを直接追加
            var event_program_idx = values.event_programs[i].program_id
            values.event_programs[i].program = mixins.forInsert(values.programs, event_program_idx)
            values.event_programs[i].mode = ''
            values.event_programs[i].element_id = event_program_id_num
            // event_performers.performer.full_nameを直接追加
            var event_performer_id_num = 0
            for(var j = 0; j < values.event_performers[i].length; j++){
               var event_performer_idx = values.event_performers[i][j].performer_id
               values.event_performers[i][j].performer = mixins.forInsert(values.performers, event_performer_idx)
               values.event_performers[i][j].mode = 'update'
               values.event_performers[i][j].element_id = event_performer_id_num
               event_performer_id_num += 1
            }

            event_program_id_num += 1
         }

            var edit_item = new Vue({
               el: '#event-performers-edit-vue',
               render(h){
                  return h(Edit, { props: { values: values } })
               }
            })
         }

})
