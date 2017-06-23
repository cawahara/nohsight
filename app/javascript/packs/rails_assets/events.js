import * as $ from 'jquery'
require('jquery-datetimepicker/build/jquery.datetimepicker.full.min')

document.addEventListener('DOMContentLoaded', () => {

   $('.datepicker').datetimepicker({
      minDate: '0',
      formatDate: 'Y年m月d日',
      formatTime: 'H:i',
      format: 'Y年m月d日 H:i'
   })
   $.datetimepicker.setLocale('ja')
})
