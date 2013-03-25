package nl.hva.proveit.shoudio.views
{
    import flash.display.Bitmap;
    import flash.display.Sprite;

    public class MapMarker extends Sprite
    {
        [Embed("/assets/marker.png")]
        private static const MARKER_IMAGE:Class;

        public function MapMarker()
        {
            addChild(new MARKER_IMAGE() as Bitmap);
        }
    }
}
