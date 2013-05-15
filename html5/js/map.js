/*
* Function that projects a marker on the map for all shoudio
*  items, if the item is in a collection, 
*  the items that have a sorting value > -1
*
* @param item       Array of the collection with all 
*                   the items
* @param overlay    extra layer above the map to add 
*                   an marker (feature) to the overlay
*/
function addmapItems(item, overlay) {
    //add to map
    var b = -1;
    for(var i in item) {
        var message = item[i].message;
        var lon = item[i].lon;
        var lat = item[i].lat;
        
        // The location of our marker and popup. We usually think in geographic
        // coordinates ('EPSG:4326'), but the map is projected ('EPSG:3857').
        var myLocation = new OpenLayers.Geometry.Point(lon, lat)
            .transform(this.fromProjection, this.toProjection);
        
        var feature = new OpenLayers.Feature.Vector(myLocation, {tooltip: 'OpenLayers'});
        
        this.shoudioObjectsPointer[feature.id] = Array(2);
        this.shoudioObjectsPointer[feature.id][0] = item[i];
        this.shoudioObjectsPointer[feature.id][1] = feature;
        
        this.overlay.addFeatures([feature]);
        
        //if the shoudioitem is an collection item,
        if(item[i].sorting > -1) {
            
            //set b the first time we come accross an collection item,
            // so that we can start drawing lines for the collection items.
            if(b == -1) b = i;
            
            //add map item to right menu
            addrightmenuItem(item[i], feature.id);
            
            //draw the line
            var start_point;
            var end_point;
            
            if(i>b) {
                start_point = new OpenLayers.Geometry.Point(item[i-1].lon, item[i-1].lat);
                end_point = new OpenLayers.Geometry.Point(lon, lat);
            } if(i==item.length-1) {
                //this is the last object, so draw the last line
                // and draw the line back to start
                
                //draw line to to start
                start_point = new OpenLayers.Geometry.Point(lon, lat);
                end_point = new OpenLayers.Geometry.Point(item[b].lon, item[b].lat);
                this.overlay.addFeatures([new OpenLayers.Feature.Vector(new OpenLayers.Geometry.LineString([start_point, end_point])
                .transform(this.fromProjection, this.toProjection))]);
                
                //draw last line
                start_point = new OpenLayers.Geometry.Point(item[i-1].lon, item[i-1].lat);
                end_point = new OpenLayers.Geometry.Point(lon, lat);
            }
            overlay.addFeatures([new OpenLayers.Feature.Vector(new OpenLayers.Geometry.LineString([start_point, end_point])
                .transform(this.fromProjection, this.toProjection))]);
        }
    }
}

/*
* Function that creates the popup onclick
*/
function onFeatureSelect(feature) {
    hiderightmenu();
    
    if(selectedFeature) {
        map.removePopup(selectedFeature.popup);
        selectedFeature.popup.destroy();
        selectedFeature.popup = null;
    }
    
    selectedFeature = feature;
    
    var shoudioItem = shoudioObjectsPointer[feature.id][0];
    var description = shoudioItem.description;
    var shoudio_id = shoudioItem.shoudio_id;
    var type = shoudioItem.type;
    var collections_id = shoudioItem.collections_id;
    var sizing = "original";
    
    map.panTo(feature.geometry.getBounds().getCenterLonLat());
    
    var popupdata = shoudioItem.message + "<br /><br />";
    popupdata += "<a href='javascript:popupClick(\""+feature.id+"\");'>";
    
    switch(type) {
        case 'shoudio':
            popupdata += "Speel deze shoudio af</a>";
            break;
        case 'text':
            popupdata += "Text laten zien</a>";
            break;
        case 'poi':
        case 'image':
            popupdata += "Foto weergeven</a>";
            break;
        case 'youtube':
            popupdata += "Speel de video af</a>";
            break;
    }
    
    popup = new OpenLayers.Popup.FramedCloud("popup", feature.geometry.getBounds().getCenterLonLat(),
                             null,
                             popupdata,
                             null, false);
    var offset = {'size':new OpenLayers.Size(200,12),'offset':new OpenLayers.Pixel(0,-102)};
    popup.offset = offset;
    popup.relativePosition = "tr";

    feature.popup = popup;
    map.addPopup(popup);
}

function popupClick(featureid) {
    var shoudioItem = shoudioObjectsPointer[featureid][0];
    var type = shoudioItem.type;
    
    switch(type) {
        case 'shoudio':
            //show player
            break;
        case 'text':
            $(".placeholder").append("<div class='reader'><h3>"+shoudioItem.message+"</h3>"+shoudioItem.description+"</div>");
            $("#imagecontainer").fadeIn();
            break;
        case 'poi':
        case 'image':
            $(".placeholder").html('<img src="http://s3.amazonaws.com/noise.shoudio.com/jpg/original/'+shoudioItem.shoudio_id+'.jpg" />');
            $("#imagecontainer").fadeIn();
            break;
        case 'youtube':
            var youtubeiframe = '<iframe id="youtubeDivPlayer" width="400" height="300" frameborder="0"' +
                'src="http://www.youtube.com/embed/'+shoudioItem.external_link+
                '?autoplay=1&amp;modestbranding=1"></iframe>';
            
            $(".placeholder").html(youtubeiframe);
            $("#imagecontainer").fadeIn();
            break;
        default:
            alert(type + ' niet bekend');
    }
}

/* DEPRECATED
* Function that removes the popup
*  this function is called when a user clicks 
*  on another marker or somewhere the map
*/
function onFeatureUnselect(feature) {
    map.removePopup(feature.popup);
    feature.popup.destroy();
    feature.popup = null;
}   
