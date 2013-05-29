package nl.hva.proveit.shoudio.controllers
{
    import com.modestmaps.TweenMap;
    import com.modestmaps.events.MapEvent;
    import com.modestmaps.events.MarkerEvent;
    import com.modestmaps.geo.Location;
    import com.modestmaps.mapproviders.OpenStreetMapProvider;
    import com.modestmaps.overlays.MarkerClip;
    import com.modestmaps.overlays.Polyline;
    import com.modestmaps.overlays.PolylineClip;

    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import mx.core.FlexGlobals;
    import mx.core.IFlexDisplayObject;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.events.SidebarEvent;
    import nl.hva.proveit.shoudio.json.JsonLoaderEvent;
    import nl.hva.proveit.shoudio.models.ShoudioCollection;
    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;
    import nl.hva.proveit.shoudio.views.MapMarker;
    import nl.hva.proveit.shoudio.views.MapMarkerPopup;
    import nl.hva.proveit.shoudio.views.MapView;

    import spark.core.SpriteVisualElement;

    public final class MapController
    {
        private static const MAP_POPUP_MARGIN_TOP:Number = 80;
        private static const MAP_POPUP_MARGIN_LEFT:Number = 120;

        public var view:MapView;

        private var _map:TweenMap;

        private var _collection:ShoudioCollection;

        private var _activePopup:IFlexDisplayObject;

        private var _shouldIgnoreNextPanEvent:Boolean;

        public function init():void
        {
            _map = new TweenMap(view.width, view.height, true, new OpenStreetMapProvider());

            var wrapper:SpriteVisualElement = new SpriteVisualElement();
            wrapper.width = view.width;
            wrapper.height = view.height;

            wrapper.addChild(_map);

            view.mapComponent.addElement(wrapper);

            var logoUrl:String = FlexGlobals.topLevelApplication.parameters.logo || "http://shoudio.com/img/nd_shoudio_logo.png";

            view.imgLogo.source = logoUrl;

            view.addEventListener(JsonLoaderEvent.JSON_LOADED, jsonLoader_jsonLoadedHandler);
        }

        private function jsonLoader_jsonLoadedHandler(e:JsonLoaderEvent):void
        {
            view.removeEventListener(JsonLoaderEvent.JSON_LOADED, jsonLoader_jsonLoadedHandler);

            _collection = ShoudioCollection.fromObject(e.data);

            var polyLineClip:PolylineClip = new PolylineClip(_map);
            var markerClip:MarkerClip = new MarkerClip(_map);

            var line:Polyline = new Polyline(
                    "collection-route-line",
                    [ ],
                    4, 0xff5100,.6, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND
            );

            // Create all of the lines that belong to the route of the collection
            for (var i:int = 0; i < _collection.route.length; i++)
            {
                var latAndLong:Array = _collection.route[i].split(",");

                line.locationsArray.push(new Location(latAndLong[0], latAndLong[1]));
            }

            // Create all of the markers
            for each (var item:ShoudioCollectionItem in _collection.items)
            {
                markerClip.attachMarker(new MapMarker(item), new Location(item.latitude, item.longtitude));
            }

            polyLineClip.addPolyline(line);

            _map.addChild(polyLineClip);
            _map.addChild(markerClip);

            // Initial location of the map are the long- and latitude of the collection
            _map.setCenterZoom(new Location(_collection.latitude, _collection.longtitude), 17);

            view.addEventListener(SidebarEvent.MAP_MARKER_CLICKED, sidebar_mapMarkerClickedHandler);

            _map.addEventListener(MarkerEvent.MARKER_CLICK, map_markerClickedHandler);

            _map.addEventListener(MapEvent.STOP_PANNING, map_stopPanningHandler);
        }

        private function map_stopPanningHandler(e:MapEvent):void
        {
            if (_shouldIgnoreNextPanEvent)
            {
                _shouldIgnoreNextPanEvent = false;
                return;
            }

            closeActivePopup();
        }

        private function openMarkerPopup(markerLocation:Location, item:ShoudioCollectionItem):void
        {
            var markerLocationPoint:Point = _map.locationPoint(markerLocation, view);

            var popup:MapMarkerPopup = new MapMarkerPopup();
            popup.item = item;
            popup.x = view.parent.x + view.parent.width / 2 - popup.width / 2;
            popup.y = view.parent.y + view.parent.width / 2 - popup.height / 2 - 32;

            markerLocationPoint.x -= popup.width / 2;
            markerLocationPoint.y -= popup.height / 2;

            _shouldIgnoreNextPanEvent = true;

            _map.panTo(_map.pointLocation(markerLocationPoint), true);

            closeActivePopup();

            _activePopup = popup;
            _activePopup.addEventListener(MouseEvent.ROLL_OUT, activePopup_rollOutHandler, false, 0, true);

            PopUpManager.addPopUp(popup, view);
        }

        private function closeActivePopup():void
        {
            if (_activePopup !== null)
                PopUpManager.removePopUp(_activePopup);
        }

        private function map_markerClickedHandler(e:MarkerEvent):void
        {
            var location:Location = e.location;
            var item:ShoudioCollectionItem = (e.marker as MapMarker).item;

            openMarkerPopup(location, item);
        }

        private function activePopup_rollOutHandler(e:MouseEvent):void
        {
            PopUpManager.removePopUp(e.target as IFlexDisplayObject);
        }

        private function sidebar_mapMarkerClickedHandler(e:SidebarEvent):void
        {
            var item:ShoudioCollectionItem = e.item;

            openMarkerPopup(new Location(item.latitude, item.longtitude), item);
        }

        public function notifySidebarVisible():void
        {
            closeActivePopup();
        }
    }
}
