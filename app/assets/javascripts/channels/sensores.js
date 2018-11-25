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
    icon = {
      path :"M336 448H16c-8.84 0-16 7.16-16 16v32c0 8.84 7.16 16 16 16h320c8.84 0 16-7.16 16-16v-32c0-8.84-7.16-16-16-16zm208-320V80c0-8.84-7.16-16-16-16s-16 7.16-16 16v48h-32V80c0-8.84-7.16-16-16-16s-16 7.16-16 16v48h-16c-8.84 0-16 7.16-16 16v32c0 35.76 23.62 65.69 56 75.93v118.49c0 13.95-9.5 26.92-23.26 29.19C431.22 402.5 416 388.99 416 372v-28c0-48.6-39.4-88-88-88h-8V64c0-35.35-28.65-64-64-64H96C60.65 0 32 28.65 32 64v352h288V304h8c22.09 0 40 17.91 40 40v24.61c0 39.67 28.92 75.16 68.41 79.01C481.71 452.05 520 416.41 520 372V251.93c32.38-10.24 56-40.17 56-75.93v-32c0-8.84-7.16-16-16-16h-16zm-283.91 47.76l-93.7 139c-2.2 3.33-6.21 5.24-10.39 5.24-7.67 0-13.47-6.28-11.67-12.92L167.35 224H108c-7.25 0-12.85-5.59-11.89-11.89l16-107C112.9 99.9 117.98 96 124 96h68c7.88 0 13.62 6.54 11.6 13.21L192 160h57.7c9.24 0 15.01 8.78 10.39 15.76z",
      fillColor: 'green',
      fillOpacity: 1,
      strokeWeight: 1,
      scale: .06
    }
    marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          title: `Sensor: ${json["code"]}`,
          icon: icon
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
      }, 1000);
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