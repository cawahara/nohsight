import * as $ from 'jquery'
require('jquery-datetimepicker/build/jquery.datetimepicker.full.min')

document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('main').children[0]
   if(target_content == document.getElementById('search')){
      $('.datepicker-for-search').datetimepicker({
         format: 'Y/m/d',
         timepicker: false
      })
      
      // for detailed search form
      $('#start-date').on('click', function(){
         var date_value = document.getElementById('end-date').value
         var date_value_for_picker = date_value != '' ? Date.parse(date_value) : false
         $('#start-date').datetimepicker('setOptions', {maxDate: date_value_for_picker, minDate: false})
      })
      $('#end-date').on('click', function(){
         var date_value = document.getElementById('start-date').value
         var date_value_for_picker = date_value != '' ? Date.parse(date_value) : false
         $('#end-date').datetimepicker('setOptions', {maxDate: false, minDate: date_value_for_picker})
      })
      $.datetimepicker.setLocale('ja')
   }
})
