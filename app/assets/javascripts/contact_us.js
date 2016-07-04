errorsContact = {emailEvaluateContact: true, messageEvaluate: true, nameEvaluateContact: false}

$(document).ready(function(){
  initialize();


  $('#emailEvaluateContact').focusout(function(){
    checkMailContact();
  });

  $('#messageEvaluate').focusout(function(){
    checkMessage();
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

  function initialize(){
    for(var l in errorsContact){
      if(errorsContact[l] === true){
        return disableButton();
      } else {
        enableButton();
      }
    }
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
      errorsContact["nameEvaluate"] = true;
      initialize();
      showMessage();
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
});
