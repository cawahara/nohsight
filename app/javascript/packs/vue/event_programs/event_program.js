// "vue" folder including this file has all vue components.

import Vue from 'vue'
import ListItem from './list-items.vue'
import Edit from './edit.vue'

document.addEventListener('DOMContentLoaded', () => {

   // ListItem Vue instance
   const added_items = document.getElementsByClassName('added-item');
   for(var i = 0; i < added_items.length; i++){
      const ev_program = JSON.parse(added_items[i].getAttribute('data-ev-program'))
      const ev_performers = JSON.parse(added_items[i].getAttribute('data-ev-performers'))
      const program = JSON.parse(added_items[i].getAttribute('data-program'))

      var list_items = new Vue({
         el: '#' + added_items[i].children[0].id,
         data: function() {
            return {
               values: {
                  id:            i,
                  ev_program:    ev_program,
                  ev_performers: ev_performers,
                  program:       program
               }
            }
         },
         // REVIEW: componentsからrender属性に変更したら、Vueインスタンス中の
         //         データをコンポーネント上に渡すことができた。なぜ？
         render(h){
            return h(ListItem, { props: { values: this.values } })
         }
      });
   }



   // Edit Vue instance

});
