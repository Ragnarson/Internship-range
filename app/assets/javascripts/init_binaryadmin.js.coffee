init_binaryadmin = ->
  $('#main-menu').metisMenu()

$(document).ready(init_binaryadmin)
$(document).on('page:load', init_binaryadmin)
