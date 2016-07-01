$(document).ready(function(){
  $('#list-all').hide();
  $('#show_five_button').hide();

  $('#show_all_button').click(function(){
    $('#list-all').show();
    $('#list-last-5').hide();
    $('#show_all_button').hide();
    $('#show_five_button').show();
  });

  $('#show_five_button').click(function(){
    $('#list-all').hide();
    $('#list-last-5').show();
    $('#show_all_button').show();
    $('#show_five_button').hide();
  });
});
