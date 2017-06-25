import * as $ from 'jquery'
require('jquery-datetimepicker/build/jquery.datetimepicker.full.min')

document.addEventListener('DOMContentLoaded', () => {

   $('.datepicker-for-search').datetimepicker({
      format: 'Y/m/d',
      timepicker: false
   })
   $.datetimepicker.setLocale('ja')
})
