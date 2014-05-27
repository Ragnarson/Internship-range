jQuery ->
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

class Contests
  $('[data-behaviour_birth~=datepicker]').datepicker
    language: 'pl',
    startView: 'decade',
    startDate: '-100y',
    endDate: '-5y',
    format: 'yyyy-mm-dd',
    autoclose: true

(exports ? this).Contests = Contests
