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
         step: 10
      })

      $('#open-date').on('click', function(){
         var date_value = document.getElementById('start-date').value
         var date_value_for_picker = date_value != '' ? new Date(Date.parse(date_value)) : false
         this.datetimepicker('setOptions', { maxDate: date_value_for_picker,
                                             minDate: false })
      })
      $('#start-date').on('click', function(){
         var date_value = document.getElementById('open-date').value
         var date_value_for_picker = date_value != '' ? new Date(Date.parse(date_value)) : false
         this.datetimepicker('setOptions', { maxDate: false,
                                             minDate: date_value_for_picker })
      })
      $.datetimepicker.setLocale('ja')
   }
})
