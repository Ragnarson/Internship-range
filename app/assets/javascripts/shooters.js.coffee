init_shooter_form = ->
  $('div#license_type_list').hide()
  $('fieldset#second_address').hide() if $('#second_address_id input').val() == ""

  $('input#second_address_show').on 'change', ->
    if this.checked
      $('fieldset#second_address').show()
    else
      $('fieldset#second_address').hide().find('input').val('')

  $('input#permission_true').on 'change', ->
    if this.checked
      $('div#license_type_list').show()

  $('input#permission_false').on 'change', ->
    if this.checked
      $('div#license_type_list').hide().find('input').prop('checked', false)


  $('input#destroy_address').on 'change', ->
    if this.checked
      $('fieldset#second_address input[type="text"]').prop('disabled', true);
    else
      $('fieldset#second_address input').prop('disabled', false)

$(document).ready(init_shooter_form)
$(document).on('page:load', init_shooter_form)
