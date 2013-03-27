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
        controls: [new OpenLayers.Control.Navigation(), 
                   new OpenLayers.Control.ArgParser(), 
                   new OpenLayers.Control.Attribution()],
        center: centerLocation.getBounds().getCenterLonLat(), zoom: 17
    });
    
    addMarker();
    
    map.removeControl(map.getControl('OpenLayers.Control.Zoom_54'));
    map.removeControl(map.getControl('OpenLayers.Control.Attribution_56'));
}