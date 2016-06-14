var autocomplete;

var map;

function initAutocomplete () {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -30.0277, lng: -51.2287},
    zoom: 12
  });
  initMap();
  createPin();
  cleanPlaceIdValueFromInput();
  initLists();

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
    $('#best_places_button').click(function(){
      switchListBest();
    })
    $('#worst_places_button').click(function(){
      switchListWorst();
    })
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

  function initMap() {

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

  function initLists(){
    $('#bottom_5').hide();
  }

  function switchListBest(){
    if($("#bottom_5").is(":visible")){
      $('#top_5').show();
      $('#bottom_5').hide();
    }
  }

  function switchListWorst(){
    if($("#top_5").is(":visible")){
      $('#top_5').hide();
      $('#bottom_5').show();
    }
  }

  function createPin(){
    for(var i=0; i<locations.length; i++){
      var locate = locations[i];
      var rating = locate[3];
      console.log(rating);
      var iconColor;
      if(rating<=1.5){
        iconColor = "http://maps.google.com/mapfiles/ms/icons/red-dot.png";
      } else {
        if(rating<=3.5){
          iconColor = "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png";
        }else{
          iconColor = "http://maps.google.com/mapfiles/ms/icons/green-dot.png";
        }
      }
      var myLatLng = {lat: locate[1], lng: locate[2]};
      var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        title: locate[0],
        icon: iconColor
      });
    }
  }
