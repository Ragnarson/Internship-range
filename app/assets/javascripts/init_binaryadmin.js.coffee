init_binaryadmin = ->
  unless /users/.test(location.pathname) || location.pathname == '/settings' 
    $('#main-menu').metisMenu()

$(document).ready(init_binaryadmin)
$(document).on('page:load', init_binaryadmin)
