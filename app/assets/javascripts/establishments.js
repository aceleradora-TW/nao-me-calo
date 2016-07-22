$(document).ready(function(){

  $(".ranking-best").click(activeBestButton);

  $(".ranking-worst").click(activeWorstButton);

    var x = 5;
    var size_li = $("#listLast5 li").size();
    $('#listLast5 li:lt(' + size_li + ')').hide();
    $('#listLast5 li:lt(' + x + ')').show();

    hideListButton();

    $('#showFiveButton').click(function(){
      x = (x+5 <= size_li) ? x + 5 : size_li;
      $('#listLast5 li:lt(' + x + ')').show();
      hideListButton();
    });

    function hideListButton(){
      if(size_li <= x){
      $('#showFiveButton').hide();
      }
    }

});
