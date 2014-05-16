$(document).ready(function(){
  $('[data-behaviour_birth~=datepicker]').datepicker(
    {language: 'pl',startView: 'decade', startDate: '-100y', format: 'yyyy-mm-dd', autoclose: true);

  $('[data-behaviour~=datepicker]').datepicker(
    {language: 'pl',startView: 'year', format: 'yyyy-mm-dd', autoclose: true);
});

