$(window).load(function() {
	$('#featured').orbit();
	map = new OpenLayers.Map("demoMap");
    map.addLayer(new OpenLayers.Layer.OSM());
    map.zoomToMaxExtent();
});

function slideaway() {
	$('#rechtermenu').fadeOut('slow');
}