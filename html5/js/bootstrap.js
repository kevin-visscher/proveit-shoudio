$(window).load(function() {
    // The overlay layer for our marker, with a simple diamond as symbol
    var overlay = new OpenLayers.Layer.Vector('Overlay', {
        styleMap: new OpenLayers.StyleMap({
            externalGraphic: '../img/marker.png',
            graphicWidth: 25, graphicHeight: 41, graphicYOffset: -41,
            title: '${tooltip}'
        })
    });
    
    var jsondata;
    $.get("json-mooie-ding.json",null,
    function(data) {
        var temp = jQuery.parseJSON(data);
        alert(temp.collection.name);
    });
    
    // The location of our marker and popup. We usually think in geographic
    // coordinates ('EPSG:4326'), but the map is projected ('EPSG:3857').
    var myLocation = new OpenLayers.Geometry.Point(4.8742051100, 52.3671226500)
        .transform('EPSG:4326', 'EPSG:3857');
    
    overlay.addFeatures([
        new OpenLayers.Feature.Vector(myLocation, {tooltip: 'OpenLayers'})
    ]);

    // A popup with some information about our location 
    var popup = new OpenLayers.Popup.FramedCloud("Popup", 
        myLocation.getBounds().getCenterLonLat(), null,
        '<a target="_blank" href="http://openlayers.org/">We</a> ' +
        'could be here.<br>Or elsewhere.', null,
        true // <-- true if we want a close (X) button, false otherwise
    );

    // Finally we create the map
    map = new OpenLayers.Map({
        div: "openstreetmap", projection: 'EPSG:4326',
        layers: [new OpenLayers.Layer.OSM(), overlay],
        center: myLocation.getBounds().getCenterLonLat(), zoom: 15
    });
    // and add the popup to it.
    map.addPopup(popup);
    map.removeControl(map.getControl('OpenLayers.Control.Attribution_23'));
    map.removeControl(map.getControl('OpenLayers.Control.Zoom_21'));
    
    var oldthis;
    $('.rightmenuitems li').click(function() {
        $(oldthis).toggleClass('selected');
        $(this).toggleClass('selected');
        oldthis = this;
    }); 
});

