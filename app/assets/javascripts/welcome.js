//= require header-mobile

var autocomplete;
var map;

function initAutocomplete () {
  var mapField = $('#map')[0]
  map = new google.maps.Map(mapField, {
    center: {lat: -30.0277, lng: -51.2287},
    zoom: 12
  });

  initMap();
  createPin();
  cleanPlaceIdValueFromInput();
  initLists();

  var searchField = $('#searchField')[0];
  var types = {types: ['establishment']};

  searchBox = new google.maps.places.Autocomplete(searchField, types);

  var evaluateField = $('#evaluateField')[0];

  autocomplete = new google.maps.places.Autocomplete(
    (evaluateField),
    {types: ['establishment']});

    autocomplete.addListener('place_changed', fillName);
    searchBox.addListener('place_changed', fillSearch);

    $('#evaluateField').change("fillName()");
    $('#searchField').change("fillSearch()");
    $('#searchField').focus("geolocate()");
    $('#searchField').keydown("list_places()");
    $('#evaluateField').keydown("list_places()");


    // Create the search box and link it to the UI element.
    var input = document.getElementById('map_search');
    var searchBoxMap = new google.maps.places.SearchBox(input);
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    // Bias the SearchBox results towards current map's viewport.
    map.addListener('bounds_changed', function() {
      searchBoxMap.setBounds(map.getBounds());
    });

    var markers = [];
    // Listen for the event fired when the user selects a prediction and retrieve
    // more details for that place.
    searchBoxMap.addListener('places_changed', function() {
      var places = searchBoxMap.getPlaces();

      if ( places.length === 0 ) {
        return;
      }

      // Clear out the old markers.
      markers.forEach(function(marker) {
        marker.setMap(null);
      });
      markers = [];

      // For each place, get the icon, name and location.
      var bounds = new google.maps.LatLngBounds();
      places.forEach(function(place) {
        var icon = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };

        // Create a marker for each place.
        markers.push(new google.maps.Marker({
          map: map,
          icon: icon,
          title: place.name,
          position: place.geometry.location
        }));

        if (place.geometry.viewport) {
          // Only geocodes have viewport.
          bounds.union(place.geometry.viewport);
        } else {
          bounds.extend(place.geometry.location);
        }
      });

      map.fitBounds(bounds);
      map.setZoom(15);
    });
  }

  function fillName(){
    var place = autocomplete.getPlace();
    $('#placeId').val(place.place_id);
  }

  function fillSearch(){
    var place = searchBox.getPlace();
    $('#placeId2').val(place.place_id);
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
    $('#placeId').val('');
    $('#placeId2').val('');
  }

  function initMap() {

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

  function createPin(){
    for(var i = 0; i<locations.length; i++){
      var locate = locations[i];
      var iconColor = locate[3];
      var myLatLng = {lat: locate[1], lng: locate[2]};
      var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        title: locate[0],
        icon: iconColor,
        optimized: false
      });
      var contentString = '<div id="content">'+
      '<a href="/perfil/' + locate[4].toString() + '">';

      if (locate[7]) {
        contentString = contentString + '<h4><label class="concept ' + locate[6].toString() + '">' + locate[5].toString() + '</label></h4>'
      }
      contentString = contentString + '<h3 id="firstHeading" class="text-center">'+ locate[0].toString() +'</h3>'+
      '<div id="bodyContent"></a>'+
      '</div>'+
      '</div>';
      marker.info = new google.maps.InfoWindow({
        content: contentString
      });
      google.maps.event.addListener(marker, 'click', function(){
        var marker_map = this.getMap();
        this.info.open(marker_map, this);
      });
    }
  }

  function initLists(){
    $('#bottom5').hide();
  }

  $(document).ready(function(){

    openHeaderMobile();

    var isMobile = window.matchMedia("only screen and (max-width: 760px)");

    initLists();
    checkOffset();
    checkMobileEnhanceButtons();

    var actualFontSize = 14
    $("#upperFontSizeButton").click(upperFontSize);

    $("#lowerFontSizeButton").click(lowerFontSize);

    function switchListBest(){
      if($('#bottom5').is(":visible")){
        $('#top5').show();
        $('#bottom5').hide();
      }
    }

    function switchListWorst(){
      if($("#top5").is(":visible")){
        $('#top5').hide();
        $('#bottom5').show();
      }
    }

    function lowerFontSize(){
      var min = 14
      if(actualFontSize>min){
        actualFontSize = actualFontSize-2;
        $("body").css("font-size", actualFontSize + "px");
      }
    }

    function upperFontSize() {
      var max = 18
      if(actualFontSize<max){
        actualFontSize = actualFontSize+2;
        $("body").css("font-size", actualFontSize + "px");
      }
    }

    $(document).scroll(function() {
      if(!isMobile.matches){
        checkOffset();
      }
    });

    function checkMobileEnhanceButtons(){
      if(isMobile.matches){
        $('#buttons-enhance').hide();
      }
    }

    function checkOffset(){
      var buttons = $('#buttons-enhance');
      if(buttons.scrollTop()==0)
        buttons.css({'position': 'absolute', "bottom": "125px", "left": "6px"});
      if($(document).scrollTop() + window.innerHeight < $('footer').offset().top)
        buttons.css({'position': 'fixed', "bottom": "2px", "left": "6px"});
    }

    $('#bestPlacesButton').click(function(){
      switchListBest();
    })
    $('#worstPlacesButton').click(function(){
      switchListWorst();
    })
    $('#placeId').attr('readonly', true)
    $('#placeId2').attr('readonly', true)

    $('#formEvaluate').submit(function(e){
      if($('#placeId').val() === ''){
        e.preventDefault();
      }
    });

    $('#formSearch').submit(function(e){
      if($('#placeId2').val() === ''){
        e.preventDefault();
      }
    });
  });
