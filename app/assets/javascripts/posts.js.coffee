# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Loading more entries...")
        $.getScript(url)
    $(window).scroll()

$ ()->
  $("form.new_post").on "ajax:success", (event, data, status, xhr) ->
    $("form.new_post")[0].reset()
    $('#submit-modal').modal('hide')
    $('#flash-holder').attr('class', 'offset1 short-alert short-alert-success').text("Posted!").fadeIn(1000).fadeOut(3000)
