package nl.hva.proveit.shoudio.controllers
{

    import mx.collections.ArrayList;
    import mx.collections.IList;
    import mx.core.FlexGlobals;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.Main;
    import nl.hva.proveit.shoudio.events.SidebarEvent;
    import nl.hva.proveit.shoudio.json.JsonLoader;
    import nl.hva.proveit.shoudio.json.JsonLoaderEvent;
    import nl.hva.proveit.shoudio.models.ShoudioCollection;
    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;
    import nl.hva.proveit.shoudio.views.StartView;

    import spark.events.IndexChangeEvent;

    public class MainController
    {
        public var view:Main;

        private var _jsonLoader:JsonLoader;

        public function creationCompleteHandler():void
        {
            _jsonLoader = new JsonLoader();
            _jsonLoader.addEventListener(JsonLoaderEvent.JSON_LOADED, jsonLoader_jsonLoadedHandler);
            _jsonLoader.load(FlexGlobals.topLevelApplication.parameters.uri || "https://dl.dropbox.com/s/v8biz6wnjlw267a/json-mooie-ding.json?token_hash=AAGTmA8inr1pIb4CIRY-4mKUZZhYm3XRMq4cDYho2XU0Vw&dl=1");
        }

        private function listPoints_indexChangingEvent(e:IndexChangeEvent):void
        {
            // Don't select an item
            e.preventDefault();

            // and stop bubbling immediately
            e.stopImmediatePropagation();

            var list:IList = view.sidebar.listPoints.dataProvider;
            var selectedItem:Object = list.getItemAt(e.newIndex);

            // Notify the map view that a marker was clicked in the sidebar
            view.mapView.dispatchEvent(new SidebarEvent(SidebarEvent.MAP_MARKER_CLICKED, selectedItem as ShoudioCollectionItem));

            // "Close" the sidebar
            view.currentState = "sidebarHidden";
        }

        private function jsonLoader_jsonLoadedHandler(e:JsonLoaderEvent):void
        {
            _jsonLoader.removeEventListener(JsonLoaderEvent.JSON_LOADED, jsonLoader_jsonLoadedHandler);

            var collection:ShoudioCollection = ShoudioCollection.fromObject(e.data);
            var sidebarItems:Array = [ ];

            for each (var item:ShoudioCollectionItem in collection.items)
            {
                if (item.sorting >= 0)
                {
                    sidebarItems.push(item);
                }
            }

            var startView:StartView = new StartView();
            startView.width = 400;
            startView.height = 400;
            startView.x = (view.width - startView.width) / 2;
            startView.y = (view.height - startView.height) / 2;
            startView.collection = collection;

            // Show the start screen
            PopUpManager.addPopUp(startView, view, true);

            // Update the list in the sidebar
            view.sidebar.listPoints.dataProvider = new ArrayList(sidebarItems);

            // Notify the map view that the json has loaded and that it can begin showing the
            // markers on the map etc.
            view.mapView.dispatchEvent(e);

            // Add a listener to the list in the sidebar to be able to center on the clicked item
            view.sidebar.listPoints.addEventListener(IndexChangeEvent.CHANGING, listPoints_indexChangingEvent);

            view.currentState = "sidebarHidden";
        }
    }
}