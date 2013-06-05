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
var currenctsec;
var maxsec;
var status;

$(function() {
    
    fromProjection = new OpenLayers.Projection("EPSG:4326");  // Transform from WGS 1984
    toProjection   = new OpenLayers.Projection("EPSG:3857");
    
    //$.get("hva-route-1.json",null, jsonLoaded);
    $.get("json-mooie-ding.json",null, jsonLoaded);
    
    // adding click handlers
    $('.rightmenuitems li').live('click', rightmenuClick);
    $(".rightmenuitems li").live({mouseenter: rightmenuHover, mouseleave: rightmenuLeave});
	$("#playbutton").click(audioPlay);
	$("#pausebutton").click(audioPause);
	$("#loadclickhandler").bind("click", loadClickHandler); //progress bar
});