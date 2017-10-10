
import Vue from 'vue'
import * as $ from 'jquery'
import SearchAddress from './search_address_tag.vue'
import SelectorStorage from './selector_storage.js'

document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('search')
   if(target_content != null){

      var prefecture_values = SelectorStorage.prefecture_values
      var area_values = SelectorStorage.area_values

      const node = document.getElementById('search-address-vue')
      var search_values = { prefecture_values: prefecture_values, area_values: area_values }
      var seatch_address_item = new Vue({
         el: '#search-address-vue',
         render(h){
            return h(SearchAddress, { props: { values: search_values }})
         }
      })
   }
})
