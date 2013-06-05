/**
* Function that will process the json data from shoudio
* 
* @param (data) jsondata
*/
function jsonLoaded(data) {
    
    data = jQuery.parseJSON(data);
    
    this.collection = data.collection;

    for(var i in data.contents) {
        if(data.contents[i].sorting > -1)shoudioObjects.push(data.contents[i]);
    }
    
    overlay = new OpenLayers.Layer.Vector('Overlay');
    
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
    
    selectMarkerControl = new OpenLayers.Control.SelectFeature(overlay, {onSelect: onFeatureSelect, onUnselect: onFeatureUnselect});
    map.addControl(selectMarkerControl);
    selectMarkerControl.activate();
    
    drawLines(data.collection.route, overlay);
    addmapItems(data.contents, overlay);
    startmenu(this.collection);

    map.removeControl(map.getControl('OpenLayers.Control.Zoom_54'));
    $(".olControlAttribution").remove();

}