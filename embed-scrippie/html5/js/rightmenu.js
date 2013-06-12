function hiderightmenu() {
    $("#rightmenu").animate({'margin-left':'403px'},350);
}

function showrightmenu() {
    $("#rightmenu").animate({'margin-left':'240px'},350);
}

function addrightmenuItem(item, featureid) {
    var message = item.message;
    var shoudiotype = item.type;

    $.get('img/'+shoudiotype+'.svg', function(data) {
        $('<li/>', { class: 'notselected', 'data-shouindex': featureid  }).append($('<div/>', { class: 'icon' }).append(data.documentElement)).append(message).appendTo($('.rightmenuitems'));
    });
}

function rightmenuClick(){
    featureid = $(this).data("shouindex");    
    feature = shoudioObjectsPointer[featureid][1];
    onFeatureSelect(feature);
    selectedFeature = feature;
}
