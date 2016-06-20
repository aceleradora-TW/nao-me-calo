
function checkMail(){
  var emailExp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  var emailInput = $('#emailEvaluate').val();

  if (!emailInput.match(emailExp) || emailInput === ""){
    $('#emailEvaluate').addClass("error");
    errors["emailEvaluate"] = true;
    showMessage();
  }else{
    $('#emailEvaluate').removeClass("error");
    errors["emailEvaluate"] = false;
    showMessage();
  }

}

function checkMessage(){
  var message = $('#messageEvaluate').val();
  if (message === ""){
    $('#messageEvaluate').addClass("error");
    errors["messageEvaluate"] = true;
    showMessage();
  }else{
    $('#messageEvaluate').removeClass("error");
    errors["messageEvaluate"] = false;
    showMessage();
  }
}
