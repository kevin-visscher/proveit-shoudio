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
        private var _map:TweenMap;

        private var resortMarker:PointMarker;

        private var _mapContainer:UIComponent;

        [Bindable]
        private var _initialLat:Number;

        [Bindable]
        private var _initialLong:Number;

        [Bindable]
        private var _initialZoom:Number;
		
		private var srcXML:XML = 
		<root>
		<location>
		<name>Alta Ski Resort</name>
		<lat>52.0021890000</lat>
		<long>6.5992640000</long>
		<description>Home of the Greatest Snow on Earth</description>
		</location> 
		<location>
		<name>Crested Butte Resort</name>
		<lat>52.0021890100</lat>
		<long>6.5992640100</long>
		<description>Amazing skiing with small town charm</description>
		</location>
		</root>;
		
		[Embed(source="/../img/marker.png")]
		private static const MarkerImage:Class;

        public function ShoudioMap(lat:Number, lon:Number, zoom:Number, mapContainer:UIComponent) {
            _initialLat = lat;
            _initialLong = lon;
            _initialZoom = zoom;
            _mapContainer = mapContainer;

            _map = new TweenMap(
                    _mapContainer.width,
                    _mapContainer.height,
                    true,
                    new OpenStreetMapProvider()
            );

            _map.setCenterZoom(new Location(_initialLat, _initialLong), _initialZoom);

            mapCore();
        }

		private function addMarkers():void
		{
			for each (var resort:XML in srcXML.location){
				resortMarker = new PointMarker();

                var markerImage:Bitmap = new MarkerImage() as Bitmap;
				markerImage.x = -markerImage.width / 2;
				markerImage.y = -markerImage.height / 2;

				resortMarker.addChild(markerImage);
				resortMarker.resortName = resort.name;
				resortMarker.resortDesc = resort.description;

                _map.putMarker(new Location(resort.lat, resort.long), resortMarker);
			} 
		}
		
		private function mapCore():void {
            if (_mapContainer is IVisualElementContainer) {
                var tmp:UIComponent = new UIComponent();
                tmp.addChild(_map);

			    IVisualElementContainer(_mapContainer).addElement(tmp);
            } else {
                _mapContainer.addChild(_map);
            }

            addMarkers();
		}
		
		public function centerZoom(lat:Number, lon:Number, zoom:Number):void {
			_map.setCenterZoom(new Location(lat, lon), zoom);
		}
	}
}