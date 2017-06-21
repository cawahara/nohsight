import * as $ from 'jquery'

document.addEventListener('DOMContentLoaded', () => {

   $(function(){
       $('.datepicker').datetimepicker({
         format: 'YYYY年MM月DD日  ahh時mm分'
      });
   });
})
