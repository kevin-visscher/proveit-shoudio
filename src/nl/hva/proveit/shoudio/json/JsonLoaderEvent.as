package nl.hva.proveit.shoudio.json {

    import flash.events.Event;

    public class JsonLoaderEvent extends Event {

        public static const JSON_LOADED:String = "jsonLoaded";

        private var _data:Object;

        public function JsonLoaderEvent(type:String, data:Object) {
            super(type);

            _data = data;
        }

        public function get data():Object {
            return _data;
        }
    }
}
