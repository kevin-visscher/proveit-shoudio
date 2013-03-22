package nl.hva.proveit.shoudio
{
    import flash.display.Sprite;

    public class ShoudioMapMarker extends Sprite
	{
		private var _nName:String;
		private var _nMarker:String;
		private var _nDescription:String;

        public function ShoudioMapMarker()
        {

        }

		public function set resortName(name:String):void
		{
			_nName = name;
		}
		public function get resortName():String
		{
			return _nName;
		} 
		public function set resortDesc(description:String):void
		{
			_nDescription = description;
		}
		public function get resortDesc():String
		{
			return _nDescription;
		} 
	}
}