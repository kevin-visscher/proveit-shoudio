function hiderightmenu() {
    $("#rightmenu").animate({'margin-left':'403px'},1000);
}

function showrightmenu() {
    $("#rightmenu").animate({'margin-left':'240px'},1000);
}

function addrightmenuItems(item){
    for(var i in item) {
        if(item[i].sorting < 0) continue;
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
    var shoudio_id = shoudioObjects[shouindex].shoudio_id;
    var type = shoudioObjects[shouindex].type;
    var collections_id = shoudioObjects[shouindex].collections_id;
    var sizing = "100x100";
    
    temp = $(this).html().replace('black', 'white');
    $(this).html(temp);
    if(oldthis) temp = $(oldthis).html().replace('white', 'black'); $(oldthis).html(temp);
    
    oldthis = this;
    var position = new OpenLayers.LonLat(lon,lat)
        .transform(fromProjection, toProjection);
    
    $("#popup").remove();
    
    position.lon-=120;
    position.lat+=180;
    
    switch(type) {
        case 'shoudio':
            var popupdata=description + '<br /><div id="jquery_jplayer_1" class="jp-jplayer"></div>' +
                '<div id="jp_container_1" class="jp-audio">' +
                        '<div class="jp-type-single">' +
                    '<div class="jp-gui jp-interface">' +
                '<ul class="jp-controls">' +
                                    '<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>' +
                                    '<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>' +
                                    '<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>' +
                                    '<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>' +
                                    '<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>' +
                                '</ul>' +
                            '</div>' +
                        '</div>' +
                    '</div>';
            break;
        case 'image':
            var popupdata = '<img src="http://s3.amazonaws.com/noise.shoudio.com/collections/'+sizing+'/collection_'+collections_id+'.jpg" />';
            break;
        case 'poi':
            var popupdata = '<img src="http://s3.amazonaws.com/noise.shoudio.com/jpg/'+sizing+'/'+shoudio_id+'.jpg" />';
            break;
        default:
            var popupdata = description;
    }
    
    popup = new OpenLayers.Popup("popup",
                   position,
                   new OpenLayers.Size(175,100),
                   popupdata,
                   true);

    position = new OpenLayers.LonLat(lon,lat)
        .transform(fromProjection, toProjection);
    map.panTo(position);

    map.addPopup(popup);
    
    if(type=="shoudio") 
        $("#jquery_jplayer_1").jPlayer({
            ready: function (event) {
                $(this).jPlayer("setMedia", {
                    mp3:"http://s3.amazonaws.com/noise.shoudio.com/mp3/shoudio_" + shoudio_id + ".mp3",
                });
            },
            swfPath: "js",
            supplied: "mp3",
            wmode: "window"
        });
    
    hiderightmenu();
}