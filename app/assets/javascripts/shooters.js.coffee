init_shooter_form = ->
  $('div#license_type_list').hide()
  $('fieldset#second_address').hide() if $('#second_address_id input').val() == ""

  $('input#second_address_show').on 'change', ->
    if this.checked
      $('fieldset#second_address').show()
    else
      if $('#second_address_id input').val() == ""
        $('fieldset#second_address').hide().find('input').val('')
      else
        $('fieldset#second_address').hide()

  $('input#permission_true').on 'change', ->
    if this.checked
      $('div#license_type_list').show()

  $('input#permission_false').on 'change', ->
    if this.checked
      $('div#license_type_list').hide().find('input').prop('checked', false)

$(document).ready(init_shooter_form)
$(document).on('page:load', init_shooter_form)
