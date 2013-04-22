/**
* 
*/
var shoudioObjects = [];
var shoudioPois = [];
var marker = [];
var map;
var fromProjection;
var toProjection;
var oldthis;
var overlay;
var popup;
var markers;
var icon;

$(function() {
    
    fromProjection = new OpenLayers.Projection("EPSG:4326");  // Transform from WGS 1984
    toProjection   = new OpenLayers.Projection("EPSG:3857");
    
    var size = new OpenLayers.Size(25, 41);
    var offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);
    icon = new OpenLayers.Icon('img/marker.png', size, offset);
    
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