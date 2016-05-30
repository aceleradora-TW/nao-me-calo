/*
* Chave de uso da API feito com o email do time
*/
var API_KEY = "AIzaSyAJ6NOTnj_jq6jQ0vZPtosWhvoLnoLGlm8";

// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.

var placeSearch, autocomplete;

function initAutocomplete() {
  // Create the autocomplete object, restricting the search to geographical
  // location types.
    input = document.getElementById('buscarLocal');
    searchBox = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('buscarLocal')),
      {types: ['establishment']});
    autocomplete = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('campoBusca')),
      {types: ['establishment']});

    // When the user selects an address from the dropdown, populate the address
    // fields in the form.
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
    alert(place.place_id);
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

  $(document).ready(function(){
    $('#formAvaliar').submit(function(e){
      if($('#place_id').val() == ''){
        e.preventDefault();
      }
    });

    $('#formSearch').submit(function(e){
      if($('#place_id_2').val() == ''){
        e.preventDefault();
      }
    });

  });
