/*
* Chave de uso da API feito com o email do time
*/
var API_KEY = "AIzaSyAJ6NOTnj_jq6jQ0vZPtosWhvoLnoLGlm8";

// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.

var autocomplete;

function initAutocomplete() {

  var searchField = (document.getElementById('searchField'));
  var types = {types: ['establishment']};

  searchBox = new google.maps.places.Autocomplete( searchField, types);

  autocomplete = new google.maps.places.Autocomplete(
    (document.getElementById('evaluateField')),
    {types: ['establishment']});

    autocomplete.addListener('place_changed', fillName);
    searchBox.addListener('place_changed', fillSearch);
  }

  function fillName(){
    var place = autocomplete.getPlace();
    document.getElementById("place_id").value = place.place_id;
  }

  function fillSearch(){
    var place = searchBox.getPlace();
    document.getElementById("place_id_2").value = place.place_id;
  }


  // [END region_fillform]

  // [START region_geolocation]
  // Bias the autocomplete object to the user's geographical location,
  // as supplied by the browser's 'navigator.geolocation' object.
  function geolocate() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var geolocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        var circle = new google.maps.Circle({
          center: geolocation,
          radius: position.coords.accuracy
        });
        autocomplete.setBounds(circle.getBounds());
        searchBox.setBounds(circle.getBounds());
      });
    }
  }
  // [END region_geolocation]

  function dontSubmitOnEmpty(){
    var formEvaluate = document.getElementById('formEvaluate');
    formEvaluate.addEventListener('submit', function(event){
      var place_id = document.getElementById('place_id');
      if(place_id.value == ''){
        event.preventDefault();
      }
    });

    var formSearch = document.getElementById('formSearch');
    formSearch.addEventListener('submit', function(event){
      var place_id_2 = document.getElementById('place_id_2');
      if(place_id.value == ''){
        event.preventDefault();
      }
    });
  }

  function cleanPlaceIdValueFromInput(){
    document.getElementById('place_id').value = '';
    document.getElementById('place_id_2').value = '';
  }

  $(document).ready(function(){
    geolocate();
    cleanPlaceIdValueFromInput();
    dontSubmitOnEmpty();
    $('#place_id').attr('readonly', true);
    $('#place_id_2').attr('readonly', true);
  });
