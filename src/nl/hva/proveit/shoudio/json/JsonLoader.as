// ActionScript file
package nl.hva.proveit.shoudio.json {

    import flash.events.*;
    import flash.net.*;

    import mx.controls.Alert;

    public class JsonLoader extends EventDispatcher {
		
		private var _loader:URLLoader;

		public function JsonLoader() {
            _loader = new URLLoader();
            _loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
            _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_securityErrorHandler);
            _loader.addEventListener(Event.COMPLETE, loader_completeHandler);
		}

        public function load(url:String):void {
            _loader.load(new URLRequest(url));
        }

        private function loader_ioErrorHandler(e:IOErrorEvent):void {
            Alert.show(e.toString());
        }

        private function loader_securityErrorHandler(e:SecurityErrorEvent):void {
            Alert.show(e.toString());
        }

		private function loader_completeHandler(e:Event):void {
			dispatchEvent(new JsonLoaderEvent(
                    JsonLoaderEvent.JSON_LOADED,
                    JSON.parse(_loader.data)
            ));
		}
	}
}