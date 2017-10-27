import Vue from 'vue'
import VueResource from 'vue-resource'
Vue.use(VueResource)

document.addEventListener('DOMContentLoaded', () => {
   const AUTH_TOKEN = document.querySelector('meta[name=csrf-token]').content
   const nodes = document.getElementsByClassName('event-article-vue')

   for(let i = 0; i < nodes.length; i++){
      let node = nodes[i]
      let parsed_data = JSON.parse(node.getAttribute('data'))
      let bookmarked_vue = new Vue({
         el: '#event-' + parsed_data.id,
         data: function(){
            return {
               id:         parsed_data.id,
               bookmarked: parsed_data.bookmarked,
               count:      parsed_data.count
            }
         },
         methods: {
            refreshBookmark: function(response){
               this.$set(this, 'bookmarked', response.bookmarked)
               this.$set(this, 'count', response.count)
            },
            assignBookmark: function(){
               this.$http.patch('/bookmarks/' + this.id, { user_id: parsed_data.user }).then(response => {
                  this.refreshBookmark(response.body)
               })
            },
            cancelBookmark: function(){
               this.$http.delete('/bookmarks/' + this.id, { params: { user_id: parsed_data.user } }).then(response => {
                  this.refreshBookmark(response.body)
               })
            }
         }
      })
   }
})
