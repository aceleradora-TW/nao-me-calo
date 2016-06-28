errorsContact = {emailEvaluate: true, messageEvaluate: true}

$(document).ready(function(){
  initialize();
});

$('#emailEvaluate').focusout(function(){
  checkMail();
});

$('#messageEvaluate').focusout(function(){
  checkMessage();
});

var disableButton = function(){
  $('#button_disable').attr('disabled', true);
}

var enableButton = function(){
  $('#button_disable').attr('disabled', false);
}

var initialize = function(){
  for(var l in errorsContact){
    if(errorsContact[l] === true){
      return disableButton();
    } else {
      enableButton();
    }
  }
}
function checkMail(){
  var emailExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  var emailInput = $('#emailEvaluate').val();

  if (!emailInput.match(emailExp) || emailInput === ""){
    $('#emailEvaluate').addClass("error");
    $('#emailAlert').removeClass("hidden");
    $('#emailAlert').addClass("textFieldError");
    $('#emailEvaluate').removeClass("hidden");
    errorsContact["emailEvaluate"] = true;
    initialize();
  }else{
    $('#emailEvaluate').removeClass("error");
    errorsContact["emailEvaluate"] = false;
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
    errorsContact["messageEvaluate"] = false;
    initialize();
  }
}
