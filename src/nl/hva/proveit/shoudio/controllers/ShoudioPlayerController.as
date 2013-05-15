package nl.hva.proveit.shoudio.controllers
{

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.utils.ByteArray;
    import flash.utils.Timer;

    import mx.controls.Alert;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.views.ShoudioPlayerView;

    public class ShoudioPlayerController
    {
        public var view:ShoudioPlayerView;

        [Bindable]
        public var imageWaveSource:ByteArray;

        private var _shoudioId:int;

        private var _sound:Sound;
        private var _soundChannel:SoundChannel;

        private var _pausePosition:Number;

        private var _hasImageLoaded:Boolean;
        private var _hasSoundLoaded:Boolean;

        private var _hasEverytingLoadedTimer:Timer;

        public function ShoudioPlayerController()
        {
            _sound = new Sound();

            _pausePosition = 0;

            _hasImageLoaded = false;
            _hasSoundLoaded = false;

            _hasEverytingLoadedTimer = new Timer(50);
            _hasEverytingLoadedTimer.addEventListener(TimerEvent.TIMER, hasEverythingLoadedTimer_tickHandler, false, 0, true);
        }

        private function hasEverythingLoadedTimer_tickHandler(e:TimerEvent):void
        {
            if (_hasImageLoaded && _hasSoundLoaded)
            {
                _hasEverytingLoadedTimer.stop();
                _hasEverytingLoadedTimer.removeEventListener(TimerEvent.TIMER, hasEverythingLoadedTimer_tickHandler);

                _soundChannel = _sound.play();
                _soundChannel.addEventListener(Event.SOUND_COMPLETE, soundChannel_soundCompleteHandler, false, 0 ,true);

                view.currentState = "playing";
            }
        }

        private function soundChannel_soundCompleteHandler(e:Event):void
        {
            _pausePosition = 0;

            view.currentState = "paused";
        }

        public function btnPlayPause_clickHandler():void
        {
            if (view.currentState === "playing")
            {
                _pausePosition = _soundChannel.position;

                _soundChannel.stop();

                view.currentState = "paused";
            }
            else if (view.currentState === "paused")
            {
                _soundChannel = null;
                _soundChannel = _sound.play(_pausePosition);

                view.currentState = "playing";
            }
        }

        public function btnClose_clickHandler():void
        {
            if (_soundChannel)
                _soundChannel.stop();

            close();
        }

        private function loadSound(url:String):void
        {
            _sound.addEventListener(IOErrorEvent.IO_ERROR, sound_ioErrorHandler, false, 0 ,true);
            _sound.addEventListener(Event.COMPLETE, sound_loadedHandler, false, 0 , true);

            _sound.load(new URLRequest(url));
        }

        private function loadSoundSpectrumImage(url:String):void
        {
            var request:URLRequest = new URLRequest(url);
            request.method = URLRequestMethod.GET;

            var imageLoader:URLLoader = new URLLoader();
            imageLoader.dataFormat = URLLoaderDataFormat.BINARY;

            imageLoader.addEventListener(IOErrorEvent.IO_ERROR, image_ioErrorHandler, false, 0, true);
            imageLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, image_securityErrorHandler, false, 0 ,true);
            imageLoader.addEventListener(Event.COMPLETE, image_loadedHandler, false, 0, true);

            imageLoader.load(request);
        }

        private function close():void
        {
            PopUpManager.removePopUp(view);
        }

        private function sound_ioErrorHandler(e:IOErrorEvent):void
        {
            Alert.show("Was unable to play the requested shoudio. Sorry..");

            close();
        }

        private function sound_loadedHandler(e:Event):void
        {
            _hasSoundLoaded = true;
        }

        private function image_ioErrorHandler(e:IOErrorEvent):void
        {
            _hasEverytingLoadedTimer.stop();
            _hasEverytingLoadedTimer.removeEventListener(TimerEvent.TIMER, hasEverythingLoadedTimer_tickHandler);

            close();
        }

        private function image_securityErrorHandler(e:SecurityErrorEvent):void
        {
            _hasEverytingLoadedTimer.stop();
            _hasEverytingLoadedTimer.removeEventListener(TimerEvent.TIMER, hasEverythingLoadedTimer_tickHandler);

            close();
        }

        private function image_loadedHandler(e:Event):void
        {
            var imageLoader:URLLoader = e.target as URLLoader;

            imageLoader.removeEventListener(IOErrorEvent.IO_ERROR, image_ioErrorHandler);
            imageLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, image_securityErrorHandler);
            imageLoader.removeEventListener(Event.COMPLETE, image_loadedHandler);

            imageWaveSource = imageLoader.data as ByteArray;

            _hasImageLoaded = true;
        }

        [Bindable]
        public function get shoudioId():int
        {
            return _shoudioId;
        }

        public function set shoudioId(value:int):void
        {
            _shoudioId = value;

            loadSound("http://s3.amazonaws.com/noise.shoudio.com/mp3/shoudio_" + _shoudioId + ".mp3");
            loadSoundSpectrumImage("http://s3.amazonaws.com/noise.shoudio.com/waveform/small/" + _shoudioId + ".png");

            _hasEverytingLoadedTimer.start();
        }

        public function removedHandler():void
        {
            if (_soundChannel)
                _soundChannel.stop();
        }
    }
}
