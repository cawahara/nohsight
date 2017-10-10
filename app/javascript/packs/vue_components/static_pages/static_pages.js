import Vue from 'vue'
import * as $ from 'jquery'
import SearchAddress from './search_address_tag.vue'
import SelectorStorage from './search_selectors.js'
import AboutSections from './about_sections.js'
import AboutDescriptions from './about_descriptions.vue'

document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('main').children[0]
   if(target_content == document.getElementById('search') ||
      target_content == document.getElementById('dashboard')){

      var search_type
      if(target_content == document.getElementById('search')){
         search_type = 'search'
      }else{
         search_type = 'easy_search'
      }

      var areas = SelectorStorage.areas
      var prefs = SelectorStorage.prefs

      const node = document.getElementById('search-address-vue')
      var search_values = { areas:       areas,
                            prefectures: prefs,
                            search_type: search_type
                           }
      var seatch_address_item = new Vue({
         el: '#search-address-vue',
         render(h){
            return h(SearchAddress, { props: { values: search_values }})
         }
      })
   }else if(target_content == document.getElementById('about')){
      var articles = AboutSections.articles
      var about_descriptions_item = new Vue({
         el: '#about-sections-vue',
         render(h){
            return h(AboutDescriptions, { props: { values: articles } })
         }
      })
   }
})
