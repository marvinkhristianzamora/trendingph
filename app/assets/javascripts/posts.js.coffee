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
    $('#submit-modal').modal('hide')


