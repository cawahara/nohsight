import * as $ from 'jquery'
require('jquery-datetimepicker/build/jquery.datetimepicker.full.min')

document.addEventListener('DOMContentLoaded', () => {

   const target_content = document.getElementById('main').children[0]
   if(target_content == document.getElementById('events-edit')){
      // for editing event
      $('.datepicker-for-edit').datetimepicker({
         startDate: 0,
         formatDate: 'Y/m/d',
         formatTime: 'H:i',
         format: 'Y/m/d H:i',
         step: 30
      })
      $.datetimepicker.setLocale('ja')
   }
})
