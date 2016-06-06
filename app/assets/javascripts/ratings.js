$(document).ready(function(){
  $("#telefoneAvaliacao").mask("(99) 9999-9999");
  $("#dataAvaliacao").mask("99/99/9999");
  $('#cpfAvaliacao').mask('999.999.999-99');

  errors = {name: false, cpfAvaliacao: false, dataAvaliacao: false};

  $('#rating_name').focusout(function(){
    validaNome();
  });

  $('#cpfAvaliacao').focusout(function(){
    validaCPF();
  });

  $('#dataAvaliacao').focusout(function(){
    validaData();

  });

  function showMessage(){
    for(var l in errors){
      if(errors[l] === true){
        $('.errorDiv').removeClass("hidden");
        $('#submitButton').prop("disabled", true);
        return;
      }
    }
    $('.errorDiv').addClass("hidden");
    $('#submitButton').prop("disabled", false);
  }

  function validaNome(){
    if($('#rating_name').val() === "" || $('#rating_name').val() === null){
      $('#rating_name').addClass("error");
      errors["name"] = true;
      showMessage();
    } else {
      $('#rating_name').removeClass("error");
      errors["name"] = false;
      showMessage();
    }
  }
  function validaCPF(){
    var valor = 14;
    if ($('#cpfAvaliacao').val() === "___.___.___-__" || $('#cpfAvaliacao').val() === "" || $('#cpfAvaliacao').val().length != valor){
      $('#cpfAvaliacao').addClass("error");
      errors["cpfAvaliacao"] = true;
      showMessage();
    } else {
      $('#cpfAvaliacao').removeClass("error");
      errors["cpfAvaliacao"] = false;
      showMessage();
    }
  }
  function validaData(){
    var RegExPattern = /^((((0?[1-9]|[12]\d|3[01])[\.\-\/](0?[13578]|1[02])      [\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|[12]\d|30)[\.\-\/](0?[13456789]|1[012])[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|((0?[1-9]|1\d|2[0-8])[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?\d{2}))|(29[\.\-\/]0?2[\.\-\/]((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00)))|(((0[1-9]|[12]\d|3[01])(0[13578]|1[02])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|[12]\d|30)(0[13456789]|1[012])((1[6-9]|[2-9]\d)?\d{2}))|((0[1-9]|1\d|2[0-8])02((1[6-9]|[2-9]\d)?\d{2}))|(2902((1[6-9]|[2-9]\d)?(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)|00))))$/;
    if ($('#dataAvaliacao').val() === "__/__/____" || $('#dataAvaliacao').val() == "" || !$('#dataAvaliacao').val().match(RegExPattern)){
      $('#dataAvaliacao').addClass("error");
      errors["dataAvaliacao"] = true;
      showMessage();
    } else {
      $('#dataAvaliacao').removeClass("error");
      errors["dataAvaliacao"] = false;
      showMessage();
    }
  }
  $('#new_rating').submit(function(e){
    validaNome();
    validaCPF();
    validaData();
    if(!$('.errorDiv').hasClass("hidden")){
      e.preventDefault();
    }
  })
});
