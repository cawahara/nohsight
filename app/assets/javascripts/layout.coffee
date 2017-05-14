$ ->
   $(".header-btn").click ->
      drop_num = $(".header-btn").index(this) + 1
      $(".dropdown-lists").hide()
      $(".dropdown-lists:nth-child(" + drop_num + ")").show()

   $("body>*:not(header)").click ->
      $(".dropdown-lists").hide()
