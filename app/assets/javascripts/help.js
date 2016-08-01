
$(document).ready(function(){
  $('#discriminacao_down').addClass('hidden')
  $('#violencia_down').addClass('hidden')
  $('#racial_down').addClass('hidden')
  $('#homofobia_down').addClass('hidden')
  $('#mental_down').addClass('hidden')
  $('#transmissiveis_down').addClass('hidden')
  patternLinks();


  function patternLinks(){
    $('#abuse-first').click(function(){
      $('#article-1').fadeToggle("slow");
      $('#discriminacao_down').toggleClass('hidden');
      $('#discriminacao_right').toggleClass('hidden');

      $('html, body').animate({
        scrollTop: $("#abuse-first").offset().top
      });

    });

    $('#abuse-second').click(function(){
      $('#article-2').fadeToggle("slow");
      $('#violencia_down').toggleClass('hidden');
      $('#violencia_right').toggleClass('hidden');
      $('html, body').animate({
        scrollTop: $("#abuse-second").offset().top
      });
    });

    $('#abuse-three').click(function(){
      $('#article-3').fadeToggle("slow");
      $('#racial_down').toggleClass('hidden');
      $('#racial_right').toggleClass('hidden');
      $('html, body').animate({
        scrollTop: $("#abuse-three").offset().top
      });

    });

    $('#abuse-four').click(function(){
      $('#article-4').fadeToggle("slow");
      $('#homofobia_down').toggleClass('hidden');
      $('#homofobia_right').toggleClass('hidden');
      $('html, body').animate({
        scrollTop: $("#abuse-four").offset().top
      });
    });

    $('#abuse-five').click(function(){
      $('#article-5').fadeToggle("slow");
      $('#mental_down').toggleClass('hidden');
      $('#mental_right').toggleClass('hidden');
      $('html, body').animate({
        scrollTop: $("#abuse-five").offset().top
      });
    });

    $('#abuse-six').click(function(){
      $('#article-6').fadeToggle("slow");
      $('#transmissiveis_down').toggleClass('hidden');
      $('#transmissiveis_right').toggleClass('hidden');
      $('html, body').animate({
        scrollTop: $("#abuse-six").offset().top
      });
    });
  }
});
