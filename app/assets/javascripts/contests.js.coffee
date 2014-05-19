jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

class Contests
  @add_fields: (link, association, content) ->
    new_id = new Date().getTime();
    regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id));

(exports ? this).Contests = Contests
