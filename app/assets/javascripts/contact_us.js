errorsContact = {emailEvaluateContact: true, messageEvaluate: true, nameEvaluateContact: false}

$(document).ready(function(){
  initialize();
   patternLinks();
  var dots = 0;

  $('#discriminacao_down').addClass('hidden')
  $('#violencia_down').addClass('hidden')
  $('#racial_down').addClass('hidden')
  $('#homofobia_down').addClass('hidden')
  $('#mental_down').addClass('hidden')
  $('#transmissiveis_down').addClass('hidden')

  function patternLinks(){
      $('#abuse-first').click(function(){
        $('#article-1').fadeToggle("slow");
        $('#discriminacao_down').toggleClass('hidden');
        $('#discriminacao_right').toggleClass('hidden');
      });

      $('#abuse-second').click(function(){
          $('#article-2').fadeToggle("slow");
          $('#violencia_down').toggleClass('hidden');
          $('#violencia_right').toggleClass('hidden');
      });

      $('#abuse-three').click(function(){
          $('#article-3').fadeToggle("slow");
          $('#racial_down').toggleClass('hidden');
          $('#racial_right').toggleClass('hidden');

      });

      $('#abuse-four').click(function(){
          $('#article-4').fadeToggle("slow");
          $('#homofobia_down').toggleClass('hidden');
          $('#homofobia_right').toggleClass('hidden');
      });

      $('#abuse-five').click(function(){
          $('#article-5').fadeToggle("slow");
          $('#mental_down').toggleClass('hidden');
          $('#mental_right').toggleClass('hidden');
      });

      $('#abuse-six').click(function(){
          $('#article-6').fadeToggle("slow");
          $('#transmissiveis_down').toggleClass('hidden');
          $('#transmissiveis_right').toggleClass('hidden');
      });
 }



 $('#messageEvaluate').keyup(function(){
   hasBadWordsContact();
 })

  $('#emailEvaluateContact').focusout(function(){
    isInvalidMail();
  });

  $('#emailEvaluateContact').keyup(function(){
    checkMailContact();
  });

  $('#messageEvaluate').keyup(function(){
    hasBadWordsContact();
  });

  $('#messageEvaluate').focusout(function(){
    isInvalidMessage();
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

  function loadDots(){
    if(dots < 3){
      $('#buttonDisable').val($('#buttonDisable').val() + ".");
      dots++;
    } else {
      $('#buttonDisable').val("Aguarde");
      dots = 0;
    }
  }

  $('#messageEvaluate').keyup(function(){
    countChars($('#messageEvaluate'),500,'limitCharContact');
  });

  $('#form-contact').submit(function(){
    disableButton();
    $('#buttonDisable').val("Aguarde");
    setInterval(loadDots, 600);
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
      errorsContact["emailEvaluateContact"] = true;
      initialize();
    }else{
      errorNotFoundContact('#emailEvaluateContact', '#emailAlertTextContact', '#emailAlertContact');
      errorsContact["emailEvaluateContact"] = false;
      initialize();
    }
  }

  function isInvalidMail(){
    if(errorsContact["emailEvaluateContact"]){
      errorFoundContact('#emailEvaluateContact', '#emailAlertTextContact', '#emailAlertContact');
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

  function hasBadWordsContact(){
    var text = $('#messageEvaluate');
    var count = 0;
    var textLowerCase = text.val().toLowerCase().split(" ");
    for(var i = 0; i <= badwords.length; i++){
      for(j=0; j <= textLowerCase.length; j++){
        if(textLowerCase[j] == badwords[i]){
          count++;
          break;
        }
      }
    }
    badWordsErrorsContact(count, text);
  }

  function badWordsErrorsContact(count, text){
    if(count > 1){
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

    function checkMessage(){
      var message = $('#messageEvaluate').val();
      if (message === ""){
        errorsContact["messageEvaluate"] = true;
        initialize();
      }else{
        errorNotFoundContact('#messageEvaluate', '#messageAlertText', '#messageAlert')
        errorsContact["messageEvaluate"] = false;
        initialize();
      }
    }

    function isInvalidMessage(){
      if(errorsContact["messageEvaluate"]){
        errorFoundContact('#messageEvaluate', '#messageAlertText', '#messageAlert');
      }
    }

});
