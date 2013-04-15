package nl.hva.proveit.shoudio.controllers
{

    import com.modestmaps.Map;
    import com.modestmaps.events.MarkerEvent;
    import com.modestmaps.geo.Location;

    import flash.events.MouseEvent;
    import flash.geom.Point;

    import mx.collections.ArrayList;
    import mx.collections.IList;
    import mx.core.FlexGlobals;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.Main;
    import nl.hva.proveit.shoudio.json.JsonLoader;
    import nl.hva.proveit.shoudio.json.JsonLoaderEvent;
    import nl.hva.proveit.shoudio.models.ShoudioCollection;
    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;
    import nl.hva.proveit.shoudio.views.MapMarker;
    import nl.hva.proveit.shoudio.views.MapMarkerPopup;

    import spark.events.IndexChangeEvent;

    public class MainController
    {
        public var view:Main;

        private var _jsonLoader:JsonLoader;
        private var _map:Map;

        private var _activePopup:MapMarkerPopup;

        public function creationCompleteHandler():void
        {
            _jsonLoader = new JsonLoader();
            _jsonLoader.addEventListener(JsonLoaderEvent.JSON_LOADED, jsonLoader_jsonLoadedHandler);

            _map = view.map.map;
            _map.addEventListener(MarkerEvent.MARKER_CLICK, map_markerClickedHandler);

            _jsonLoader.load(FlexGlobals.topLevelApplication.parameters.uri);

            view.sidebar.listPoints.addEventListener(IndexChangeEvent.CHANGING, listPoints_indexChangingEvent);
        }

        private function map_markerClickedHandler(e:MarkerEvent):void
        {
            // TODO: Position the popup on the appropriate location

            var p:Point = _map.locationPoint(e.location);

            var popup:MapMarkerPopup = new MapMarkerPopup();
            popup.item = (e.marker as MapMarker).item;
            popup.width = 128;
            popup.height = 128;
            popup.x = view.mapContainer.x + p.x;
            popup.y = view.mapContainer.y + p.y;

            if (_activePopup !== null)
                PopUpManager.removePopUp(_activePopup);

            PopUpManager.addPopUp(popup, view);

            _activePopup = popup;
        }

        private function map_clickHandler(e:MouseEvent):void
        {
            if (!(e.target is MapMarker))
                return;

            if (_activePopup !== null)
                PopUpManager.removePopUp(_activePopup);
        }

        private function listPoints_indexChangingEvent(e:IndexChangeEvent):void
        {
            // Don't select an item
            e.preventDefault();

            // and stop bubbling immediately
            e.stopImmediatePropagation();

            var list:IList = view.sidebar.listPoints.dataProvider;
            var selectedItem:Object = list.getItemAt(e.newIndex);

            // Center the map around the selected point
            _map.setCenter(new Location(selectedItem.latitude, selectedItem.longtitude));

            // "Close" the sidebar
            view.currentState = "sidebarHidden";
        }

        private function jsonLoader_jsonLoadedHandler(e:JsonLoaderEvent):void
        {
            var collection:ShoudioCollection = ShoudioCollection.fromObject(e.data);
            var sidebarItems:Array = [ ];

            for each (var item:ShoudioCollectionItem in collection.items)
            {
                // Add a marker for each item in the collection
                _map.putMarker(new Location(item.latitude, item.longtitude), new MapMarker(item));

                // Only put items that are part of the actual route
                // in to the sidebar. The points of interest are shown on the map
                if (item.sorting !== -1)
                {
                    sidebarItems.push(item);
                }
            }

            // Update the dataprovider of the sidebar
            view.sidebar.listPoints.dataProvider = new ArrayList(sidebarItems);

            // Initial location of the map are the long- and latitude of the collection
            _map.setCenterZoom(new Location(collection.latitude, collection.longtitude), 15);
        }
    }
}