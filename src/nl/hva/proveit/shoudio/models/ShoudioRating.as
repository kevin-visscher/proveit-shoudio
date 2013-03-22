package nl.hva.proveit.shoudio.models {

    public class ShoudioRating {

        private var _value:Number;
        private var _votes:int;

        public function ShoudioRating(value:Number,  votes:int) {
            _value = value;
            _votes = votes;
        }

        public function get value():Number {
            return _value;
        }

        public function get votes():int {
            return _votes;
        }
    }
}
