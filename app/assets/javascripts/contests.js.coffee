init_contest_new_form = ->
  $('form').on 'click', '.remove_fields', (event) ->
    if confirm ("Czy aby tak?")
        $(this).prev('input[type=hidden]').val('1')
        $(this).closest('fieldset').hide()
        event.preventDefault()
    else event.preventDefault()
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
  return

$(document).ready(init_contest_new_form)
$(document).on('page:load', init_contest_new_form)
