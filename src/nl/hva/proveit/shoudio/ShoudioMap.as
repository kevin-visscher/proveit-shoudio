// ActionScript file
package nl.hva.proveit.shoudio
{
    import com.modestmaps.TweenMap;
    import com.modestmaps.geo.Location;
    import com.modestmaps.mapproviders.OpenStreetMapProvider;

    import flash.display.Bitmap;

    import mx.containers.Canvas;
    import mx.core.UIComponent;

    public class ShoudioMap
	{
		[Bindable]private var _map:TweenMap; 
		private  var _mapUI:UIComponent;
		private var resortMarker:PointMarker;
		private var _mappanel:Canvas;
		[Bindable]private var _initialLat:Number;
		[Bindable]private var _initialLong:Number;
		[Bindable]private var _initialZoom:Number;
		
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
		protected var MarkerImage:Class;
		
		private function addMarkers():void
		{
			for each (var resort:XML in srcXML.location){
				resortMarker = new PointMarker();
				var markerImage:Bitmap = new MarkerImage() as Bitmap;
				markerImage.x = -markerImage.width/2
				markerImage.y = -markerImage.height/2
				resortMarker.addChild(markerImage);
				resortMarker.resortName = resort.name;
				resortMarker.resortDesc = resort.description;
				_map.putMarker(new Location(resort.lat, resort.long), resortMarker); 
			} 
		}
		
		public function ShoudioMap(lat:Number, lon:Number, zoom:Number, mappanel:Canvas) {
			_initialLat = lat;
			_initialLong = lon;
			_initialZoom = zoom;
			_mappanel = mappanel;
			
			_map = new TweenMap(_mappanel.width, _mappanel.height, true, new OpenStreetMapProvider());   
			_map.setCenterZoom(new Location(_initialLat, _initialLong), _initialZoom); 
			mapCore();
		}
		
		private function mapCore():void
		{
			_mapUI = new UIComponent();
			_mapUI.addChild(_map);  
			_mappanel.addChild(_mapUI);
			addMarkers();
		}
		
		public function centerZoom(lat:Number, lon:Number, zoom:Number):void {
			_map.setCenterZoom(new Location(lat, lon), zoom);
		}
	}
}