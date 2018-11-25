//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

App.messages = App.cable.subscriptions.create('SensoresChannel', {  
  received: function(data) {
    console.log(data)
    json = JSON.parse(data)
    latlong = json["local"].split("_")
    lat = parseFloat(latlong[0].replace('/', ""))
    long = parseFloat(latlong[1].replace("", ""))
    console.log(sensores_ativos)
    myLatLng = {lat: lat, lng: long}
    sensores_ativos
    marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          title: `Sensor: ${json["code"]}`
        });
    marker["code"] = json["code"]
    google.maps.event.addListener(marker, 'click', function(event) {
          //load_info($(this).data("code"));
          load_info(this.code);
        });
    if (sensores_ativos[`${json["sensor_id"]}`] != null){
      var actual = sensores_ativos[`${json["sensor_id"]}`]
      setTimeout(function(){
        deleteMarker(actual);
      }, 3000);
    }
    sensores_ativos[`${json["sensor_id"]}`] = marker
    
    if ($(`.sensor_luminosidade_${json["sensor_id"]}`) != undefined){
      $(`.sensor_luminosidade_${json["sensor_id"]}`).html(`${json["luminosidade"]} lux`)
    }
    
  },

  connected: function() {
    console.log("conected into websocket")
  },

  disconnected: function() {
      console.log("disconnected from websocket")
  },
});

function deleteMarker(marker){
  marker.setMap(null);
}

function load_label(data,lats,long){
  var pos = {
    lat: lats,
    lng: long
  };
  var infoWindow = new google.maps.InfoWindow;
  infoWindow.setPosition(pos);
  infoWindow.setContent(`<h6>Localização:</h6> <br> <h6>Latitude:</h6> ${lats} <br> <h6>Longitude:</h6> ${long}<br><h6>ID: ${data["sensor_id"]}</h6>`);
  infoWindow.open(map);
}

function load_info(id){
  $.ajax({
    method: "POST",
    url: "/sensor_detail",
    data: { sensor_id: id }
  });
}