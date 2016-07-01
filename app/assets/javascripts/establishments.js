$(document).ready(function(){
<<<<<<< HEAD

    var x = 5;
    var size_li = $("#list-last-5 li").size();
    $('#list-last-5 li:lt('+size_li+')').hide();
    $('#list-last-5 li:lt('+x+')').show();
    $('#show_five_button').click(function(){
      x = (x+5 <= size_li) ? x+5 : size_li;
      $('#list-last-5 li:lt('+x+')').show();

    });

=======
  $('#listAll').hide();
  $('#showFiveButton').hide();

  $('#showAllButton').click(function(){
    $('#listAll').show();
    $('#listLast5').hide();
    $('#showAllButton').hide();
    $('#showFiveButton').show();
  });

  $('#showFiveButton').click(function(){
    $('#listAll').hide();
    $('#listLast5').show();
    $('#showAllButton').show();
    $('#showFiveButton').hide();
  });
>>>>>>> #0 <@cschallenberger, @brandelli> - Refatorado js e css
});
