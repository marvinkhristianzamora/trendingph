# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ()->
  $("form.new_session").on "ajax:success", (event, data, status, xhr) ->
    $("#signin-btn").attr('value', 'Sign in')
    if data.success
      $("form.new_session")[0].reset()
      $('#signin-modal').modal('hide')
      window.location.reload()
    else
      $("#signin-errors").append('<span>' + data.error_message + '</span>')
      $("#signin-errors").show()

$ ()->
  $("form.new_session").on "ajax:beforeSend", (event, xhr, settings) ->
    $("#signin-btn").attr('value', 'Signing in...')
    $("#signin-errors").text("")
    $("#signin-errors").hide()

$ ()->
  $("form.new_user").on "ajax:success", (event, data, status, xhr) ->
    $("#signup-btn").attr('value', 'Sign up')
    if(data.success)
      $("form.new_user")[0].reset()
      $('#signup-modal').modal('hide')
      window.location.reload()
    else
      $('#signup-btn').attr('value', 'Sign up')
      for key, value of data.errors
        $("#signup-errors").append('<span>' + key.replace('_', ' ') + ' ' + value + '</span>')

      $("#signup-errors").show()

$ ()->
  $("form.new_user").on "ajax:beforeSend", (event, xhr, settings) ->
    $("#signup-btn").attr('value', 'Signing up...')
    $("#signup-errors").text("")
    $("#signup-errors").hide()
