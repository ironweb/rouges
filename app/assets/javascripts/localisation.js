var adress;
var latitudeData = 46.821137;
var longitudeData = -71.25761;
var zoomData=12;
var geocoder;

function updateCoordinate(){
	var latLngTemp= new google.maps.LatLng(latitudeData,longitudeData);
	geocoder.geocode({'latLng':latLngTemp}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			if (results[0]) {
				var adress = results[0].formatted_address.split(', ');
				adress = adress.splice(0, 1) + '<br>' + adress.splice(1).join(', ')
			}
		}
		else{
			adress = "Adresse indisponible";
		}
		$('#localisation').html(adress);
	});
	$("#request_lat").val(latitudeData);
	$("#request_long").val(longitudeData);
}

function initMap() {
	if($('#map_canvas').length === 0) return;
	$("#map_canvas").goMap({
		maptype: 'ROADMAP',
		mapTypeControl: false,
		navigationControl: true,
		zoom: zoomData,
		markers: [{
			latitude: latitudeData,
			longitude: longitudeData,
			draggable: true,
			id: 'testMarker',
			icon: '../img/marker.png'
		}]
	});
	geocoder = new google.maps.Geocoder();
	updateCoordinate();


	// At dragend, update coordinates
	$.goMap.createListener({type:'marker', marker:'testMarker'}, 'dragend', function() {
		var locData = $.goMap.getMarkers("data");
		var sub = locData.substring(10);
		var split= sub.split(",");
		latitudeData=split[0];
		longitudeData=split[1];
		updateCoordinate();
	});

	// At Click on map, move marker to position
	$.goMap.createListener({type:'map'}, 'click', function(event) {
		latitudeData=event.latLng.lat();
		longitudeData=event.latLng.lng();
		$.goMap.setMarker('testMarker',{latitude:latitudeData, longitude:longitudeData});
		updateCoordinate();
	});
}

function success_callback(p) {
	latitudeData = p.coords.latitude;
	longitudeData = p.coords.longitude;
	zoomData=18;
	initMap();
}

function error_callback(p) {
	console.log('error='+p.message);
	initMap();
}

function initLocalisation() {
	if(geo_position_js.init()) {
		geo_position_js.getCurrentPosition(success_callback,error_callback,{enableHighAccuracy:true});
	}
	else{
		console.log("Functionality not available");
		initMap();
	}
}

function initBigMap() {
	$("#enlarge").hide();
	$("#minimize").show();
	$("#map_canvas").animate({height: "350"});
}
function endBigMap() {
	$("#minimize").hide();
	$("#enlarge").show();
	$("#map_canvas").animate({height: "200"});
}

$(document).ready(function() {
	initLocalisation();
	$("#minimize").hide();
	$("#enlarge").bind("click", initBigMap);
	$("#minimize").bind("click", endBigMap);
});
