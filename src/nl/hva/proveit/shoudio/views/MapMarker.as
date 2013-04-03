package nl.hva.proveit.shoudio.views
{
    import flash.display.Bitmap;
    import flash.display.Sprite;

    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;

    public class MapMarker extends Sprite
    {
        [Embed("/assets/marker.png")]
        private static const MARKER_IMAGE:Class;

        private var _item:ShoudioCollectionItem;

        public function MapMarker(item:ShoudioCollectionItem)
        {
            _item = item;

            addChild(new MARKER_IMAGE() as Bitmap);
        }

        public function get item():ShoudioCollectionItem
        {
            return _item;
        }
    }
}
