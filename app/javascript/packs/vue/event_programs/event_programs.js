// "vue" folder including this file has all vue components.

import Vue from 'vue'
import * as $ from 'jquery'
import mixins from './mixins.js'
import ListItem from './list_items.vue'
import New from './new.vue'

document.addEventListener('DOMContentLoaded', () => {
   // FIXME: ページの種類にかかわらずHTMLパースをかけてデータをとろうとしてしまうため、
   //        下記の対象タグ要素がないページにアクセスするとコンソール上に[Vue Warn]が発生する
   //        ページそのものに影響はないがエラーが表示されないようにしたい

   // ListItem Vue instance

   const target_content = document.getElementById('event-programs-edit')
   if(target_content != null){

      $.ajax({
         url: '',
         type: 'GET',
         dataType: 'json',
         success: function(data){

            var id_num = 0
            var data_ev_programs = data.event_programs

            while(id_num < data_ev_programs.length){

               var data_ev_program     = data.event_programs[id_num]
               var data_performers     = []
               for(var key in data.event_performers){
                  if(data.event_performers[key].event_program_id == data_ev_program.id){
                     var tmp_performer = data.event_performers[key]
                     data_performers.push(mixins.forInsert(data.performers, tmp_performer.performer_id))
                  }
               }
               var data_program        = mixins.forInsert(data.programs, data_ev_program.program_id)
               var data_place          = mixins.forInsert(data.places, data_program.place_id)

               var list_items = new Vue({
                  el: '#event-program-' + data_ev_program.id,
                  data: function() {
                     return {
                        values: {
                           id:             id_num,
                           ev_program:     data_ev_program,
                           ev_performers:  data_performers,
                           program:        data_program,
                           place:          data_place
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
               el: '#event-programs-new',
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
