/**
* Bootstrap, main javascript file
*/
var shoudioObjects = [];
var shoudioPois = [];
var marker = [];
var shoudioObjectsPointer = {};
var markers;
var map;
var fromProjection;
var toProjection;
var oldthis;
var overlay;
var selectMarkerControl;
var selectedFeature;
var popup;
var icon;
var collection;
var youtubePlayer;
var audioInterval;

$(function() {
    
    fromProjection = new OpenLayers.Projection("EPSG:4326");  // Transform from WGS 1984
    toProjection   = new OpenLayers.Projection("EPSG:3857");
    
    $.get("hva-route-1.json",null, jsonLoaded);
    
    //add rightmenuclick handler
    $('.rightmenuitems li').live('click', rightmenuClick);
});