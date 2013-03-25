function jsonLoaded(data) {
    var temp = jQuery.parseJSON(data);
    for(var i in temp.contents) {
        if(temp.contents[i].sorting > -1)shoudioObjects.push(temp.contents[i]);
    }
    addrightmenuItems(shoudioObjects);
    addmapItems(shoudioObjects, overlay);
    
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
        myLocation.getBounds().getCenterLonLat(), null,
        '<a target="_blank" href="http://openlayers.org/">We</a> ' +
        'could be here.<br>Or elsewhere.', null,
        true // <-- true if we want a close (X) button, false otherwise
    );*/
    // and add the popup to it.
    //map.addPopup(popup);
    map.removeControl(map.getControl('OpenLayers.Control.Zoom_46'));
    map.removeControl(map.getControl('OpenLayers.Control.Attribution_48'));
}