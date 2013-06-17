# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(window).load ->
  # THESE HAPPEN ON WINDOW LOAD

  $("#new_tag_form").hide()

  $("#new-type-form").hide()
  $("#report_tag_attributes_title").attr("name", "hidden_report_tag_title")
  $("#report_tag_attributes_lng").attr("name", "hidden_report_tag_lng")
  $("#report_tag_attributes_lat").attr("name", "hidden_report_tag_lat")
  $("#report_tag_attributes_radius").attr("name", "hidden_report_tag_radius")
  $("#report_tag_attributes_type_attributes_label").attr("name", "new_type_was_hidden")
  $("#report_tag_attributes_type_id").attr("name", "old_type_was_showing")

  $("#report_tag_attributes_title").attr("id", "hidden_report_tag_title")
  $("#report_tag_attributes_lng").attr("id", "hidden_report_tag_lng")
  $("#report_tag_attributes_lat").attr("id", "hidden_report_tag_lat")
  $("#report_tag_attributes_radius").attr("id", "hidden_report_tag_radius")
  $("#report_tag_attributes_type_attributes_label").attr("id", "new_type_was_hidden")
  $("#report_tag_attributes_type_id").attr("id", "old_type_was_showing")


  # THESE HAPPEN WHEN SWITHING FROM THE OLD TAG TO THE NEW TAG FORM

  $("#new_tag").on "click", ->
    $("#old_tag_input").hide()
    $("#new_tag_form").show()
    $("#old_tag_marker").remove()
    $("#report_tag_id").attr("name", "hidden_tag_id")
    $("#hidden_report_tag_title").attr("name", "report_tag_attributes_title")
    $("#hidden_report_tag_lng").attr("name", "report_tag_attributes_lng")
    $("#hidden_report_tag_lat").attr("name", "report_tag_attributes_lat")
    $("#hidden_report_tag_radius").attr("name", "report_tag_attributes_radius")
    $("#new_type_was_showing").attr("name", "report_tag_attributes_type_attributes_label")
    $("#old_type_was_showing").attr("name", "report_tag_attributes_type_id")

    $("#report_tag_id").attr("id", "hidden_tag_id")
    $("#hidden_report_tag_title").attr("id", "report_tag_attributes_title")
    $("#hidden_report_tag_lng").attr("id", "report_tag_attributes_lng")
    $("#hidden_report_tag_lat").attr("id", "report_tag_attributes_lat")
    $("#hidden_report_tag_radius").attr("id", "report_tag_attributes_radius")
    $("#new_type_was_showing").attr("id", "report_tag_attributes_type_attributes_label")
    $("#old_type_was_showing").attr("id", "report_tag_attributes_type_id")


  # THESE HAPPEN WHEN SWITCHING FROM THE NEW TAG TO THE OLD TAG FORM

  $("#old_tag").on "click", ->
    $("#new_tag_form").hide()
    $("#old_tag_input").show()
    $("form").prepend("<input id='old_tag_marker' name='old_tag_marker' type='hidden' value='true'>")
    $("#hidden_tag_id").attr("id", "report_tag_id")
    # MAKE ALL THE NEW TAG FIELDS UNTRACKABLE BY FORM
    $("#report_tag_attributes_title").attr("name", "hidden_report_tag_title")
    $("#report_tag_attributes_lng").attr("name", "hidden_report_tag_lng")
    $("#report_tag_attributes_lat").attr("name", "hidden_report_tag_lat")
    $("#report_tag_attributes_radius").attr("name", "hidden_report_tag_radius")

    $("#report_tag_attributes_title").attr("id", "hidden_report_tag_title")
    $("#report_tag_attributes_lng").attr("id", "hidden_report_tag_lng")
    $("#report_tag_attributes_lat").attr("id", "hidden_report_tag_lat")
    $("#report_tag_attributes_radius").attr("id", "hidden_report_tag_radius")


    # TYPE FIELD IDS ARE CHANGED BASED ON WHETHER THEY WERE HIDDEN OR NOT SO THAT SWITCHING
    # BETWEEN OLD AND NEW TAG FORMS WILL SHOW THE SAME FIELDS OPEN EACH TIME
    $("#report_tag_attributes_type_label").attr("name", "new_type_was_showing")
    $("#report_tag_attributes_type_id").attr("name", "old_type_was_showing")

    $("#report_tag_attributes_type_label").attr("id", "new_type_was_showing")
    $("#report_tag_attributes_type_id").attr("id", "old_type_was_showing")


  # THESE HAPPEN WHEN TOGGLING BETWEEN OLD AND NEW TYPE FIELDS

  $("#new-type-button").on "click", ->
    $("#old-type-form").hide()
    $("#new-type-form").show()
    $("#report_tag_attributes_type_id").attr("name", "old_type_was_hidden")
    $("#new_type_was_hidden").attr("name", "report_tag_attributes_type_attributes_label")

    $("#report_tag_attributes_type_id").attr("id", "old_type_was_hidden")
    $("#new_type_was_hidden").attr("id", "report_tag_attributes_type_attributes_label")

  $("#old-type-button").on "click", ->
    $("#old-type-form").show()
    $("#new-type-form").hide()

    $("#old_type_was_hidden").attr("name", "report_tag_attributes_type_id")
    $("#report_tag_attributes_type_attributes_label").attr("name", "new_type_was_hidden")

    $("#old_type_was_hidden").attr("id", "report_tag_attributes_type_id")
    $("#report_tag_attributes_type_attributes_label").attr("id", "new_type_was_hidden")