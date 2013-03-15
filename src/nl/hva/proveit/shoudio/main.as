import flash.events.MouseEvent;

import mx.controls.Alert;

import nl.hva.proveit.shoudio.ShoudioMap;
import nl.hva.proveit.shoudio.json.JsonLoader;
import nl.hva.proveit.shoudio.json.JsonLoaderEvent;

//declaratie van privates
private var jsonLoader:JsonLoader = new JsonLoader();

private  var _map:ShoudioMap;

private function init():void {
	_map = new ShoudioMap(52.357543, 4.869089, 14, mappanel);
}

protected function button1_clickHandler(event:MouseEvent):void {
    jsonLoader.addEventListener(JsonLoaderEvent.JSON_LOADED, shoudiodata_jsonLoaded);
    jsonLoader.load("https://shoudio.com/api/v1/channel?oauth_token=f95134f71ed352a28ae872e7aa37e65f&channel=sxswnl");
}

private function shoudiodata_jsonLoaded(e:JsonLoaderEvent):void {
    var data:Object = e.data;

    lbluname.text = "Username: " + data.shoudios[0].username;
    lbluid.text = "UserID: " + data.shoudios[0].id;
    lblcreated.text = "Shoudio item created @:" + data.shoudios[0].created_at;
    lblLong.text = "Lon: " + data.shoudios[0].lon;
    lblLat.text = "Lat: " + data.shoudios[0].lat;

    _map.centerZoom(data.shoudios[0].lat, data.shoudios[0].lon, 14);

    lblBeschrijving.text = "Description: " + data.shoudios[0].message;

    img1.source = data.shoudios[0].user.avatar;
    vp1.source = data.shoudios[0].audio.mp3;

    var s:String = "";
    for (var key:* in data)
        s += key + " = " + data[key];

    Alert.show(s);
}