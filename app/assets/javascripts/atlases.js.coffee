# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(window).load ->
  $("#submit_atlas").attr("type", "button")
  $("#addTypeField").on "click", ->
    console.log "blah"
    typeCount = Number($("#type_count").val())
    typeCount += 1
    elementName = "label" + String(typeCount)
    $("#type_count").val typeCount
    $("fieldset").append "<div class='control-group'><label for='" + elementName + "'>New Tag Type</label><div class='controls'><input id = '" + elementName + "' name='" + elementName + "' type='text'></div></div>"
  $("#submit_atlas").on "click", ->
    if $("#submit_atlas").attr("type") == "button"
      alert "Please add a location on the map before creating your atlas."
