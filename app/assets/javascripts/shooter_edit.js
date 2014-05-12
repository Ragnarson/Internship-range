$(document).ready(function(){
  $('[data-behaviour_birth~=datepicker]').datepicker(
    {language: 'pl',startView: 'decade', startDate: '-100y',format: 'dd/mm/yyyy'} );

  $('[data-behaviour~=datepicker]').datepicker(
    {language: 'pl',startView: 'year', format: 'dd/mm/yyyy'});
});

