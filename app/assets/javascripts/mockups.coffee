# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
   $('#main').click ->
      $('.dropdown-menu').hide(0)

   $('#header-menus > li:nth-child(1)').click ->
      if $('#request-form').is(':visible')
         $('.dropdown-menu').hide(0)
      else
         $('.dropdown-menu').hide(0)
         $('#request-form').show(0)

   $('#header-menus > li:nth-child(2)').click ->
      if $('#search-form').is(':visible')
         $('.dropdown-menu').hide(0)
      else
         $('.dropdown-menu').hide(0)
         $('#search-form').show(0)

   $('#header-menus > li:nth-child(3)').click ->
      if $('#middle-menus').is(':visible')
         $('.dropdown-menu').hide(0)
      else
         $('.dropdown-menu').hide(0)
         $('#middle-menus').show(0)
