import Vue from 'vue'
import * as $ from 'jquery'
import EditPlace from './edit_place.vue'
import ShowLocations from './show_locations.vue'
document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('main').children[0]
   if(target_content == document.getElementById('event-place-edit')){
      const node = document.getElementById('event-place-edit-vue')
      const parsed_data = JSON.parse(node.getAttribute('data'))
      var place = parsed_data.place
      if(parsed_data.place == null){
         place = {title: '', address: '', official_url: ''}
      }
      if(parsed_data.render_params != null){
         place['render_params'] = parsed_data.render_params['event_place']
         console.log(place)
      }

      var values = {
                     event:   parsed_data.event,
                     place:   place,
                     places:  parsed_data.places
      }
      var edit = new Vue({
         el: '#' + node.id,
         render(h){
            return h(EditPlace, { props: { values: values } })
         }
      })
   }
})
