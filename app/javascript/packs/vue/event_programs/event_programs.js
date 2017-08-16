import Vue from 'vue'
import * as $ from 'jquery'
import mixins from './mixins.js'
import Edit from './edit/edit.vue'
import New from './new/new.vue'

document.addEventListener('DOMContentLoaded', () => {

   // ListItem Vue instance
   const target_content = document.getElementById('event-programs-edit')
   if(target_content != null){

      const node = document.getElementById('event-programs-edit-vue')
      const parsed_data = JSON.parse(node.getAttribute('data'))
      // Vueコンポーネント上で扱いやすくするためにデータを修飾
      var event_programs = []
      var event_performers = []

      var id_num = 0
      for(var i = 0; i < parsed_data.event_programs.length; i++){
         // event_programs.programを直接追加
         var event_program_idx = parsed_data.event_programs[i].program_id

         // Vueコンポーネントで使うデータ
         var event_program = {
                              id:          parsed_data.event_programs[i].id,
                              event_id:    parsed_data.event_programs[i].event_id,
                              tag_id:      id_num,
                              mode:        '',
                              style:       parsed_data.event_programs[i].style,
                              genre:       parsed_data.event_programs[i].genre,
                              title:       mixins.forInsert(parsed_data.programs, event_program_idx).title
                             }
         event_programs.push(event_program)
         // event_performers.performer.full_nameを直接追加
         var event_program_child = []
         for(var j = 0; j < parsed_data.event_performers[i].length; j++){
            var event_performer_idx = parsed_data.event_performers[i][j].performer_id
            // Vueコンポーネントで使うデータ
            var event_performer = {
                                    id:         parsed_data.event_performers[i][j].id,
                                    full_name:  mixins.forInsert(parsed_data.performers, event_performer_idx).full_name
                                 }
            event_program_child.push(event_performer)
         }
         event_performers.push(event_program_child)
         id_num += 1
      }

      var values = {
                     event_programs:   event_programs,
                     event_performers: event_performers,
                     programs:         parsed_data.programs
                   }

      var edit_item = new Vue({
         el: '#event-programs-edit-vue',
         render(h){
            return h(Edit, { props: { values: values } })
         }
      })

      // New Vue instance
      var new_values = {
                        programs: parsed_data.programs,
                        tag_id:   id_num,
                        event_id: parsed_data.event.id
                        }

      var new_item = new Vue({
         el: '#event-programs-new-vue',
         render(h){
            return h(New, { props: { values: new_values } })
         }
      })
   }
})
