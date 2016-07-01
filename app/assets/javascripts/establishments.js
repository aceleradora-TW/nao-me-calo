$(document).ready(function(){

    var x = 5;
    var size_li = $("#list-last-5 li").size();
    $('#list-last-5 li:lt('+size_li+')').hide();
    $('#list-last-5 li:lt('+x+')').show();
    $('#show_five_button').click(function(){
      x = (x+5 <= size_li) ? x+5 : size_li;
      $('#list-last-5 li:lt('+x+')').show();

    });

});
