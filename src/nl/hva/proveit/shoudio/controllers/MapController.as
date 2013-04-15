package nl.hva.proveit.shoudio.controllers
{
    import com.modestmaps.Map;
    import com.modestmaps.events.MarkerEvent;
    import com.modestmaps.geo.Location;

    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.net.URLRequest;
    import flash.system.Security;

    import mx.controls.Alert;
    import mx.core.IFlexDisplayObject;
    import mx.core.UIComponent;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.events.SidebarEvent;
    import nl.hva.proveit.shoudio.json.JsonLoaderEvent;
    import nl.hva.proveit.shoudio.models.ShoudioCollection;
    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;
    import nl.hva.proveit.shoudio.views.MapMarker;
    import nl.hva.proveit.shoudio.views.MapMarkerPopup;
    import nl.hva.proveit.shoudio.views.MapView;

    public final class MapController
    {
        private static const YOUTUBE_API_URL:String = "http://www.youtube.com/apiplayer?version=3";

        public var view:MapView;

        private var _collection:ShoudioCollection;

        public var map:Map;

        private var _activePopup:IFlexDisplayObject;

        private var loader:Loader = new Loader();

        public function init():void
        {
            view.addEventListener(JsonLoaderEvent.JSON_LOADED, jsonLoader_jsonLoadedHandler);

            map = view.mapComponent.map;

            // Allow YouTube to communicate with the SWF
            Security.allowDomain("www.youtube.com");

            var request:URLRequest = new URLRequest(YOUTUBE_API_URL);

            loader.contentLoaderInfo.addEventListener(Event.INIT, initYouTubePlayer, false, 0, true);
            loader.load(request);
        }

        private function initYouTubePlayer(e:Event):void
        {
            var loaderInfo:LoaderInfo = e.target as LoaderInfo;

            loaderInfo.content.addEventListener("onReady", youTubePlayer_readyHandler);
            loaderInfo.content.addEventListener("onError", youTubePlayer_errorHandler);

            var youTubePlayerContainer:UIComponent = new UIComponent();
            youTubePlayerContainer.addChild(loaderInfo.loader);

            view.addElement(youTubePlayerContainer);
        }

        private function youTubePlayer_readyHandler(e:Event):void
        {
            Alert.show("youtube player ready");

            (loader.content as Object).setSize(400, 400);
            (loader.content as Object).loadVideoById({videoId: "Xt7-FvK9TVs"});
        }

        private function youTubePlayer_errorHandler(e:Event):void
        {
            Alert.show("youtube player error");
        }

        private function jsonLoader_jsonLoadedHandler(e:JsonLoaderEvent):void
        {
            view.removeEventListener(JsonLoaderEvent.JSON_LOADED, jsonLoader_jsonLoadedHandler);

            _collection = ShoudioCollection.fromObject(e.data);

            for each (var item:ShoudioCollectionItem in _collection.items)
            {
                // Add a marker for each item in the collection
                map.putMarker(new Location(item.latitude, item.longtitude), new MapMarker(item));
            }

            // Initial location of the map are the long- and latitude of the collection
            map.setCenterZoom(new Location(_collection.latitude, _collection.longtitude), 15);

            view.addEventListener(SidebarEvent.MAP_MARKER_CLICKED, sidebar_mapMarkerClickedHandler);

            map.addEventListener(MarkerEvent.MARKER_CLICK, map_markerClickHandler);
        }

        private function sidebar_mapMarkerClickedHandler(e:SidebarEvent):void
        {
            var item:ShoudioCollectionItem = e.item;

            // Center the map on the item that was clicked
            map.setCenter(new Location(item.latitude, item.longtitude));
        }

        private function map_markerClickHandler(e:MarkerEvent):void
        {
            var location:Location = e.location;
            var clickedPoint:Point = map.locationPoint(location);
            var item:ShoudioCollectionItem = (e.marker as MapMarker).item;

            var popup:MapMarkerPopup = new MapMarkerPopup();
            popup.item = item;
            popup.x = view.x + clickedPoint.x;
            popup.y = view.y + clickedPoint.y;

            if (_activePopup !== null)
                PopUpManager.removePopUp(_activePopup);

            // TODO: Don't show popup if the it's of type audio/video
            PopUpManager.addPopUp(popup, view);

            _activePopup = popup;

            map.setCenter(location);
        }
    }
}
