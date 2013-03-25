function hiderightmenu() {
    $("#rightmenu").animate({'margin-left':'403px'},1000);
}

function showrightmenu() {
    $("#rightmenu").animate({'margin-left':'240px'},1000);
}

function addrightmenuItems(item){
    for(var i in item) {
        var message = item[i].message;
        var lat = item[i].lat;
        var lon = item[i].lon;
        var shoudiotype = item[i].type;
        
        if(message.length > 19) message = message.substr(0,19) + "...";
        
        $(".rightmenuitems").append('<li class="notselected" data-shouindex="'+i+'"><object id="icon" data="img/'+shoudiotype+'black.svg" type="image/svg+xml" width="18" height="18"></object>'+message+'</li>');
    }
}

function rightmenuClick(){
    if(this == oldthis) return;
    $(oldthis).toggleClass('selected');
    $(this).toggleClass('selected');
    
    
    var shouindex = $(this).data("shouindex");
    var lon = shoudioObjects[shouindex].lon;
    var lat = shoudioObjects[shouindex].lat;
    var description = shoudioObjects[shouindex].description;
    
    temp = $(this).html().replace('black', 'white');
    $(this).html(temp);
    if(oldthis) temp = $(oldthis).html().replace('white', 'black'); $(oldthis).html(temp);
    
    oldthis = this;
    var position = new OpenLayers.LonLat(lon,lat)
        .transform(fromProjection, toProjection);
    
    $("#popup").remove();
    
    position.lon-=120;
    position.lat+=180;
    
    popup = new OpenLayers.Popup("popup",
                   position,
                   new OpenLayers.Size(175,100),
                   description,
                   true);
    
    position = new OpenLayers.LonLat(lon,lat)
        .transform(fromProjection, toProjection);
    map.panTo(position);

    map.addPopup(popup);
    hiderightmenu();
}