$(document).ready(function(){
  initialize();
  checkIfEmailIsFill();
  checkIfMessageIsFill();
  checkMail();
  checkMessage();
});

errors = {emailEvaluate: false, messageEvaluate: false}
var checkIfEmailIsFill = function(){
  var $emailEvaluate = $('#emailEvaluate');
  var $buttonSend = $('input[type=submit]');

  $emailEvaluate.keyup(function(){
    if($emailEvaluate.val() != ''){
      $buttonSend.attr('disabled', false)
    }else{
      $buttonSend.attr('disabled', true)
    }
  })
}

var checkIfMessageIsFill = function(){
  var $messageEvaluate = $('#messageEvaluate');
  var $buttonSend = $('input[type=submit]');

  $messageEvaluate.keyup(function(){
    if($messageEvaluate.val() != ''){
      $buttonSend.attr('disabled', false)
    }else{
      $buttonSend.attr('disabled', true)
    }
  })
}

var disableButton = function(){
  $('input[type=submit]').attr('disabled', true)
}

var initialize = function(){
  for(var l in errors){
    if(errors[l] === true){
      return disableButton();
    }
  }
}
function checkMail(){
  var emailExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  var emailInput = $('#emailEvaluate').val();

  if (!emailInput.match(emailExp) || emailInput === ""){
    $('#emailEvaluate').addClass("error");
    errors["emailEvaluate"] = true;
    initialize();
  }else{
    $('#emailEvaluate').removeClass("error");
    errors["emailEvaluate"] = false;
    initialize();
  }
}

function checkMessage(){
  var message = $('#messageEvaluate').val();
  if (message === ""){
    $('#messageEvaluate').addClass("error");
    errors["messageEvaluate"] = true;

  }else{
    $('#messageEvaluate').removeClass("error");
    errors["messageEvaluate"] = false;

  }
}
