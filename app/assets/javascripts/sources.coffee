# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#remove_link').click = ()->
    $('.offset1.fields input').attr('value', 1);
    $('.offset1.fields').hide();