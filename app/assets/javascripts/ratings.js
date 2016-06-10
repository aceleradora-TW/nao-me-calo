$(document).ready(function(){

  $('#submitButton').prop("disabled", true);

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

  $('#rating_grade').focusout(function(){
    reviewName();
  });

  function showMessage(){
    for(var l in errors){
      if(errors[l] === true){
        $('.errorDiv').removeClass("hidden");
        $('#submitButton').prop("disabled", true);
        return;
      }
    }
    if(disableButtonTerms()){
      $('.errorDiv').addClass("hidden");
      $('#submitButton').prop("disabled", false);
    }
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
    var teste = $('#cpfEvaluate').val().split(".").join("").split("-").join("");
    var erro = CPFTest(teste);
    if(erro) {
      $('#cpfEvaluate').addClass("error");
      errors["cpfEvaluate"] = true;
      showMessage();
    } else {
      $('#cpfEvaluate').removeClass("error");
      errors["cpfEvaluate"] = false;
      showMessage();
    }
  }

  function CPFTest(strCPF){
    var Soma;
    var Resto;
    Soma = 0;

    if (strCPF == "00000000000") return true;

    for (i=1; i<=9; i++) Soma = Soma + parseInt(strCPF.substring(i-1, i)) * (11 - i);
    Resto = (Soma * 10) % 11;

    if ((Resto == 10) || (Resto == 11))  Resto = 0;
    if (Resto != parseInt(strCPF.substring(9, 10)) ) return true;

    Soma = 0;
    for (i = 1; i <= 10; i++) Soma = Soma + parseInt(strCPF.substring(i-1, i)) * (12 - i);
    Resto = (Soma * 10) % 11;

    if ((Resto == 10) || (Resto == 11))  Resto = 0;
    if (Resto != parseInt(strCPF.substring(10, 11) ) ) return true;
    return false;
  }

  function reviewDate(){
    var RegExPattern = /^((((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])      [\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00)))|(((0[1-9]|[12]\d|3[01])(0[13578]|1[02])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|[12]\d|30)(0[13456789]|1[012])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|1\d|2[0-8])02((1[6-9]|[2-9]\d)?\d{2}))|(2902((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00))))$/;

    var ratingDate = $('#dateEvaluate').val();
    var date = new Date();

    var today = date.getDate() + ((date.getMonth()+1) * 30) + (date.getFullYear() * 365);
    ratingDate = parseInt(ratingDate.substring(0,2)) + (parseInt(ratingDate.substring(3,5)) * 30) + (parseInt(ratingDate.substring(6)) * 365);

    if (today < ratingDate || $('#dateEvaluate').val() === "__/__/____" || $('#dateEvaluate').val() == "" || !$('#dateEvaluate').val().match(RegExPattern)){
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

  function enableButtonTerms(){
    if($('#terms:checked').length === 1){
      $('#submitButton').prop("disabled", false);
      return true;
    } else {
      $('#submitButton').prop("disabled", true);
      return false;
    }
  }

  $('#new_rating').submit(function(e){
    if(isNull($('#rating_name')) || isNull($('#cpfEvaluate'))){
      e.preventDefault();
      cpf = reviewCPF();
      name = reviewName();
    }
  });

  $('#terms').change(function(){
    if(!(isNull($('#rating_name')) || isNull($('#cpfEvaluate')))){
      enableButtonTerms();
    }
  });

  $('.radio_button').click(function(){
    $('#submitButton').prop("disabled", false);
  });
});
