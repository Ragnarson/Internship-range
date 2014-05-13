init_bootstrap_typeahead = ->
  $.get '/names.json', (data) ->
    map = {}
    $('input#shooter-name').typeahead
      source: (query, process) ->
        names = []
        $.each data, (i, obj)->
          map[obj.full_name] = obj
          names.push obj.full_name
          return
        process names
        return
      updater: (item) ->
        $('input#shooter-id').val map[item].id
        item

$(document).ready(init_bootstrap_typeahead)
$(document).on('page:load', init_bootstrap_typeahead)
