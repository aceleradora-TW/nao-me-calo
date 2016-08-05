$(document).ready(function(){


    var x = 5;
    var size_li = $("#listLast5 li").size();
    var item;
    var last ;
    $('#listLast5 li:lt(' + size_li + ')').hide();
    $('#listLast5 li:lt(' + x + ')').show();

    hideListButton();

    $('#showFiveButton').click(function(){
      last = x - 1;
      x = (x+5 <= size_li) ? x + 5 : size_li;
      item = $('#listLast5 li').get(last)
      $('#listLast5 li:lt(' + x + ')').show();
      $('html, body').animate({
        scrollTop: $(item).offset().top
      });
      hideListButton();
    });

    function hideListButton(){
      if(size_li <= x){
      $('#showFiveButton').hide();
      }
    }

});
