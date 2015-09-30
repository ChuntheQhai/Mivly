# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'click', '#btn_shrink', ->
  input = '#shrink_url'
  $(input).attr 'data-default', $(input).width()
  $(input).animate { width: 45+'%' }, 'slow'

  $(this).html "<span>Copy URL</span>"
  $('#shrink_url_input').attr 'readonly', 'true'
  $('#btn_shrink').attr 'id', 'btn_copyURL'

  $('.action_reshrink').css "display", "block"
  $('.icon-copy').css "display", "block"

  #Refresh list of shorten URLs
  #$("form#new_url").submit()
  $('form#form-add-url').unbind('submit').submit() 

  return

$(document).on 'click', '#btn_copyURL', ->
  status = $('.action_status');
  shrinkURL = document.getElementById('shrink_url_input')
  shrinkURL.select()
  document.execCommand 'Copy'
  status.fadeIn 'fast', ->
  	status.animate { right: 155 }
  	status.fadeTo "fast", 0.9

  status.fadeIn 'slow', ->
    status.css 'display', 'block'

  setTimeout (-> 
  	status.fadeOut()
  ), 2300
  return

$(document).on 'click', '#btn_reshrink', ->
  input = '#shrink_url'
  $(input).attr 'data-default', $(input).width()
  $(input).animate { width: 78+'%' }, 'slow'

  $('#shrink_url_input').removeAttr 'readonly'
  $('#shrink_url_input').val("")
  $('#shrink_url_input').focus()

  $('#btn_copyURL').html '<span>Shrink</span>'
  $('#btn_copyURL').attr 'id', 'btn_shrink'

  $('.action_reshrink').css "display", "none"
  $('.icon-copy').css "display", "none"

  unique_key = $('div.action_container input').attr('value')
  md5 = $.md5(unique_key)
  md5_uniquekey = md5.substr(1,8)
  $('div.action_container input').attr('value',md5_uniquekey)

  return


$(document).on 'submit', 'form#form-add-url', (e) ->
  e.preventDefault()
  e.stopImmediatePropagation()
  values = $(this).serialize()
  $.ajax
    type: 'POST'
    url: $(this).attr('action')
    data: values
    dataType: 'JSON'
    success: (data) ->
      $('.partial_dynamic').load '/refresh/list'
      $('#shrink_url_input').val(data['shortedURL'])
      alert values
      alert 'SUCCESS'
      return
  false

# $('#new_url').submit ->
#   values = $(this).serialize()
#   $.ajax
#     type: 'POST'
#     url: $(this).attr('action')
#     data: values
#     dataType: 'JSON'
#     success: ->
#       $('.partial_dynamic').load '/refresh/list'
#       alert 'SUCCESS'
#       return
#     false


