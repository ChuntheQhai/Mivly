# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'click', '#btn_shrink', ->
  $('form#form-add-url').submit()
  return 
    


$(document).on 'click', '#btn_copyURL', ->
  status = $('.action_status');
  shrinkURL = document.getElementById('shrink_url_input')
  shrinkURL.select()
  document.execCommand 'Copy'
  status.fadeIn 'fast', ->
  	status.animate { right: -50 }
  	status.fadeTo "fast", 0.9

  status.fadeIn 'slow', ->
    status.css 'display', 'block'

  setTimeout (-> 
  	status.fadeOut()
  ), 2300
  return

$(document).on 'focus', '#shrink_url_input',  ->
  if $('#shrink_url_input').is('[readonly]')
  else
    document.getElementById("shrink_url_input").value = "https://"

$(document).on 'click', '#btn_reshrink', ->
  input = '#shrink_url'
  $(input).attr 'data-default', $(input).width()
  $(input).animate { width: 70+'%' }, 'slow'

  $('#shrink_url_input').removeAttr 'readonly'
  $('#shrink_url_input').val("")
  $('#shrink_url_input').focus()

  $('#btn_copyURL').html '<span>Shrink</span>'
  $('#btn_copyURL').attr 'id', 'btn_shrink'

  $('.action_reshrink').css "display", "none"
  $('.icon-copy').css "display", "none"


  location.reload()
  return

$(document).ready ->
   $('form#form-add-url').submit (e) ->
    e.preventDefault()
    e.stopImmediatePropagation()
    values = $(this).serialize()
    $.ajax
      type: 'POST'
      url: $(this).attr('action')
      data: values
      dataType: 'JSON'
      success: (data) ->

        input = '#shrink_url'
        $(input).attr 'data-default', $(input).width()
        $(input).animate { width: 70+'%' }, 'slow'

        $('#btn_shrink').html "<span>Copy URL</span>"
        $('#shrink_url_input').attr 'readonly', 'true'
        $('#btn_shrink').attr 'id', 'btn_copyURL'

        $('.action_reshrink').css "display", "block"
        $('.icon-copy').css "display", "block"

        $('.partial_dynamic').load '/refresh/list'

        $('#shrink_url_input').val(data['shortedURL'])
        return
      error: (XMLHttpRequest, textStatus, errorThrown) ->

        status_error = $('.action_status_error')
        status_error.fadeIn 'fast', ->
          status_error.animate { right: -120 }
          status_error.fadeTo "fast", 0.9

        status_error.fadeIn  'slow', ->
          status_error.css 'display', 'block'

        setTimeout (->
          status_error.fadeOut()
        ), 2300

        return
    false



