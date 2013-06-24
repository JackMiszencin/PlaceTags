# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(window).load ->
  $("#submit_tag").attr("type", "button")
  $("#submit_tag").on "click", ->
  	if $("#submit_tag").attr("type") == "button" || $("#tag_lat").val() == "" || $("#tag_lng").val() == ""
  	  alert("Please select a location on the map before creating your tag.")
