package nl.hva.proveit.shoudio.controllers
{
    import com.modestmaps.Map;
    import com.modestmaps.events.MarkerEvent;
    import com.modestmaps.geo.Location;

    import flash.events.MouseEvent;
    import flash.geom.Point;

    import mx.core.IFlexDisplayObject;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.MapPanner;
    import nl.hva.proveit.shoudio.events.SidebarEvent;
    import nl.hva.proveit.shoudio.json.JsonLoaderEvent;
    import nl.hva.proveit.shoudio.models.ShoudioCollection;
    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;
    import nl.hva.proveit.shoudio.views.MapMarker;
    import nl.hva.proveit.shoudio.views.MapMarkerPopup;
    import nl.hva.proveit.shoudio.views.MapView;

    public final class MapController
    {
        private static const MAP_POPUP_MARGIN_TOP:Number = 80;
        private static const MAP_POPUP_MARGIN_LEFT:Number = 120;

        public var view:MapView;

        public var map:Map;

        private var _collection:ShoudioCollection;

        private var _activePopup:IFlexDisplayObject;

        private var _panner:MapPanner;

        public function init():void
        {
            view.addEventListener(JsonLoaderEvent.JSON_LOADED, jsonLoader_jsonLoadedHandler);

            map = view.mapComponent.map;

            _panner = new MapPanner(map);
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
            map.setCenterZoom(new Location(_collection.latitude, _collection.longtitude), 17);

            view.addEventListener(SidebarEvent.MAP_MARKER_CLICKED, sidebar_mapMarkerClickedHandler);

            map.addEventListener(MarkerEvent.MARKER_ROLL_OVER, map_markerRollOverHandler);
            map.addEventListener(MarkerEvent.MARKER_ROLL_OUT, map_markerRollOutHandler);
        }

        private function openMarkerPopup(markerLocation:Location, item:ShoudioCollectionItem):void
        {
            var clickedPoint:Point = map.locationPoint(markerLocation);
            var mapCenterPoint:Point = map.locationPoint(map.getCenter());

            map.panBy(mapCenterPoint.x - clickedPoint.x, mapCenterPoint.y - clickedPoint.y);
            map.panBy(MAP_POPUP_MARGIN_LEFT, MAP_POPUP_MARGIN_TOP);

            mapCenterPoint = map.locationPoint(map.getCenter());

            var popup:MapMarkerPopup = new MapMarkerPopup();
            popup.item = item;
            popup.x = view.parent.x + mapCenterPoint.x + MAP_POPUP_MARGIN_LEFT - popup.width;
            popup.y = view.parent.y + mapCenterPoint.y + MAP_POPUP_MARGIN_TOP - popup.height;

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

        private function map_markerRollOverHandler(e:MarkerEvent):void
        {
            var location:Location = e.location;
            var item:ShoudioCollectionItem = (e.marker as MapMarker).item;

            openMarkerPopup(location, item);
        }

        private function map_markerRollOutHandler(e:MarkerEvent):void
        {
//            if (_activePopup !== null)
//                PopUpManager.removePopUp(_activePopup);
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
    }
}
