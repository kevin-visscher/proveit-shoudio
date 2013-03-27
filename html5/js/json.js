function jsonLoaded(data) {
    var temp = jQuery.parseJSON(data);
    for(var i in temp.contents) {
        if(temp.contents[i].sorting > -1)shoudioObjects.push(temp.contents[i]);
        else shoudioPois.push(temp.contents[i]);
    }
    addrightmenuItems(shoudioObjects);
    addmapItems(shoudioObjects, overlay);
    addmapPoi(shoudioPois, overlay);
    
    var centerLocation = new OpenLayers.Geometry.Point(
        shoudioObjects[0].lon, 
        shoudioObjects[0].lat)
        .transform(fromProjection, toProjection);
    
    map = new OpenLayers.Map({
        div: "openstreetmap", projection: fromProjection,
        layers: [new OpenLayers.Layer.OSM(), overlay],
        center: centerLocation.getBounds().getCenterLonLat(), zoom: 17
    });
    
    /*// A popup with some information about our location 
    var popup = new OpenLayers.Popup.FramedCloud("Popup", 
        centerLocation.getBounds().getCenterLonLat(), null,
        '<a target="_blank" href="http://openlayers.org/">We</a> ' +
        'could be here.<br>Or elsewhere.', null,
        true // <-- true if we want a close (X) button, false otherwise
    );
    // and add the popup to it.
    map.addPopup(popup);*/
    
    var markers = null
    var size = new OpenLayers.Size(36, 47);
    var offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);
    var icon = new OpenLayers.Icon('http://www.waze.co.il/images/home.png', size, offset);
    
    var LL = new OpenLayers.LonLat(shoudioObjects[0].lon, shoudioObjects[0].lat).transform(fromProjection, toProjection);

    if (markers == null) {
        markers = new OpenLayers.Layer.Markers("Markers");
        map.addLayer(markers);
    }

    var marker = new OpenLayers.Marker(LL, icon)
    markers.addMarker(marker);
    var popup = new OpenLayers.Popup.FramedCloud("test", LL, null,
                "testksfdjslfkjsl",
                anchor = null, true, null);
    marker.events.register("click",this.marker,function(e){map.addPopup(popup);});
    
    //map.addPopup(   );
    
    map.removeControl(map.getControl('OpenLayers.Control.Zoom_54'));
    map.removeControl(map.getControl('OpenLayers.Control.Attribution_56'));
}