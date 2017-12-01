import Vue from 'vue'
import VueResource from 'vue-resource'
Vue.use(VueResource)

document.addEventListener('DOMContentLoaded', () => {
   function setJoinStatus(status){
      switch(status){
         case 0:
            return { code: true, text: '参加予定', class: 'planned' }
            break
         case 1:
            return { code: true, text: '参加済', class: 'joined' }
            break
         default:
            return { code: false, text: '参加を記録する', class: 'default' }
            break
      }
   }

   const AUTH_TOKEN = document.querySelector('meta[name=csrf-token]').content
   const nodes = document.getElementsByClassName('event-join-histories-vue')

   for(let i = 0; i < nodes.length; i++){
      let node = nodes[i]
      let parsed_data = JSON.parse(node.getAttribute('data'))
      parsed_data.status = setJoinStatus(parsed_data.status)
      let join_history_vue = new Vue({
         el: '#join-history-' + parsed_data.id,
         data: function(){
            return {
               id:         parsed_data.id,
               status:     parsed_data.status
            }
         },
         methods: {
            refreshJoinHistroy: function(response){
               this.$set(this, 'status', setJoinStatus(response.status))
            },
            assignJoinHistroy: function(){
               this.$http.patch('/join_histories/' + this.id, { user_id: parsed_data.user }).then(response => {
                  this.refreshJoinHistroy(response.body)
               })
            },
            cancelJoinHistroy: function(){
               this.$http.delete('/join_histories/' + this.id, { params: { user_id: parsed_data.user } }).then(response => {
                  this.refreshJoinHistroy(response.body)
               })
            }
         }
      })
   }
})
