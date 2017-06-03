// "vue" folder including this file has all vue components.

import Vue from 'vue'
import Ev from './event_program.vue'
document.addEventListener('DOMContentLoaded', () => {
   const nodes = document.getElementsByClassName('added-item');

   for(var i = 0; i < nodes.length; i++){
      const ev_program = JSON.parse(nodes[i].getAttribute('data-ev-program'))
      const ev_performers = JSON.parse(nodes[i].getAttribute('data-ev-performers'))
      const program = JSON.parse(nodes[i].getAttribute('data-program'))

      var app = new Vue({
         el: '#' + nodes[i].children[0].id,
         data: function() {
            return {
               values: {
                  ev_program:    ev_program,
                  ev_performers: ev_performers,
                  program:       program
               }
            }
         },
         // REVIEW: componentsからrender属性に変更したら、Vueインスタンス中の
         //         データをコンポーネント上に渡すことができた。なぜ？
         render(h){
            return h(Ev, { props: { values: this.values } })
         }
      });
   }

});
