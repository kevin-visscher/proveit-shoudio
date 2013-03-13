import flash.events.MouseEvent;

import nl.hva.proveit.shoudio.ShoudioMap;
import nl.hva.proveit.shoudio.PointMarker;
import nl.hva.proveit.shoudio.jsonLoader;

//declaratie van privates
private var shoudiodata:jsonLoader = new jsonLoader("https://shoudio.com/api/v1/channel?oauth_token=f95134f71ed352a28ae872e7aa37e65f&channel=sxswnl");
private  var _map:ShoudioMap;

private function init():void {
	_map = new ShoudioMap(52.357543, 4.869089, 14, mappanel);
}

protected function button1_clickHandler(event:MouseEvent):void
{
	// TODO Auto-generated method stub	
	lbluname.text = "Username: " + shoudiodata.data.shoudios[0].username;
	lbluid.text = "UserID: " + shoudiodata.data.shoudios[0].id;
	lblcreated.text = "Shoudio item created @:" + shoudiodata.data.shoudios[0].created_at;
	lblLong.text = "Lon: " + shoudiodata.data.shoudios[0].lon;
	lblLat.text = "Lat: " + shoudiodata.data.shoudios[0].lat;
	
	_map.centerZoom(shoudiodata.data.shoudios[0].lat, shoudiodata.data.shoudios[0].lon, 14);
	
	lblBeschrijving.text = "Description: " + shoudiodata.data.shoudios[0].message;
	
	img1.source = shoudiodata.data.shoudios[0].user.avatar;
	vp1.source = shoudiodata.data.shoudios[0].audio.mp3;
}