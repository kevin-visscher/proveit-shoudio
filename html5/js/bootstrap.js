var shoudioObjects = [];
var shoudioPois = [];
var map;
var fromProjection;
var toProjection;
var oldthis;
var overlay;

$(function() {
    // The overlay layer for our marker, with a simple diamond as symbol
    fromProjection = new OpenLayers.Projection("EPSG:4326");  // Transform from WGS 1984
    toProjection   = new OpenLayers.Projection("EPSG:3857");
    
    overlay = new OpenLayers.Layer.Vector('Overlay', {
        styleMap: new OpenLayers.StyleMap({
            externalGraphic: 'img/marker.png',
            graphicWidth: 25, graphicHeight: 41, graphicYOffset: -41,
            title: '${tooltip}'
        })
    });
    
    $.get("json-mooie-ding.json",null, jsonLoaded);
    
    //add rightmenuclick handler
    $('.rightmenuitems li').live('click', rightmenuClick);
    
});