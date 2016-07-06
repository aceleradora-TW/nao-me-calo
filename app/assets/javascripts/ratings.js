$(document).ready(function(){



  $('#phoneEvaluate').mask('(99) 9999-9999');
  $('#dateEvaluate').mask('99/99/9999');
  $('#cpfEvaluate').mask('999.999.999-99');
  $('#submitButton').prop('disabled', true);

  errors = {cpfEvaluate: false, rating: true, dateEvaluate: false, description: false};
  
  if ( $('[type="date"]').prop('type') !== 'date' ) {
      $('[type="date"]').datepicker();
  }

  $('#emailEvaluate').focusout(function(){
    checkMail();
  });

  $('#nameEvaluate').focusout(function(){
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

  $('#ratingDescription').focusout(function(){
    hasBadWords($('#ratingDescription'));
  });

  $('#ratingDescription').keyup(function(){
    countChars($('#ratingDescription'),500,'limitChar');
  });

  $('#clearButton').click(function(){
    $('.radio-button').removeAttr('checked');
  });


  function hasBadWords(text){

    var count = 0;
    var textLowerCase = text.val().toLowerCase();
    for(var i = 0; i <= badwords.length; i++){
      if(textLowerCase.indexOf(badwords[i]) !== -1 ){
        count++;
        break;
      }
    }
    badWordsErrors(count, text);
  }

  function badWordsErrors(count, text){
    var hasError = (count==1);
    if(hasError){
      errors['description'] = hasError;
      text.addClass('errorBorder');
      $('#descriptionAlertText').removeClass('hidden');
      $('#descriptionAlert').addClass('text-field-error');
      showMessage();
    }
    else {
      errors['description'] = hasError;
      text.removeClass('errorBorder');
      $('#descriptionAlertText').addClass('hidden');
      $('#descriptionAlert').removeClass('text-field-error');
      showMessage();
    }
  }

  function showMessage(){
    if (!$('.radio-button').is(':checked')){
      $('#radioButtonId').addClass('errorBorder');
    }else{
      $('#radioButtonId').removeClass('errorBorder');
    }
    for(var l in errors){
      if(errors[l] === true){
        $('#submitButton').prop('disabled', true);
        return;
      }
    }
    if(enableButtonTerms()){
      $('#submitButton').prop('disabled', false);
    }
  }
  function reviewCPF(){

    var teste = $('#cpfEvaluate').val().split('.').join('').split('-').join('');
    var erro = CPFTest(teste);
    if(erro) {
      $('#cpfEvaluate').addClass('error');
      $('#cpfAlert').removeClass('hidden');
      $('#cpfAlert').addClass('text-field-error');
      $('#cpfAlertText').removeClass('hidden');
      errors['cpfEvaluate'] = true;
      showMessage();
    } else {
      $('#cpfEvaluate').removeClass('error');
      $('#cpfAlertText').addClass('hidden');
      $('#cpfAlert').removeClass('text-field-error')
      errors['cpfEvaluate'] = false;
      showMessage();
    }
  }

  function CPFTest(strCPF){
    var sum;
    var rest;
    sum = 0;

    if ( strCPF === '00000000000' || strCPF === '11111111111' || strCPF === '22222222222' || strCPF === '33333333333' || strCPF === '44444444444' || strCPF === '55555555555' || strCPF === '66666666666' || strCPF === '77777777777' || strCPF === '88888888888' || strCPF === '99999999999' || strCPF === '01234567890') return true;

    for (i=1; i<=9; i++) sum = sum + parseInt(strCPF.substring(i-1, i), 10) * (11 - i);
    rest = (sum * 10) % 11;

    if ((rest === 10) || (rest === 11))  rest = 0;
    if (rest !== parseInt(strCPF.substring(9, 10), 10) ) return true;

    sum = 0;
    for (i = 1; i <= 10; i++) sum = sum + parseInt(strCPF.substring(i-1, i), 10) * (12 - i);
    rest = (sum * 10) % 11;

    if ((rest === 10) || (rest === 11))  rest = 0;
    if (rest !== parseInt(strCPF.substring(10, 11), 10 ) ) return true;
    return false;
  }

  function reviewDate(){
    var regExPattern = /^((((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02]) {6}[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00)))|(((0[1-9]|[12]\d|3[01])(0[13578]|1[02])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|[12]\d|30)(0[13456789]|1[012])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|1\d|2[0-8])02((1[6-9]|[2-9]\d)?\d{2}))|(2902((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00))))$/;
    var ratingDate = $('#dateEvaluate').val();
    var date = new Date();

    var today = date.getDate() + ((date.getMonth()+1) * 30) + (date.getFullYear() * 365);
    ratingDate = parseInt(ratingDate.substring(0,2), 10) + (parseInt(ratingDate.substring(3,5), 10) * 30) + (parseInt(ratingDate.substring(6), 10) * 365);

    if (((today < ratingDate) || (ratingDate <730000)) || $('#dateEvaluate').val() === '__/__/____' || $('#dateEvaluate').val() === '' || !$('#dateEvaluate').val().match(regExPattern)){
      $('#dateEvaluate').addClass('error');
      $('#dateAlert').addClass('text-field-error');
      $('#dateAlertText').removeClass('hidden');
      errors['dateEvaluate'] = true;
      showMessage();
    } else {
      $('#dateEvaluate').removeClass('error');
      $('#dateAlertText').addClass('hidden');
      $('#dateAlert').removeClass('text-field-error');
      errors['dateEvaluate'] = false;
      showMessage();
    }
  }

  function isNull(parameter){
    if(parameter.val() === null || parameter.val() === ''){
      return true;
    } else {
      return false;
    }
  }

  function checkName(){
    var nameExp = /^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$/
    if (checking('#nameEvaluate', nameExp)){
      $('#nameEvaluate').removeClass('error');
      $('#nameAlertText').addClass('hidden');
      errors['nameEvaluate'] = false;
      showMessage();
    }else{
      $('#nameEvaluate').addClass('error');
      $('#nameAlertText').removeClass('hidden');
      errors['nameEvaluate'] = true;
      showMessage();
    }
  }

  function checkMail(){
    var emailExp = /^(([^<>()\[\]\\.,;:=/{}+!\s@']+(\.[^<>()\[\]\\.,;:=/{}+!\s@]+)*)|('.+'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if(checking('#emailEvaluate', emailExp)){
      $('#emailEvaluate').removeClass('error');
      $('#emailAlertText').addClass('hidden');
      errors['emailEvaluate'] = false;
      showMessage();
    }else{
      $('#emailEvaluate').addClass('error');
      $('#emailAlertText').removeClass('hidden');
      errors['emailEvaluate'] = true;
      showMessage();
    }
  }

  function enableButtonTerms(){
    if(!(isNull($('#cpfEvaluate')) || isNull($('#dateEvaluate')))){
      if($('#terms:checked').length === 1){
        $('#submitButton').prop('disabled', false);
        return true;
      } else {
        $('#submitButton').prop('disabled', true);
        return false;
      }
    }
  }

  $('#terms').change(function(){
    if(!(errors['cpfEvaluate'] || isNull($('#cpfEvaluate')) || errors['rating'] || isNull($('#dateEvaluate')) || errors['dateEvaluate'] || errors['nameEvaluate'] || errors['emailEvaluate'] || errors['description'])){
      enableButtonTerms();    }
    });

    $('.radio-button').click(function(){
      errors['rating'] = false;
      enable = enableButtonTerms();
      show = showMessage();
    });

    function countChars(box, limit, fieldspan){
      var count =  limit  - box.val().length;
      document.getElementById(fieldspan).innerHTML = 'Caracteres restantes: ' + count;
    }

  });

  function checking(inputId, exp){
    var input = $(inputId).val();
    if (input.match(exp) || $(inputId).val() === '' || $(inputId).val() === null) {
      return true
    }
    else {
      return false
    }
  }
