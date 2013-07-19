# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ()->
  $("form.new_session").on "ajax:success", (event, data, status, xhr) ->
    if data.success
      $("form.new_session")[0].reset()
      $('#signin-modal').modal('hide')
      window.location.reload()
    else
      $("#signin-btn").attr('value', 'Sign in')
      $("#signin-errors").text(data.error_message)
      $("#signin-errors").show()

$ ()->
  $("form.new_session").on "ajax:beforeSend", (event, xhr, settings) ->
    $("#signin-btn").attr('value', 'Signing in...')
    $("#signin-errors").text("")
    $("#signin-errors").hide()

$ ()->
  $("form.new_user").on "ajax:success", (event, data, status, xhr) ->
     $("form.new_user")[0].reset()
     $('#signup-modal').modal('hide')
     window.location.reload()

$ ()->
  $("form.new_user").on "ajax:beforeSend", (event, xhr, settings) ->
    $("#signup-btn").attr('value', 'Signing up...')
    $("#signup-errors").text("")
    $("#signup-errors").hide()
