package nl.hva.proveit.shoudio.controllers {

    import flash.events.MouseEvent;

    import nl.hva.proveit.shoudio.Main;
    import nl.hva.proveit.shoudio.ShoudioMap;
    import nl.hva.proveit.shoudio.json.JsonLoader;
    import nl.hva.proveit.shoudio.json.JsonLoaderEvent;
    import nl.hva.proveit.shoudio.models.ShoudioCollection;
    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;

    public class HomeController {

        public var view:Main;

        private var _jsonLoader:JsonLoader;
        private var _map:ShoudioMap;

        public function creationCompleteHandler():void {
            _jsonLoader = new JsonLoader();
            _jsonLoader.addEventListener(JsonLoaderEvent.JSON_LOADED, jsonLoader_jsonLoadedHandler);

            _map = new ShoudioMap(52.357543, 4.869089, 14, view.mapGroup);
        }

        public function button1_clickHandler(e:MouseEvent):void {
            _jsonLoader.load("https://dl.dropbox.com/s/v8biz6wnjlw267a/json-mooie-ding.json?token_hash=AAGTmA8inr1pIb4CIRY-4mKUZZhYm3XRMq4cDYho2XU0Vw&dl=1");
        }

        private function jsonLoader_jsonLoadedHandler(e:JsonLoaderEvent):void {
            var collection:ShoudioCollection = ShoudioCollection.fromObject(e.data);

            for each (var item:ShoudioCollectionItem in collection.items) {
                _map.addMarker(item.latitude, item.longtitude);
            }

            _map.centerZoom(collection.latitude, collection.longtitude, 20);
        }
    }
}