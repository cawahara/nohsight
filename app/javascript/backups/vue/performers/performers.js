import Vue from 'vue'
import * as $ from 'jquery'
import Thumbnail from './thumbnail.vue'

function getThumbnail(url){
   return new Promise(function(resolve, reject){
      var req = new XMLHttpRequest()
      req.open('GET', url, true)

      req.addEventListener('load', function(event){
         if(req.status === 200){
            resolve(req.responseText)
         }else{
            reject(new Error(req.statusText))
         }
      })

      req.addEventListener('error', function(event){
         reject(new Error(req.statusText))
      })

      req.send()
   })
}

document.addEventListener('DOMContentLoaded', () => {
   const target_content = document.getElementById('performers-show')
   if(target_content != null){

      const node = document.getElementById('performers-show-vue')
      const parsed_data = JSON.parse(node.getAttribute('data'))

      var api_key = process.env.GOOGLE_API_KEY
      var engine_key = process.env.GOOGLE_SEARCH_ENGINE_ID
      var q = parsed_data.title

      var url = 'https://www.googleapis.com/customsearch/v1?key=' + api_key +
                '&cx=' + engine_key +
                '&num=1&searchType=image&q=' + q

      getThumbnail(url).then(
         function(value){

            var thumbnail_url = JSON.parse(value).items[0].image.thumbnailLink
            var vm = new Vue({
               el: '#performers-show-vue',
               render(h){
                  return h(Thumbnail, { props: { thumbnail_url: thumbnail_url } })
               }
            })
         },
         function(reason){
            console.error("Something went wrong", reason)
         }

      )
   }
})
