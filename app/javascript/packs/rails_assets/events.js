import * as $ from 'jquery'
require('jquery-datetimepicker/build/jquery.datetimepicker.full.min')

document.addEventListener('DOMContentLoaded', () => {

   // for editing event
   $('.datepicker-for-edit').datetimepicker({
      minDate: '0',
      formatDate: 'Y/m/d',
      formatTime: 'H:i',
      format: 'Y/m/d H:i'
   })

   // for detailed search form
   $('.datepicker-for-search').datetimepicker({
      formatDate: 'Y/m/d',
      format: 'Y/m/d'
   })
   $('#start-date').on('click', function(){
      var end_date = $('#end-date').datetimepicker('getValue')
      if(end_date){
         $('#start-date').datetimepicker('setOptions', {maxDate: end_date, minDate: false})
      }else{
         $('#start-date').datetimepicker('setOptions', {maxDate: false, minDate: false})
      }
   })
   $('#end-date').on('click', function(){
      var start_date = $('#start-date').datetimepicker('getValue')
      if(start_date){
         $('#end-date').datetimepicker('setOptions', {minDate: start_date, maxDate: false})
      }else{
         $('#end-date').datetimepicker('setOptions', {minDate: false, maxDate: false})
      }
   })
   $.datetimepicker.setLocale('ja')
})
