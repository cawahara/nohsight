import Vue from 'vue'
import VueResource from 'vue-resource'
Vue.use(VueResource)

document.addEventListener('DOMContentLoaded', () => {
   const AUTH_TOKEN = document.querySelector('meta[name=csrf-token]').content
   const node = document.querySelector('#events')
   if(node != null){
      const event_nodes = document.getElementsByClassName('event-article-vue')
      for(let i = 0; i < event_nodes.length; i++){
         let parsed_data = JSON.parse(event_nodes[i].getAttribute('data'))
         let bookmarked_vue = new Vue({
            el: '#event-' + parsed_data.id + '> .tags',
            data: function(){
               return {
                  id:         parsed_data.id,
                  bookmarked: parsed_data.bookmarked
               }
            },
            methods: {
               assignBookmark: function(){
                  this.$http.patch('/bookmarks/' + this.id, { user_id: parsed_data.user }).then(response => {
                     this.$set(this, 'bookmarked', response.body)
                  })
               },
               cancelBookmark: function(){
                  this.$http.delete('/bookmarks/' + this.id, { params: { user_id: parsed_data.user } }).then(response => {
                     this.$set(this, 'bookmarked', response.body)
                  })
               }
            }
         })
      }
   }
})
