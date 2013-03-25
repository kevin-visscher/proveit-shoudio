package nl.hva.proveit.shoudio.models
{
    public class ShoudioAddress
    {
        private var _location:String;
        private var _city:String;

        public function ShoudioAddress(location:String, city:String)
        {
            _location = location;
            _city = city;
        }

        public function get location():String
        {
            return _location;
        }

        public function get city():String
        {
            return _city;
        }
    }
}
