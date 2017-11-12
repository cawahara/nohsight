import Vue from 'vue'
import * as $ from 'jquery'
import SearchAddress from './search_forms/search_address_tag.vue'
import SelectorStorage from './search_forms/search_selectors.js'
import SearchCategory from './search_forms/search_category_tag.vue'
import AboutSections from './about_sections.js'
import AboutDescriptions from './about_descriptions.vue'

document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('main').children[0]
   if(target_content == document.getElementById('search') ||
      target_content == document.getElementById('dashboard')){

      var areas = SelectorStorage.areas
      var prefs = SelectorStorage.prefs

      var search_values = { areas:       areas,
                            prefectures: prefs }
      var search_address_item = new Vue({
         el: '#search-address-vue',
         render(h){
            return h(SearchAddress, { props: { values: search_values }})
         }
      })
      const category_tag = document.getElementById('search-category-vue')
      if(category_tag != null){
         const categories = JSON.parse(category_tag.getAttribute('data'))
         var seatch_categories = new Vue({
            el: '#search-category-vue',
            render(h){
               return h(SearchCategory, { props: { values: categories }})
            }
         })
      }

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
