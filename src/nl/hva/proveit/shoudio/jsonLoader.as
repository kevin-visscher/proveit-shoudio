// ActionScript file
package nl.hva.proveit.shoudio {
	
	import flash.events.*;
	import flash.net.*;
	
	public class jsonLoader {
		
		public var loader:URLLoader = new URLLoader();
		private var _data:Object = null;
		private var _url:String = null;
		
		public function jsonLoader(val:String) {
			//loader set-up
			_url = val;
			
			var request:URLRequest = new URLRequest(val);
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, jsonLoaded);
		}

		public function get data():Object {
			return _data;
		}

		public function set data(value:Object):void {
			_data = value;
		}

		private function jsonLoaded(event:Event):void {
			var jsonContent:URLLoader = URLLoader(event.target);
			
			_data = JSON.parse(jsonContent.data);
		}
	}
}