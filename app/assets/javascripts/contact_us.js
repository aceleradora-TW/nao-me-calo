errorsContact = {emailEvaluateContact: true, messageEvaluate: true}

$(document).ready(function(){
  initialize();


  $('#emailEvaluateContact').focusout(function(){
    checkMailContact();
  });

  $('#messageEvaluate').focusout(function(){
    checkMessage();
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
      // $('#emailEvaluateContact').addClass("error");
      // // $('#emailAlertContact').removeClass("hidden");
      // $('#emailAlertTextContact').removeClass("hidden");
      // $('#emailAlertContact').addClass("text-field-error");
      // $('#emailEvaluateContact').removeClass("hidden");
      errorFound('#emailEvaluateContact', '#emailAlertTextContact', '#emailAlertContact');
      errorsContact["emailEvaluateContact"] = true;
      initialize();
    }else{
      $('#emailEvaluateContact').removeClass("error");
      $('#emailAlertContact').removeClass("text-field-error");
      $('#emailAlertTextContact').addClass("hidden");
      errorsContact["emailEvaluateContact"] = false;
      initialize();
    }
  }

function errorFound(textAreaId, alertTextId, alertDivId){
  $(textAreaId).addClass("error");
  $(alertTextId).removeClass("hidden");
  $(alertDivId).addClass("text-field-error");
}

  function checkMessage(){
    var message = $('#messageEvaluate').val();
    if (message === ""){
      errorFound('#messageEvaluate', '#messageAlertText', '#messageAlert');
      // $('#messageEvaluate').addClass("error");
      // $('#messageAlertText').removeClass("hidden");
      // $('#messageAlert').addClass("text-field-error");
      // $('#messageEvaluate').removeClass("hidden");
      errorsContact["messageEvaluate"] = true;
      initialize();
    }else{
      $('#messageEvaluate').removeClass("error");
      $('#messageAlert').removeClass("text-field-error");
      $('#messageAlertText').addClass("hidden");
      errorsContact["messageEvaluate"] = false;
       initialize();
    }
  }
});
