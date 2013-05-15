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
    
    var featureid = $(this).data("shouindex");
    var feature = shoudioObjectsPointer[featureid][1];
    oldthis = this;
    
    onFeatureSelect(feature);
    selectedFeature = feature;
}