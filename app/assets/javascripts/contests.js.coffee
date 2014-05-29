init_contest_new_form = ->
  $('form').on 'click', '.remove_fields', (event) ->
    if confirm ("Czy aby tak?")
      event.preventDefault()
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('fieldset').hide()
    else event.preventDefault()
  $('form').on 'click', '.add_fields', (event) ->
    event.preventDefault()
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    $('[data-behaviour_birth~=datepicker]').datepicker
      language: 'pl',
      startView: 'decade',
      startDate: '-100y',
      endDate: '-5y',
      format: 'yyyy-mm-dd',
      autoclose: true
  return

$(document).ready(init_contest_new_form)
$(document).on('page:load', init_contest_new_form)
