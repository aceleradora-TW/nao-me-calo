var autocomplete;

function initAutocomplete () {
  //initMap();
  cleanPlaceIdValueFromInput();

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

  function cleanPlaceIdValueFromInput(){
    document.getElementById('place_id').value = '';
    document.getElementById('place_id_2').value = '';
  }

  $(document).ready(function(){
    $('#place_id').attr('readonly', true)
    $('#place_id_2').attr('readonly', true)

    $('#formEvaluate').submit(function(e){
      if($('#place_id').val() == ""){
        e.preventDefault();
      }
    });

    $('#formSearch').submit(function(e){
      if($('#place_id_2').val() == ""){
        e.preventDefault();
      }
    });
  });
/*
  function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -34.397, lng: 150.644},
      zoom: 12
    });
    var infoWindow = new google.maps.InfoWindow({map: map});

    // Try HTML5 geolocation.
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };

        map.setCenter(pos);
      }, function() {
        handleLocationError(true, infoWindow, map.getCenter());
      });
    } else {
      // Browser doesn't support Geolocation
      handleLocationError(false, infoWindow, map.getCenter());
    }
  }
*/
