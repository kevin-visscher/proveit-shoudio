package nl.hva.proveit.shoudio.models {
    import org.sepy.io.Serializer;

    public class ShoudioCollection {

        private var _id:int;

        private var _name:String;

        private var _creationDate:Date;

        private var _description:String;

        private var _otherType:String; // ??
        private var _playType:String; // ??

        private var _priceTier:int; // ??

        private var _published:Boolean;

        private var _language:String;

        private var _gettingTherePublicTransport:String;
        private var _gettingThereDescription:String;

        private var _hasImage:Boolean;

        private var _latitude:Number;
        private var _longtitude:Number;

        private var _addr:ShoudioAddress;

        private var _rating:ShoudioRating;

        private var _routeDistance:int;

        private var _startPOI:PointOfInterest;

        private var _route:Array;

        private var _type:String;

        private var _lastUpdated:Date;

        private var _userId:int;

        private var _items:Vector.<ShoudioCollectionItem>;

        public function ShoudioCollection()
        {
            _items = new Vector.<ShoudioCollectionItem>();
        }

        public function get items():Vector.<ShoudioCollectionItem>
        {
            return _items;
        }

        public function get gettingTherePublicTransport():String
        {
            return _gettingTherePublicTransport;
        }

        public function get type():String
        {
            return _type;
        }

        public function get lastUpdated():Date
        {
            return _lastUpdated;
        }

        public function get userId():int
        {
            return _userId;
        }

        public function get id():int
        {
            return _id;
        }

        public function get name():String
        {
            return _name;
        }

        public function get creationDate():Date
        {
            return _creationDate;
        }

        public function get description():String
        {
            return _description;
        }

        public function get otherType():String
        {
            return _otherType;
        }

        public function get playType():String
        {
            return _playType;
        }

        public function get priceTier():int
        {
            return _priceTier;
        }

        public function get published():Boolean
        {
            return _published;
        }

        public function get language():String
        {
            return _language;
        }

        public function get gettingThereDescription():String
        {
            return _gettingThereDescription;
        }

        public function get hasImage():Boolean
        {
            return _hasImage;
        }

        public function get latitude():Number
        {
            return _latitude;
        }

        public function get longtitude():Number
        {
            return _longtitude;
        }

        public function get addr():ShoudioAddress
        {
            return _addr;
        }

        public function get rating():ShoudioRating
        {
            return _rating;
        }

        public function get routeDistance():int
        {
            return _routeDistance;
        }

        public function get startPOI():PointOfInterest
        {
            return _startPOI;
        }

        public function get route():Array
        {
            return _route;
        }

        public static function fromObject(data:Object):ShoudioCollection {

            var collection:Object = data.collection;

            var addr:ShoudioAddress = new ShoudioAddress(collection.address, collection.city);
            var rating:ShoudioRating = new ShoudioRating(collection.rating_rate, collection.rating_votes);

            var poi:PointOfInterest = new PointOfInterest(
                    collection.startpoi_country,
                    collection.startpoi_state,
                    collection.startpoi_city,
                    collection.startpoi_street,
                    collection.startpoi_zip
            );

            poi.title = collection.startpoi_title;

            var o:ShoudioCollection = new ShoudioCollection();
            o._addr = addr;
            o._rating = rating;
            o._creationDate = parseShoudioDate(collection.created_on);
            o._description = collection.description;
            o._gettingTherePublicTransport = collection.getting_there_owntransport;
            o._gettingThereDescription = collection.getting_there_publictransport;
            o._hasImage = collection.hasimg === 1;
            o._id = collection.id;
            o._language = collection.lang;
            o._latitude = collection.lat;
            o._longtitude = collection.lon;
            o._name = collection.name;
            o._otherType = collection.othertype;
            o._playType = collection.playType;
            o._priceTier = collection.pricetier;
            o._published = collection.published === 1;
            o._route = Serializer.unserialize(collection.route) as Array;
            o._routeDistance = collection.routedistance;
            o._startPOI = poi;
            o._type = collection.type;
            o._lastUpdated = parseShoudioDate(collection.updated_at);
            o._userId = collection.userid;

            for each (var item:Object in data.contents)
                o.items.push(ShoudioCollectionItem.fromObject(item));

            return o;
        }

        private static function parseShoudioDate(str:String):Date {

            var splitIndex:int = str.indexOf(" ");

            if (splitIndex === -1)
                return new Date();

            var dateStr:String = str.substring(0, splitIndex);
            var timeStr:String = str.substring(splitIndex);

            var dateArr:Array = dateStr.split("-");
            var timeArr:Array = timeStr.split(":");

            return new Date(
                    parseInt(dateArr[0]),
                    parseInt(dateArr[1]) - 1, // months range from 0 to 11
                    parseInt(dateArr[2]),
                    parseInt(timeArr[0]) - 1, // hours from 0 to 23
                    parseInt(timeArr[1]),
                    parseInt(timeArr[2]),
                    0
            );
        }
    }
}