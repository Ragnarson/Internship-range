$(document).ready(function(){
  $('div.well.well-sm').hide().find('input').prop('checked', false);
  $('#second_address').hide().find('input').val('');

  $('#second_address_show').prop('checked', false);
  $('#second_address_show').on('change', function() {
    if (this.checked)
      $('#second_address').show();
    else
      $('#second_address').hide().find('input').val('');
  });


  $('#permission_false').prop('checked', true);
  $('#permission_true').on('change', function() {
    if (this.checked)
      $('div.well.well-sm').show();
  });

  $('#permission_false').on('change', function() {
    if (this.checked)
      $('div.well.well-sm').hide().find('input').prop('checked', false)
  });

  $('[data-behaviour_birth~=datepicker]').datepicker(
    {language: 'pl',startView: 'decade', startDate: '-100y', format: 'yyyy-mm-dd', autoclose: true} );

  $('[data-behaviour~=datepicker]').datepicker(
    {language: 'pl',startView: 'year',  format: 'yyyy-mm-dd', autoclose: true});
});
