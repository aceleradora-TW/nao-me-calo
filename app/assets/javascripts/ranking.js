$(document).ready(function(){


  var searchField = $('#searchField')[0];
  var types = {types: ['establishment']};

  searchBox = new google.maps.places.Autocomplete(searchField, types);

  autocomplete.addListener('place_changed', fillName);
  searchBox.addListener('place_changed', fillSearch);

  var limitListBest = 5;
  var sizeListBest = $(".list-ranking-best li").size();
  $('.list-ranking-best li:lt(' + sizeListBest + ')').hide();
  $('.list-ranking-best li:lt(' + limitListBest + ')').show();

  var limitListWorst = 5;
  var sizeListWorst = $(".list-ranking-worst li").size();
  $('.list-ranking-worst li:lt(' + sizeListWorst + ')').hide();
  $('.list-ranking-worst li:lt(' + limitListWorst + ')').show();

  hideListButtonRankingWorst();
  hideListButtonRankingBest();

  $('#showMoreBest').click(function(){
    limitListBest = ( limitListBest + 5 <= sizeListBest) ? limitListBest + 5 : sizeListBest;
    $('.list-ranking-best li:lt(' + limitListBest + ')').show();
    $('html, body').animate({
      scrollTop: $('#showMoreBest').offset().top
    });
    hideListButtonRankingBest();
  });

  $('#showMoreWorst').click(function(){
    limitListWorst = ( limitListWorst + 5 <= sizeListWorst) ? limitListWorst + 5 : sizeListWorst;
    $('.list-ranking-worst li:lt(' + limitListWorst + ')').show();
    $('html, body').animate({
      scrollTop: $('#showMoreWorst').offset().top
    });
    hideListButtonRankingWorst();
  });

  function hideListButtonRankingBest(){
    if(sizeListBest <= limitListBest){
      $('#showMoreBest').hide();
    }
  }

  function hideListButtonRankingWorst(){
    if(sizeListWorst <= limitListWorst){
      $('#showMoreWorst').hide();
    }
  }


  //showMoreBest showMoreWorst

});
