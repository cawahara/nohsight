import * as $ from 'jquery'

document.addEventListener('DOMContentLoaded', () => {
   const target_content = document.getElementById('main').children[0]
   if(target_content == document.getElementById('events-edit') ||
      target_content == document.getElementById('events-new')){
         // REVIEW: 現状、defaultのrailsヘルパーで日付フォームを実装しているが、
         //         Material dateimepickerが実装できたらそちらに変更したい

   }
})
