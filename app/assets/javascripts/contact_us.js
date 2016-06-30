errorsContact = {emailEvaluate: true, messageEvaluate: true}

$(document).ready(function(){
  initialize();


  $('#emailEvaluateContact').focusout(function(){
    checkMailContact();
  });

  $('#messageEvaluate').focusout(function(){
    checkMessage();
  });

  function disableButton(){
    $('#button_disable').attr('disabled', true);
  }

  function enableButton(){
    $('#button_disable').attr('disabled', false);
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
    var emailExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    var emailInput = $('#emailEvaluateContact').val();

    if (!emailInput.match(emailExp) || emailInput === "" ){
      $('#emailEvaluateContact').addClass("error");
      $('#emailAlertContact').removeClass("hidden");
      $('#emailAlertTextContact').removeClass("hidden");
      $('#emailAlertContact').addClass("textFieldError");
      $('#emailEvaluateContact').removeClass("hidden");
      errorsContact["emailEvaluateContact"] = true;
      initialize();
    }else{
      $('#emailEvaluateContact').removeClass("error");
      $('#emailAlertContact').removeClass("textFieldError");
      $('#emailAlertTextContact').addClass("hidden");
      errorsContact["emailEvaluateContact"] = false;
      initialize();
    }
  }

  function checkMessage(){
    var message = $('#messageEvaluate').val();
    if (message === ""){
      $('#messageEvaluate').addClass("error");
      $('#messageAlertText').removeClass("hidden");
      $('#messageAlert').addClass("textFieldError");
      $('#messageEvaluate').removeClass("hidden");
      errorsContact["messageEvaluate"] = true;
      initialize();
    }else{
      $('#messageEvaluate').removeClass("error");
      $('#messageAlert').removeClass("textFieldError");
      $('#messageAlertText').addClass("hidden");
      errorsContact["messageEvaluate"] = false;
      initialize();
    }
  }
});
