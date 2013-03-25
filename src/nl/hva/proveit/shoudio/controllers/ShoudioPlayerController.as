package nl.hva.proveit.shoudio.controllers
{

    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLRequest;

    import mx.controls.Alert;

    import nl.hva.proveit.shoudio.views.ShoudioPlayerView;

    public class ShoudioPlayerController
    {

        public var view:ShoudioPlayerView;

        private var _source:String;

        private var _sound:Sound;
        private var _soundChannel:SoundChannel;

        public function btnPlayPause_clickHandler():void
        {

            Alert.show("loading sound..(" + _source + ")");

            if (view.currentState === "playing")
            {

                _soundChannel.stop();

                view.currentState = "default";

            }
            else
            {

                if (!!_sound)
                {
                    _sound = new Sound(new URLRequest(_source));

                    Alert.show("loading sound..(" + _source + ")");

                    _sound.addEventListener(Event.COMPLETE, function (e:Event):void
                    {
                        Alert.show("sound loaded");
                        _soundChannel = _sound.play();
                    });

                }
                else
                {
                    _sound.play(_soundChannel.position);
                }

                view.currentState = "playing";
            }
        }

        [Bindable]
        public function get source():String
        {
            return _source;
        }

        public function set source(value:String):void
        {
            _source = value;
        }
    }
}
