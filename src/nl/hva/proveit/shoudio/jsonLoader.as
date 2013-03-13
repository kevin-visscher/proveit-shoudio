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
		
		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}

		public function get data():Object {
			return _data;
		}

		public function set data(value:Object):void {
			_data = value;
		}

		public function jsonLoaded(event:Event):void {
			var jsonContent:URLLoader = URLLoader(event.target);
			
			//json
			_data = JSON.parse(jsonContent.data);
			/*
			lbl1.text = data.shoudios.length;
			lbl2.text = "The first one is " + data.shoudios[0].id + " : " + data.shoudios[0].username;
			
			var secondShoudio:String = data.shoudios[0].id;
			lbl3.text = "secondShoudio as string data: " + secondShoudio;
			*/
		}
	}
}