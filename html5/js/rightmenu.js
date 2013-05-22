function hiderightmenu() {
    $("#rightmenu").animate({'margin-left':'403px'},1000);
}

function showrightmenu() {
    $("#rightmenu").animate({'margin-left':'240px'},1000);
}

function addrightmenuItem(item, featureid) {
    var message = item.message;
    var shoudiotype = item.type;
    if(message.length > 19) message = message.substr(0,19) + "...";
    
    $(".rightmenuitems").append('<li class="notselected" data-shouindex="'+featureid+'"><object id="icon" data="img/'+shoudiotype+'black.svg" type="image/svg+xml" width="18" height="18"></object>'+message+'</li>');
}

function rightmenuClick(){
    
    if(this == oldthis) return;
    
    $(oldthis).toggleClass('selected');
    $(this).toggleClass('selected');
    
    if(oldthis) {
        //make icon old selected black
        var featureid = $(oldthis).data("shouindex");
        var feature = shoudioObjectsPointer[featureid][1];
        var item = shoudioObjectsPointer[featureid][0];
        
        var message = item.message;
        var shoudiotype = item.type;
        if(message.length > 19) message = message.substr(0,19) + "...";
        $(oldthis).html('<object id="icon" data="img/'+shoudiotype+'black.svg" type="image/svg+xml" width="18" height="18"></object>'+message+'</li>');
    }
    
    //make icon white
    featureid = $(this).data("shouindex");
    feature = shoudioObjectsPointer[featureid][1];
    item = shoudioObjectsPointer[featureid][0];
    
    message = item.message;
    shoudiotype = item.type;
    if(message.length > 19) message = message.substr(0,19) + "...";
    $(this).html('<object id="icon" data="img/'+shoudiotype+'white.svg" type="image/svg+xml" width="18" height="18"></object>'+message+'</li>');
    
    oldthis = this;
    
    onFeatureSelect(feature);
    selectedFeature = feature;
}