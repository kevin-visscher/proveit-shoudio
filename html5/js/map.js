function addmapItems(item, overlay) {
    //add to map
    for(var i in item) {
        var message = item[i].message;
        var lon = item[i].lon;
        var lat = item[i].lat;
        
        // The location of our marker and popup. We usually think in geographic
        // coordinates ('EPSG:4326'), but the map is projected ('EPSG:3857').
        var myLocation = new OpenLayers.Geometry.Point(lon, lat)
            .transform(fromProjection, toProjection);
        
        overlay.addFeatures([
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
            overlay.addFeatures([new OpenLayers.Feature.Vector(new OpenLayers.Geometry.LineString([start_point, end_point])
            .transform(fromProjection, toProjection))]);
            
            //draw last line
            start_point = new OpenLayers.Geometry.Point(item[i-1].lon, item[i-1].lat);
            end_point = new OpenLayers.Geometry.Point(lon, lat);
        }
        overlay.addFeatures([new OpenLayers.Feature.Vector(new OpenLayers.Geometry.LineString([start_point, end_point])
            .transform(fromProjection, toProjection))]);
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
        
        overlay.addFeatures([
            new OpenLayers.Feature.Vector(myLocation, {tooltip: 'OpenLayers'})
        ]);
    }
}

function addMarker(item) {
    
    if (this.markers == null) {
        this.markers = new OpenLayers.Layer.Markers("Markers");
        map.addLayer(markers);
    }

    var i = 0;
    for(var i in item) {
        var currentLL = new OpenLayers.LonLat(item[i].lon, item[i].lat).transform(fromProjection, toProjection);
        this.marker.push(new OpenLayers.Marker(currentLL, icon));
    
        marker[i].events.register("click",marker[i],function() {markerClick(currentLL, item[i].description)});
        this.markers.addMarker(marker[i]);
        console.log(marker[i]);
    }
}

function markerClick(lonlat,description) {
    alert(1);
    if (popup) map.removePopup(popup);
    popup = new OpenLayers.Popup.FramedCloud("test", lonlat, null,
                description,
                anchor = null, true, null);
    map.addPopup(popup);
}