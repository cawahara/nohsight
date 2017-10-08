// "vue" folder including this file has all vue components.

import Vue from 'vue'
import * as $ from 'jquery'
import mixins from './mixins.js'
import Edit from './edit/edit.vue'

document.addEventListener('DOMContentLoaded', () => {

   // ListItem Vue instance
   const target_content = document.getElementById('event-performers-edit')
   if(target_content != null){
      const node = document.getElementById('event-performers-edit-vue')
      const parsed_data = JSON.parse(node.getAttribute('data'))

      var event_program_id_num = 0

      // Vueコンポーネント上で扱いやすくするためにデータを修飾
      var event_programs = []
      var event_performers = []

      // renderアクションの代わりに失敗時に送信したparamsを取得
      var render_ev_program_params
      var render_ev_performer_params
      var params_exist = false
      if(parsed_data.render_params != null){
         render_ev_program_params = parsed_data.render_params['event_program']
         params_exist = true
      }

      for(var i = 0; i < parsed_data.event_programs.length; i++){
         // event_program.programを直接追加
         var event_program_idx = parsed_data.event_programs[i].program_id

         var mode = ''
         if(params_exist == true){
            mode = render_ev_program_params[i.toString()].mode
         }

         // Vueコンポーネントで使うデータ
         var event_program = {
                              id:      parsed_data.event_programs[i].id,
                              tag_id:  event_program_id_num,
                              mode:    mode,
                              style:   parsed_data.event_programs[i].style,
                              genre:   parsed_data.event_programs[i].genre,
                              title:   mixins.forInsert(parsed_data.programs, event_program_idx).title,
                              render_params: params_exist == true ? render_ev_program_params[i.toString()] : false
                              }
         event_programs.push(event_program)
         // event_performers.performer.full_nameを直接追加
         var event_performer_id_num = 0
         var event_program_child = []

         if(params_exist == true){
            render_ev_performer_params = parsed_data.render_params['event_performer-' + i]
         }

         for(var j = 0; j < parsed_data.event_performers[i].length; j++){
            var event_performer_idx = parsed_data.event_performers[i][j].performer_id

            var mode = 'update'
            if(params_exist == true){
               mode = render_ev_performer_params[j.toString()].mode
            }
            // Vueコンポーネントで使うデータ
            var event_performer = {
                                    id:               parsed_data.event_performers[i][j].id,
                                    tag_id:           event_performer_id_num,
                                    mode:             mode,
                                    full_name:        mixins.forInsert(parsed_data.performers, event_performer_idx).full_name,
                                    render_params:    params_exist == true ? render_ev_performer_params[j.toString()] : false
                                 }
            event_program_child.push(event_performer)

            if(params_exist == true){
               delete(render_ev_performer_params[j.toString()])
            }
            event_performer_id_num += 1
         }

         if(params_exist == true){
            delete(render_ev_program_params[i.toString()])


            for(var key in render_ev_performer_params){
               var new_event_performer = {
                                          tag_id:           event_performer_id_num,
                                          mode:             'create',
                                          render_params:    params_exist == true ? render_ev_performer_params[key] : false
                                          }
               event_program_child.push(new_event_performer)
            }
         }
         event_performers.push(event_program_child)
         event_program_id_num += 1
      }
         var values = {
                        event_programs:   event_programs,
                        event_performers: event_performers,
                        performers:       parsed_data.performers
                      }

         var edit_item = new Vue({
            el: '#event-performers-edit-vue',
            render(h){
               return h(Edit, { props: { values: values } })
            }
         })
      }
})
