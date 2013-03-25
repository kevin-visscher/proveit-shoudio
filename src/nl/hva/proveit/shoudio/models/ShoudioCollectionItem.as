package nl.hva.proveit.shoudio.models
{
    [Bindable]
    public class ShoudioCollectionItem
    {
        private var _id:int;

        private var _collectionId:int;

        private var _channelId:int;

        private var _deviceId:int;

        private var _clientId:String; // Name

        private var _licenseId:int;

        private var _listId:int;

        private var _placeId:int;

        private var _poi:PointOfInterest;

        private var _shoudioId:int;

        private var _creationDate:Date;

        private var _message:String;

        private var _description:String;

        private var _altitudeAccuracy:Number;

        private var _attribution:Object; // ??

        private var _duration:Number;

        private var _email:String;

        /**
         * The type of the item.
         * @see ShoudioItemType
         */
        private var _type:String;

        // Depends on property type
        // if the type is youtube this link only contains: "/watch?v=sadas
        private var _externalLink:String;

        private var _hasImage:Boolean;

        private var _hasMp3:Boolean;

        private var _heading:Number;

        private var _iplong:uint;

        private var _latitude:Number;
        private var _longtitude:Number;

        private var _locationAccurary:int;
        private var _locationTimestamp:uint;

        private var _nearby:String;

        private var _telephone:String;

        // -1 or >= 0
        // indicates if it should be used in the sorting?
        private var _sorting:int;

        private var _speed:int; // ??

        private var _userId:int;
        private var _userImageType:String;
        private var _userName:String;

        private var _published:Boolean;

        public function get id():int
        {
            return _id;
        }

        public function set id(value:int):void
        {
            _id = value;
        }

        public function get collectionId():int
        {
            return _collectionId;
        }

        public function set collectionId(value:int):void
        {
            _collectionId = value;
        }

        public function get channelId():int
        {
            return _channelId;
        }

        public function set channelId(value:int):void
        {
            _channelId = value;
        }

        public function get deviceId():int
        {
            return _deviceId;
        }

        public function set deviceId(value:int):void
        {
            _deviceId = value;
        }

        public function get clientId():String
        {
            return _clientId;
        }

        public function set clientId(value:String):void
        {
            _clientId = value;
        }

        public function get licenseId():int
        {
            return _licenseId;
        }

        public function set licenseId(value:int):void
        {
            _licenseId = value;
        }

        public function get listId():int
        {
            return _listId;
        }

        public function set listId(value:int):void
        {
            _listId = value;
        }

        public function get placeId():int
        {
            return _placeId;
        }

        public function set placeId(value:int):void
        {
            _placeId = value;
        }

        public function get poi():PointOfInterest
        {
            return _poi;
        }

        public function set poi(value:PointOfInterest):void
        {
            _poi = value;
        }

        public function get shoudioId():int
        {
            return _shoudioId;
        }

        public function set shoudioId(value:int):void
        {
            _shoudioId = value;
        }

        public function get creationDate():Date
        {
            return _creationDate;
        }

        public function set creationDate(value:Date):void
        {
            _creationDate = value;
        }

        public function get message():String
        {
            return _message;
        }

        public function set message(value:String):void
        {
            _message = value;
        }

        public function get description():String
        {
            return _description;
        }

        public function set description(value:String):void
        {
            _description = value;
        }

        public function get altitudeAccuracy():Number
        {
            return _altitudeAccuracy;
        }

        public function set altitudeAccuracy(value:Number):void
        {
            _altitudeAccuracy = value;
        }

        public function get attribution():Object
        {
            return _attribution;
        }

        public function set attribution(value:Object):void
        {
            _attribution = value;
        }

        public function get duration():Number
        {
            return _duration;
        }

        public function set duration(value:Number):void
        {
            _duration = value;
        }

        public function get email():String
        {
            return _email;
        }

        public function set email(value:String):void
        {
            _email = value;
        }

        public function get type():String
        {
            return _type;
        }

        public function set type(value:String):void
        {
            _type = value;
        }

        public function get externalLink():String
        {
            return _externalLink;
        }

        public function set externalLink(value:String):void
        {
            _externalLink = value;
        }

        public function get hasImage():Boolean
        {
            return _hasImage;
        }

        public function set hasImage(value:Boolean):void
        {
            _hasImage = value;
        }

        public function get hasMp3():Boolean
        {
            return _hasMp3;
        }

        public function set hasMp3(value:Boolean):void
        {
            _hasMp3 = value;
        }

        public function get heading():Number
        {
            return _heading;
        }

        public function set heading(value:Number):void
        {
            _heading = value;
        }

        public function get iplong():uint
        {
            return _iplong;
        }

        public function set iplong(value:uint):void
        {
            _iplong = value;
        }

        public function get latitude():Number
        {
            return _latitude;
        }

        public function set latitude(value:Number):void
        {
            _latitude = value;
        }

        public function get longtitude():Number
        {
            return _longtitude;
        }

        public function set longtitude(value:Number):void
        {
            _longtitude = value;
        }

        public function get locationAccurary():int
        {
            return _locationAccurary;
        }

        public function set locationAccurary(value:int):void
        {
            _locationAccurary = value;
        }

        public function get locationTimestamp():uint
        {
            return _locationTimestamp;
        }

        public function set locationTimestamp(value:uint):void
        {
            _locationTimestamp = value;
        }

        public function get nearby():String
        {
            return _nearby;
        }

        public function set nearby(value:String):void
        {
            _nearby = value;
        }

        public function get telephone():String
        {
            return _telephone;
        }

        public function set telephone(value:String):void
        {
            _telephone = value;
        }

        public function get sorting():int
        {
            return _sorting;
        }

        public function set sorting(value:int):void
        {
            _sorting = value;
        }

        public function get speed():int
        {
            return _speed;
        }

        public function set speed(value:int):void
        {
            _speed = value;
        }

        public function get userId():int
        {
            return _userId;
        }

        public function set userId(value:int):void
        {
            _userId = value;
        }

        public function get userImageType():String
        {
            return _userImageType;
        }

        public function set userImageType(value:String):void
        {
            _userImageType = value;
        }

        public function get userName():String
        {
            return _userName;
        }

        public function set userName(value:String):void
        {
            _userName = value;
        }

        public function clone():ShoudioCollectionItem
        {
            var clone:ShoudioCollectionItem = new ShoudioCollectionItem();

            clone._altitudeAccuracy = this.altitudeAccuracy;
            clone._attribution = this.attribution;
            clone._channelId = this.channelId;
            clone._clientId = this.clientId;
            clone._collectionId = this.collectionId;
            clone._creationDate = this.creationDate
            clone._description = this.description;
            clone._deviceId = this.deviceId;
            clone._duration = this.duration;
            clone._email = this.email;
            clone._externalLink = this.externalLink;
            clone._hasImage = this.hasImage;
            clone._hasMp3 = this.hasMp3;
            clone._heading = this.heading;
            clone._id = this.id;
            clone._iplong = this.iplong;
            clone._latitude = this.latitude;
            clone._licenseId = this.licenseId;
            clone._listId = this.listId;
            clone._locationAccurary = this.locationAccurary;
            clone._locationTimestamp = this.locationTimestamp;
            clone._longtitude = this.longtitude;
            clone._message = this.message;
            clone._nearby = this.nearby;
            clone._placeId = this.placeId;
            clone._poi = this.poi.clone();

            clone._published = this._published;
            clone._shoudioId = this.shoudioId;
            clone._sorting = this.sorting;
            clone._speed = this.speed;
            clone._telephone = this.telephone;
            clone._type = this.type;
            clone._userId = this.userId;
            clone._userImageType = this.userImageType;
            clone._userName = this.userName;

            return clone;
        }

        public static function fromObject(o:Object):ShoudioCollectionItem
        {
            var item:ShoudioCollectionItem = new ShoudioCollectionItem();
            item._altitudeAccuracy = o.altitudeAccuracy;
            item._attribution = o.attribution;
            item._channelId = o.channelid;
            item._clientId = o.clientid;
            item._collectionId = o.collectionsid;
            item._creationDate = parseShoudioDate(o.created_at);
            item._description = o.description;
            item._deviceId = o.deviceid;
            item._duration = o.duration;
            item._email = o.email;
            item._externalLink = o.external_link;
            item._hasImage = o.hasimg === 1;
            item._hasMp3 = o.hasmp3 === 1;
            item._heading = o.heading;
            item._id = o.id;
            item._iplong = o.iplong;
            item._latitude = o.lat;
            item._licenseId = o.license_id;
            item._listId = o.list_id;
            item._locationAccurary = o.locationAccurary;
            item._locationTimestamp = o.locationTimestamp;
            item._longtitude = o.lon;
            item._message = o.message;
            item._nearby = o.nearby;
            item._placeId = o.placeid;

            var poi:PointOfInterest = new PointOfInterest(
                    o.poi_country,
                    o.poi_state,
                    o.poi_city,
                    o.poi_address,
                    o.poi_zip
            );

            poi.categoryId = o.poi_category;

            item._poi = poi;
            item._published = o.published === 1;
            item._shoudioId = o.shoudio_id;
            item._sorting = o.sorting;
            item._speed = o.speed;
            item._telephone = o.telephone;
            item._type = o.type;
            item._userId = o.u_id;
            item._userImageType = o.u_img;
            item._userName = o.u_name;

            return item;
        }

        private static function parseShoudioDate(str:String):Date
        {

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
