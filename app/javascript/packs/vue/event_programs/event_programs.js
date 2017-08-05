import Vue from 'vue'
import * as $ from 'jquery'
import mixins from './mixins.js'
import Edit from './edit.vue'
import New from './new.vue'

document.addEventListener('DOMContentLoaded', () => {

   // ListItem Vue instance
   const target_content = document.getElementById('event-programs-edit')
   if(target_content != null){

      const node = document.getElementById('event-programs-edit-vue')
      const values = JSON.parse(node.getAttribute('data'))
      // Vueコンポーネント上で扱いやすくするためにデータを修飾
      var id_num = 0
      for(var i = 0; i < values.event_programs.length; i++){
         // event_programs.programを直接追加
         var event_program_idx = values.event_programs[i].program_id
         values.event_programs[i].program = mixins.forInsert(values.programs, event_program_idx)
         values.event_programs[i].mode = ''
         values.event_programs[i].element_id = id_num
         // event_performers.performer.full_nameを直接追加
         for(var j = 0; j < values.event_performers[i].length; j++){
            var event_performer_idx = values.event_performers[i][j].performer_id
            values.event_performers[i][j].performer = mixins.forInsert(values.performers, event_performer_idx)
         }

         id_num += 1
      }

      var edit_item = new Vue({
         el: '#event-programs-edit-vue',
         render(h){
            return h(Edit, { props: { values: values } })
         }
      })

      // New Vue instance
      var new_values = {
                        programs: values.programs,
                        id_num:   id_num,
                        event_id: values.event.id
                        }

      var new_item = new Vue({
         el: '#event-programs-new',
         render(h){
            return h(New, { props: { values: new_values } })
         }
      })
   }
})
