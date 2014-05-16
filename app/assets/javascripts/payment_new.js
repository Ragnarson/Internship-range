$(document).ready(function(){
  $('[data-behaviour~=datepicker]').datepicker(
    {language: 'pl',startView: 'year', format: 'yyyy-mm-dd', autoclose: true});
});
