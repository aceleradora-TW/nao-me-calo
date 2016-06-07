$(document).ready(function(){
  $("#phoneEvaluate").mask("(99) 9999-9999");
  $("#dateEvaluate").mask("99/99/9999");
  $('#cpfEvaluate').mask('999.999.999-99');

  errors = {name: false, cpfEvaluate: false, dateEvaluate: false};

  if ( $('[type="date"]').prop('type') != 'date' ) {
    $('[type="date"]').datepicker();
  }

  $('#rating_name').focusout(function(){
    reviewName();
  });

  $('#cpfEvaluate').focusout(function(){
    reviewCPF();
  });

  $('#dateEvaluate').focusout(function(){
    reviewDate();
  });

  function showMessage(){
    for(var l in errors){
      if(errors[l] === true){
        $('.errorDiv').removeClass("hidden");
        $('#submitButton').prop("disabled", true);
        return;
      }
    }
    $('.errorDiv').addClass("hidden");
    $('#submitButton').prop("disabled", false);
  }

  function reviewName(){
    if($('#rating_name').val() === "" || $('#rating_name').val() === null){
      $('#rating_name').addClass("error");
      errors["name"] = true;
      showMessage();
    } else {
      $('#rating_name').removeClass("error");
      errors["name"] = false;
      showMessage();
    }
  }

  function reviewCPF(){
    var valor = 14;
    if ($('#cpfEvaluate').val() === "___.___.___-__" || $('#cpfEvaluate').val() == "" || $('#cpfEvaluate').val().length != valor || $('#cpfEvaluate').val() == null){
      $('#cpfEvaluate').addClass("error");
      errors["cpfEvaluate"] = true;
      showMessage();
    } else {
      $('#cpfEvaluate').removeClass("error");
      errors["cpfEvaluate"] = false;
      showMessage();
    }
  }

  function reviewDate(){
    var RegExPattern = /^((((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])      [\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00)))|(((0[1-9]|[12]\d|3[01])(0[13578]|1[02])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|[12]\d|30)(0[13456789]|1[012])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|1\d|2[0-8])02((1[6-9]|[2-9]\d)?\d{2}))|(2902((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00))))$/;
    if ($('#dateEvaluate').val() === "__/__/____" || $('#dateEvaluate').val() == "" || !$('#dateEvaluate').val().match(RegExPattern)){
      $('#dateEvaluate').addClass("error");
      errors["dateEvaluate"] = true;
      showMessage();
    } else {
      $('#dateEvaluate').removeClass("error");
      errors["dateEvaluate"] = false;
      showMessage();
    }
  }

  function isNull(parameter){
    if(parameter.val() == null || parameter.val() == ""){
      return true;
    } else {
      return false;
    }
  }

  $('#new_rating').submit(function(e){
    if(isNull($('#rating_name')) || isNull($('#cpfEvaluate'))){
      e.preventDefault();
      reviewCPF();
      reviewName();
    }
  });
});
