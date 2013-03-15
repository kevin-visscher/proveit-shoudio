package nl.hva.proveit.shoudio.controllers {

    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.media.Sound;
    import flash.net.URLRequest;

    import mx.controls.Alert;

    import nl.hva.proveit.shoudio.ShoudioMap;
    import nl.hva.proveit.shoudio.Shouldio;
    import nl.hva.proveit.shoudio.json.JsonLoader;
    import nl.hva.proveit.shoudio.json.JsonLoaderEvent;

    public class HomeController {

        public var view:Shouldio;

        private var _jsonLoader:JsonLoader;
        private var _map:ShoudioMap;

        public function creationCompleteHandler():void {
            _jsonLoader = new JsonLoader();
            _jsonLoader.addEventListener(JsonLoaderEvent.JSON_LOADED, jsonLoader_jsonLoadedHandler);

            _map = new ShoudioMap(52.357543, 4.869089, 14, view.mapGroup);
        }

        public function button1_clickHandler(e:MouseEvent):void {
            _jsonLoader.load("https://shoudio.com/api/v1/channel?oauth_token=f95134f71ed352a28ae872e7aa37e65f&channel=sxswnl");
        }

        private function jsonLoader_jsonLoadedHandler(e:JsonLoaderEvent):void {
            var data:Object = e.data;

            view.lbluname.text = "Username: " + data.shoudios[0].username;
            view.lbluid.text = "UserID: " + data.shoudios[0].id;
            view.lblcreated.text = "Shoudio item created @:" + data.shoudios[0].created_at;
            view.lblLong.text = "Lon: " + data.shoudios[0].lon;
            view.lblLat.text = "Lat: " + data.shoudios[0].lat;

            _map.centerZoom(data.shoudios[0].lat, data.shoudios[0].lon, 14);

            view.lblBeschrijving.text = "Description: " + data.shoudios[0].message;

            view.img1.source = data.shoudios[0].user.avatar;
            var sound:Sound = new Sound(new URLRequest(data.shoudios[0].audio.mp3));
            sound.addEventListener(Event.COMPLETE, function(e:Event):void {

                var s:Sound = e.target as Sound;
                s.play();

            });

            var s:String = "";
            for (var key:* in data)
                s += key + " = " + data[key];

            Alert.show(s);
        }
    }
}