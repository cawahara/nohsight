import * as $ from 'jquery'
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;
var jsonfile = require('jsonfile');

require('jquery-datetimepicker/build/jquery.datetimepicker.full.min')

document.addEventListener('DOMContentLoaded', () => {
   const target_content = document.getElementById('main').children[0]
   if(target_content == document.getElementById('events-edit') ||
      target_content == document.getElementById('events-new')){
      // for editing event
      $('.datepicker-for-edit').datetimepicker({
         startDate: 0,
         formatDate: 'Y/m/d',
         formatTime: 'H:i',
         step: 10
      })

      $('#event_open_date').on('click', function(){
         var date_value = document.getElementById('event_start_date').value
         var date_value_for_picker = date_value != '' ? new Date(Date.parse(date_value)) : false
      })
      $('#event_start_date').on('click', function(){
         var date_value = document.getElementById('event_open_date').value
         var date_value_for_picker = date_value != '' ? new Date(Date.parse(date_value)) : false
      })
      $.datetimepicker.setLocale('ja')


      // TODO: (できたら)validationパスをajaxでrenderし、リアルタイムでバリデを受け取る

   }
})
