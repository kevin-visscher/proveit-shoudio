// ActionScript file
package nl.hva.proveit.shoudio
{
    import com.modestmaps.TweenMap;
    import com.modestmaps.geo.Location;
    import com.modestmaps.mapproviders.OpenStreetMapProvider;

    import flash.display.Bitmap;

    import mx.core.IVisualElementContainer;
    import mx.core.UIComponent;

    public class ShoudioMap
	{
        [Embed(source="/../img/marker.png")]
        private static const MarkerImage:Class;

        private var _map:TweenMap;

        [Bindable]
        private var _latitude:Number;

        [Bindable]
        private var _longtitude:Number;

        [Bindable]
        private var _zoom:Number;

        public function ShoudioMap(latitude:Number, longtitude:Number, zoom:Number, mapContainer:UIComponent) {
            _latitude = latitude;
            _longtitude = longtitude;
            _zoom = zoom;

            _map = new TweenMap(
                    mapContainer.width,
                    mapContainer.height,
                    true,
                    new OpenStreetMapProvider()
            );

            _map.setCenterZoom(new Location(_latitude, _longtitude), _zoom);

            addMapToContainer(mapContainer);
        }

        public function addMarker(latitude:Number, longtitude:Number):void {
            var marker:ShoudioMapMarker = new ShoudioMapMarker();

            var markerImage:Bitmap = new MarkerImage() as Bitmap;
            markerImage.x = markerImage.width / 2;
            markerImage.y = markerImage.height / 2;

            marker.addChild(markerImage);
            marker.resortName = "blaat";
            marker.resortDesc = "blaat";

            _map.putMarker(new Location(latitude, longtitude), marker);
        }

		private function addMapToContainer(mapContainer:UIComponent):void {
            if (mapContainer is IVisualElementContainer) {
                var tmp:UIComponent = new UIComponent();
                tmp.addChild(_map);

			    IVisualElementContainer(mapContainer).addElement(tmp);
            } else {
                mapContainer.addChild(_map);
            }
		}
		
		public function centerZoom(lat:Number, lon:Number, zoom:Number):void {
			_map.setCenterZoom(new Location(lat, lon), zoom);
		}
	}
}