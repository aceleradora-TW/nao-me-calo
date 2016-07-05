errorsContact = {emailEvaluateContact: true, messageEvaluate: true, nameEvaluateContact: false}

$(document).ready(function(){
  initialize();


  $('#emailEvaluateContact').focusout(function(){
    checkMailContact();
  });

  $('#messageEvaluate').focusout(function(){
    hasBadWordsContact($('#messageEvaluate'));
  });

  $('#nameEvaluateContact').focusout(function(){
    checkNameContact();
  });

  function disableButton(){
    $('#buttonDisable').attr('disabled', true);
  }

  function enableButton(){
    $('#buttonDisable').attr('disabled', false);
  }

  $('#messageEvaluate').keyup(function(){
    countChars($('#messageEvaluate'),500,'limitCharContact');
  });

  function initialize(){
    for(var l in errorsContact){
      if(errorsContact[l] === true){
        return disableButton();
      } else {
        enableButton();
      }
    }
  }

  function countChars(box, limit, campospan){
    var count =  limit  - box.val().length;
    document.getElementById(campospan).innerHTML = "Caracteres restantes: " + count;
  }

  function checkMailContact(){
    var emailExp = /^(([^<>()\[\]\\.,;:=/{}+!\s@"]+(\.[^<>()\[\]\\.,;:=/{}+!\s@]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    var emailInput = $('#emailEvaluateContact').val();
    if (!emailInput.match(emailExp) || emailInput === "" ){
      errorFoundContact('#emailEvaluateContact', '#emailAlertTextContact', '#emailAlertContact');
      errorsContact["emailEvaluateContact"] = true;
      initialize();
    }else{
      errorNotFoundContact('#emailEvaluateContact', '#emailAlertTextContact', '#emailAlertContact')
      errorsContact["emailEvaluateContact"] = false;
      initialize();
    }
  }

  function checkNameContact(){
    var nameExp = /^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$/
    if (checking("#nameEvaluateContact", nameExp)){
      errorNotFoundContact('#nameEvaluateContact', '#nameAlertTextContact', '#nameAlertContact')
      errorsContact["nameEvaluateContact"] = false;
      initialize();
    }
    else {
      errorFoundContact('#nameEvaluateContact', '#nameAlertTextContact', '#nameAlertContact');
      errorsContact["nameEvaluateContact"] = true;
      initialize();
    }
  }

  function checkMessage(){
    var message = $('#messageEvaluate').val();
    if (message === ""){
      errorFoundContact('#messageEvaluate', '#messageAlertText', '#messageAlert');
      errorsContact["messageEvaluate"] = true;
      initialize();
    }else{
      errorNotFoundContact('#messageEvaluate', '#messageAlertText', '#messageAlert')
      errorsContact["messageEvaluate"] = false;
      initialize();
    }
  }

  function errorFoundContact(textAreaId, alertTextId, alertDivId){
    $(textAreaId).addClass("error");
    $(alertTextId).removeClass("hidden");
    $(alertDivId).addClass("text-field-error");
  }

  function errorNotFoundContact(textAreaId, alertTextId, alertDivId){
    $(textAreaId).removeClass("error");
    $(alertTextId).addClass("hidden");
    $(alertDivId).removeClass("text-field-error");
  }

  function hasBadWordsContact(text){
    var count = 0;
    var textLowerCase = text.val().toLowerCase().split(" ");
    for(var i = 0; i <= badwords.length; i++){
      if(textLowerCase.indexOf(badwords[i]) !== -1 ){
        count++;
      }
    }
    badWordsErrorsContact(count, text);
  }

  function badWordsErrorsContact(count, text){
    if(count>0){
      errorsContact["messageEvaluate"] = true;
      text.addClass("error");
      $('#messageAlertTextObscenity' ).removeClass("hidden");
      $('#messageAlert').addClass("text-field-error");
      initialize();
    }
    else {
      errorsContact["messageEvaluate"] = false;
      text.removeClass( "errorBorder" );
      $('#messageAlertTextObscenity').addClass( "hidden" );
      $('#messageAlert').removeClass("text-field-error");
      initialize();
      checkMessage();
    }
  }

});
