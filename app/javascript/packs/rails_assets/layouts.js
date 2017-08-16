import * as $ from 'jquery'

document.addEventListener('DOMContentLoaded', () => {

   // ヘッダー上のメニューボタン操作
   $('.header-btn').click(function(){
      var drop_num = $('.header-btn').index(this) + 1
      if($('.dropdown-lists:nth-child(' + drop_num + ')').css('display') == 'block'){
         $('.dropdown-lists').hide()
      }else{
         $('.dropdown-lists').hide()
         $('.dropdown-lists:nth-child(' + drop_num + ')').show()
      }
   })

   $('body>*:not(header)').click(function(){
      $('.dropdown-lists').hide()
   })

   // flashウインドウを閉じる
   $('#flash').click(function(){
      $(this).hide()
   })
})
