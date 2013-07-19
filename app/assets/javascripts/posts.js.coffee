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
    if data.success
      $("form.new_post")[0].reset()
      $('#submit-modal').modal('hide')
      $('#flash-holder').attr('class', 'offset1 short-alert short-alert-success').text("Posted!").fadeIn(1000).fadeOut(3000)
    else
      $('#submit-btn').attr('value', 'Submit')
      console.log data.errors
      for key, value of data.errors
        $("#submit-errors").append('<span>' + key + ' ' + value + '</span>')
     
      $("#submit-errors").show()

$ ()->
  $("form.new_post").on "ajax:beforeSend", (event, xhr, settings) ->
    $("#submit-btn").attr('value', 'Submitting..')
    $("#submit-errors").text("")
    $("#submit-errors").hide()
