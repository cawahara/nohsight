
import Vue from 'vue'
import * as $ from 'jquery'
import SearchAddress from './search_address_tag.vue'
import SelectorStorage from './data_storage/search_selectors.js'
import AboutSections from './data_storage/about_sections.js'
import AboutDescriptions from './about_descriptions.vue'

document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('main').children[0]
   if(target_content == document.getElementById('search')){

      var areas = SelectorStorage.areas
      var prefs = SelectorStorage.prefs

      const node = document.getElementById('search-address-vue')
      var search_values = { areas: areas, prefectures: prefs }
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
