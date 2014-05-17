init_datapicker = ->
  $('[data-behaviour~=datepicker]').datepicker
    language: 'pl',
    startView: 'year',
    format: 'yyyy-mm-dd',
    autoclose: true
  $('[data-behaviour_birth~=datepicker]').datepicker
    language: 'pl',
    startView: 'decade',
    startDate: '-100y',
    format: 'yyyy-mm-dd',
    autoclose: true

$(document).ready(init_datapicker)
$(document).on('page:load', init_datapicker)
