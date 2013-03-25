package nl.hva.proveit.shoudio.models
{
    public class PointOfInterest
    {

        // only used in "poi_"?
        private var _categoryId:int;

        private var _country:String;
        private var _state:String;
        private var _city:String;
        private var _street:String;
        private var _zip:String;

        // only used in "startpoi_"?
        private var _title:String;

        public function PointOfInterest(country:String, state:String, city:String, street:String, zip:String)
        {

            _country = country;
            _state = state;
            _city = city;
            _street = street;
            _zip = zip;
        }


        public function get categoryId():int
        {
            return _categoryId;
        }

        public function set categoryId(value:int):void
        {
            _categoryId = value;
        }

        public function get country():String
        {
            return _country;
        }

        public function get state():String
        {
            return _state;
        }

        public function get city():String
        {
            return _city;
        }

        public function get street():String
        {
            return _street;
        }

        public function get zip():String
        {
            return _zip;
        }

        public function get title():String
        {
            return _title;
        }

        public function set title(value:String):void
        {
            _title = value;
        }

        public function clone():PointOfInterest
        {
            var clone:PointOfInterest = new PointOfInterest(country, state, city, street, zip);
            clone.title = title;
            clone.categoryId = categoryId;

            return clone;
        }
    }
}
