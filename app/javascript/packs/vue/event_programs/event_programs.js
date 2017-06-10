// "vue" folder including this file has all vue components.

import Vue from 'vue'
import ListItem from './list_items.vue'
import New from './new.vue'

document.addEventListener('DOMContentLoaded', () => {
   // FIXME: ページの種類にかかわらずHTMLパースをかけてデータをとろうとしてしまうため、
   //        下記の対象タグ要素がないページにアクセスするとコンソール上に[Vue Warn]が発生する
   //        ページそのものに影響はないがエラーが表示されないようにしたい

   // ListItem Vue instance
   const added_items = document.getElementsByClassName('event-program-added-item')

   for(var i = 0; i < added_items.length; i++){
      const ev_program = JSON.parse(added_items[i].getAttribute('data-ev-program'))
      const ev_performers = JSON.parse(added_items[i].getAttribute('data-ev-performers'))
      const program = JSON.parse(added_items[i].getAttribute('data-program'))
      const place = JSON.parse(added_items[i].getAttribute('data-place'))

      var list_items = new Vue({
         el: '#' + added_items[i].children[0].id,
         data: function() {
            return {
               values: {
                  id:            i,
                  ev_program:    ev_program,
                  ev_performers: ev_performers,
                  program:       program,
                  place:         place
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

   // New Vue instance
   var new_item = new Vue({
      el: '#event-programs-new',
      render(h){
         return h(New)
      }
   })
})
