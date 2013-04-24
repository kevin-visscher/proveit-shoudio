function addmapItems(item, overlay) {
    //add to map
    for(var i in item) {
        var message = item[i].message;
        var lon = item[i].lon;
        var lat = item[i].lat;
        
        // The location of our marker and popup. We usually think in geographic
        // coordinates ('EPSG:4326'), but the map is projected ('EPSG:3857').
        var myLocation = new OpenLayers.Geometry.Point(lon, lat)
            .transform(this.fromProjection, this.toProjection);
        
        this.overlay.addFeatures([
            new OpenLayers.Feature.Vector(myLocation, {tooltip: 'OpenLayers'})
        ]);
        
        //draw the line
        var start_point;
        var end_point;
        
        if(i>0) {
            start_point = new OpenLayers.Geometry.Point(item[i-1].lon, item[i-1].lat);
            end_point = new OpenLayers.Geometry.Point(lon, lat);
        } if(i==item.length-1) {
            //last object so draw the last line and draw the line back to start
            
            //draw line to to start
            start_point = new OpenLayers.Geometry.Point(lon, lat);
            end_point = new OpenLayers.Geometry.Point(item[0].lon, item[0].lat);
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

function addmapPoi(item, overlay) {
    for(var i in item) {
        var message = item[i].message;
        var lon = item[i].lon;
        var lat = item[i].lat;
        
        // The location of our marker and popup. We usually think in geographic
        // coordinates ('EPSG:4326'), but the map is projected ('EPSG:3857').
        var myLocation = new OpenLayers.Geometry.Point(lon, lat)
            .transform(fromProjection, toProjection);
        
        this.overlay.addFeatures([
            new OpenLayers.Feature.Vector(myLocation, {tooltip: 'OpenLayers'})
        ]);
    }
}

/*
* Function that creates the popup onclick
*/
function onFeatureSelect(feature) {
    hiderightmenu();
    selectedFeature = feature;
    popup = new OpenLayers.Popup.FramedCloud("tempId", feature.geometry.getBounds().getCenterLonLat(),
                             null,
                             selectedFeature.attributes.salutation + " from Lat:" + selectedFeature.attributes.Lat + " Lon:" + selectedFeature.attributes.Lon,
                             null, true);
    feature.popup = popup;
    map.addPopup(popup);
}

/*
* Function that removes the popup
*  this function is called when a user clicks 
*  on another marker or somewhere the map
*/
function onFeatureUnselect(feature) {
    map.removePopup(feature.popup);
    feature.popup.destroy();
    feature.popup = null;
}   
