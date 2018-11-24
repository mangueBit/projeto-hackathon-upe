//= require_self
//= require_tree .
$('.bikeModal').click(function(){
    bike_details_request($(this).data("bike_id"))
})

function bike_details_request(input_id){
    $.ajax({
    method: "POST",
    url: "/transporte_details",
    data: { id: input_id }
  });
}