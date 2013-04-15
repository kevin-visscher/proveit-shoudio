package nl.hva.proveit.shoudio.events
{
    import flash.events.Event;

    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;

    public class SidebarEvent extends Event
    {
        public static const MAP_MARKER_CLICKED:String = "mapMarkerClicked";

        private var _item:ShoudioCollectionItem;

        public function SidebarEvent(type:String, item:ShoudioCollectionItem)
        {
            super(type);

            _item = item;
        }

        public function get item():ShoudioCollectionItem
        {
            return _item;
        }
    }
}
