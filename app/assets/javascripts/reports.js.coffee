# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(window).load ->
  $("#new_tag_form").hide()
  $("#new_tag").on "click", ->
    $("#tags").val(null)
    $("#old_tag_input").hide()
    $("#new_tag_form").show()
    $("#old_tag_marker").remove()

  $("#old_tag").on "click", ->
    $("#lat").remove()
    $("#lng").remove()
    $("#new_tag_form").hide()
    $("#old_tag_input").show()
    $("form").prepend("<input id='old_tag_marker' name='old_tag_marker' type='hidden' value='true'>")
