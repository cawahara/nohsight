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
      var today = new Date(0)
      $('#start-date').datetimepicker('setOptions', {maxDate: false, minDate: today.getTime()})
   })
   $.datetimepicker.setLocale('ja')
})
