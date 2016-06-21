$(document).ready(function(){

  $('#submitButton').prop("disabled", true);

  $("#phoneEvaluate").mask("(99) 9999-9999");
  $("#dateEvaluate").mask("99/99/9999");
  $('#cpfEvaluate').mask('999.999.999-99');

  $('#submitButton').prop("disabled", true);

  errors = {cpfEvaluate: false, rating: true, dateEvaluate: false};

  if ( $('[type="date"]').prop('type') != 'date' ) {
    $('[type="date"]').datepicker();
  }

  $('#emailEvaluate').focusout(function(){
    checkMail();
  });

  $('#nameEvaluate').focusout(function(){
    //reviewName();
    checkName();
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
    if (!$(".radio_button").is(":checked")){
      $( "#radio_button_id" ).addClass( "errorBorder");
    }else{
      $( "#radio_button_id" ).removeClass( "errorBorder");
    }
    for(var l in errors){
      if(errors[l] === true){
        $('.errorDiv').removeClass("hidden");
        $('#submitButton').prop("disabled", true);
        return;
      }
    }
    if(enableButtonTerms()){
      $('.errorDiv').addClass("hidden");
      $('#submitButton').prop("disabled", false);
    }
  }

  // function reviewName(){
  //   if($('#nameEvaluate').val() === "" || $('#nameEvaluate').val() === null){
  //     $('#nameEvaluate').addClass("error");
  //     errors["name"] = true;
  //     showMessage();
  //   } else {
  //     $('#nameEvaluate').removeClass("error");
  //     errors["name"] = false;
  //     showMessage();
  //   }
  // }

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

    if ( strCPF == "00000000000" || strCPF == "11111111111" || strCPF == "22222222222" || strCPF == "33333333333" || strCPF == "44444444444" || strCPF == "55555555555" || strCPF == "66666666666" || strCPF == "77777777777" || strCPF == "88888888888" || strCPF == "99999999999" || strCPF == "01234567890") return true;

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

    if (((today < ratingDate) || (ratingDate <730000)) || $('#dateEvaluate').val() === "__/__/____" || $('#dateEvaluate').val() == "" || !$('#dateEvaluate').val().match(RegExPattern)){
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

  function checkName(){
    var nameExp = /^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$/
    var nameInput = $('#nameEvaluate').val();

    if (!nameInput.match(nameExp) && nameInput !==""){
      $('#nameEvaluate').addClass("error");
      showMessage();
    }else{
      $('#nameEvaluate').removeClass("error");
      showMessage();
    }

  }

  function checkMail(){
    var emailExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    var emailInput = $('#emailEvaluate').val();

    if (!emailInput.match(emailExp) && emailInput !==""){
      $('#emailEvaluate').addClass("error");
      showMessage();
    }else{
      $('#emailEvaluate').removeClass("error");
      showMessage();
    }
  }

  function enableButtonTerms(){
    if(!(isNull($('#cpfEvaluate')) || isNull($('#dateEvaluate')))){
      if($('#terms:checked').length === 1){
        $('#submitButton').prop("disabled", false);
        return true;
      } else {
        $('#submitButton').prop("disabled", true);
        return false;
      }
    }
  }

//código comentado, ele evita que avaliacao seja enviada sem nome e sem cpf caso botao seja clicado, mas tal acao é impossível, uma vez que o botao vai estar disable
//ps: o campo nome nao é obrigatorio
  // $('#new_rating').submit(function(e){
  //   if(isNull($('#nameEvaluate')) || isNull($('#cpfEvaluate'))){
  //     e.preventDefault();
  //     cpf = reviewCPF();
  //     name = reviewName();
  //   }
  // });

  $('#terms').change(function(){
    if(!(errors['cpfEvaluate'] || isNull($('#cpfEvaluate')) || errors["rating"] || isNull($('#dateEvaluate')) || errors["dateEvaluate"])){
      enableButtonTerms();
    }
  });

  $('.radio_button').click(function(){
    errors["rating"] = false;
    enable = enableButtonTerms();
    show = showMessage();
  });

});
