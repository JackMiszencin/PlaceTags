# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(window).load ->
  $("#new_tag_form").hide()
  $("#new_tag").on "click", ->
    $("#old_tag_input").hide()
    $("#new_tag_form").show()

  $("#old_tag").on "click", ->
    $("#new_tag_form").hide()
    $("#old_tag_input").show()
