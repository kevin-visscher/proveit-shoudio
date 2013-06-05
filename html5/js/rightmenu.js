function hiderightmenu() {
    $("#rightmenu").animate({'margin-left':'403px'},1000);
}

function showrightmenu() {
    $("#rightmenu").animate({'margin-left':'240px'},1000);
}

function addrightmenuItem(item, featureid) {
    var message = item.message;
    var shoudiotype = item.type;
    
    $.get('img/'+shoudiotype+'.svg', function(data) {
        $(".rightmenuitems").append('<li class="notselected" data-shouindex="'+featureid+'"><div class="icon">'+
        data+'</div>'+message+'</li>');
    });
}

function rightmenuClick(){
    featureid = $(this).data("shouindex");    
    feature = shoudioObjectsPointer[featureid][1];
    onFeatureSelect(feature);
    selectedFeature = feature;
}