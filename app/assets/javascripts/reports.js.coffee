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
    $("#new_tag_form").hide()
    $("#old_tag_input").show()
    $("form").prepend("<input id='old_tag_marker' name='old_tag_marker' type='hidden' value='true'>")

  $("#new-type-form").hide()
  $("#new-type-button").on "click", ->
    $("#old-type-form").hide()
    $("#new-type-form").show()
    $("#new-type-form").prepend("<div id = 'new-type-input'><label>New Type</label><br><input id='new_type' name='new_type' type='text'></div>")
  $("#old-type-button").on "click", ->
    $("#old-type-form").show()
    $("#new-type-form").hide()
    $("#new-type-input").remove()