package nl.hva.proveit.shoudio.views
{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.filters.DropShadowFilter;

    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;
    import nl.hva.proveit.shoudio.models.ShoudioItemType;

    public class MapMarker extends Sprite
    {
        [Embed("/assets/book.png")]
        private static const ICON_BOOK:Class;

        [Embed("/assets/music.png")]
        private static const ICON_MUSIC:Class;

        [Embed("/assets/picture.png")]
        private static const ICON_PICTURE:Class;

        [Embed("/assets/video.png")]
        private static const ICON_VIDEO:Class;

        [Embed("/assets/map-marker.png")]
        private static const ICON_POI:Class;

        private var _item:ShoudioCollectionItem;

        public function MapMarker(item:ShoudioCollectionItem)
        {
            _item = item;

            var radius:Number = 12;
            var width:Number = radius * 2;

            graphics.beginFill(0xFFFFFF);
            graphics.drawCircle(0, -20, radius);
            graphics.endFill();

            graphics.beginFill(0xFFFFFF);
            graphics.moveTo(-radius + 1, -14);
            graphics.lineTo(1, 6);
            graphics.lineTo(radius - 1, -14);
            graphics.lineTo(1, -14);
            graphics.endFill();

            filters = [ new DropShadowFilter(1, 90, 0x000000,.4) ];

            var icon:Bitmap = new ICON_POI();

            switch (item.type)
            {
                case ShoudioItemType.IMAGE:
                    icon = new ICON_PICTURE();
                    break;

                case ShoudioItemType.TEXT:
                    icon = new ICON_BOOK();
                    break;

                case ShoudioItemType.VIDEO:
                    icon = new ICON_VIDEO();
                    break;

                case ShoudioItemType.SHOUDIO:
                    icon = new ICON_MUSIC();
                    break;
            }

            icon.x = -8
            icon.y = -width - 3;

            addChild(icon);
        }

        public function get item():ShoudioCollectionItem
        {
            return _item;
        }
    }
}
