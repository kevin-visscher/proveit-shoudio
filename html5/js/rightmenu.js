function hiderightmenu() {
    $("#rightmenu").animate({'margin-left':'403px'},1000);
}

function showrightmenu() {
    $("#rightmenu").animate({'margin-left':'240px'},1000);
}

function addrightmenuItem(item, featureid) {
    var message = item.message;
    var shoudiotype = item.type;
    
    $(".rightmenuitems").append('<li class="notselected" data-shouindex="'+featureid+'"><object id="icon" data="img/'+shoudiotype+'black.svg" type="image/svg+xml" width="18" height="18"></object>'+message+'</li>');
}

function rightmenuHover(){ 
    //make icon white
    featureid = $(this).data("shouindex");
    feature = shoudioObjectsPointer[featureid][1];
    item = shoudioObjectsPointer[featureid][0];
    
    message = item.message;
    shoudiotype = item.type;
    $(this).html('<object id="icon" data="img/'+shoudiotype+'white.svg" type="image/svg+xml" width="18" height="18"></object>'+message+'</li>');
}

function rightmenuLeave() {
    //make icon old selected black
    var featureid = $(this).data("shouindex");
    var feature = shoudioObjectsPointer[featureid][1];
    var item = shoudioObjectsPointer[featureid][0];
    
    var message = item.message;
    var shoudiotype = item.type;
    $(this).html('<object id="icon" data="img/'+shoudiotype+'black.svg" type="image/svg+xml" width="18" height="18"></object>'+message+'</li>');
}

function rightmenuClick(){
    featureid = $(this).data("shouindex");    
    feature = shoudioObjectsPointer[featureid][1];
    onFeatureSelect(feature);
    selectedFeature = feature;
}