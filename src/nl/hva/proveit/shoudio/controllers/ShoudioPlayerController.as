package nl.hva.proveit.shoudio.controllers
{

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.TimerEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundMixer;
    import flash.media.SoundTransform;
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

        [Bindable]
        public var currentMinutes:String;

        [Bindable]
        public var currentSeconds:String;

        [Bindable]
        public var totalMinutes:String;

        [Bindable]
        public var totalSeconds:String;

        [Bindable]
        public var offsetRight:Number;

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

                var secs:Number = Math.round(_sound.length / 1000);
                var mins:Number = secs >= 60 ? Math.floor(secs / 60) : 0;
                var seconds:Number = secs - mins * 60;

                if (mins >= 0)
                {
                    if (mins > 9)
                    {
                        totalMinutes = mins + "";
                    }
                    else
                    {
                        totalMinutes = "0" + mins;
                    }
                }

                totalSeconds = seconds + "";

                if (seconds < 10)
                {
                    totalSeconds = "0" + seconds;
                }

                view.currentState = "playing";
            }
        }

        private function soundChannel_soundCompleteHandler(e:Event):void
        {
            _soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundChannel_soundCompleteHandler);

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
                _soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundChannel_soundCompleteHandler);

                _soundChannel = _sound.play(_pausePosition);
                _soundChannel.addEventListener(Event.SOUND_COMPLETE, soundChannel_soundCompleteHandler);

                view.currentState = "playing";
            }
        }

        public function btnClose_clickHandler():void
        {
            if (_soundChannel)
                _soundChannel.stop();

            close();
        }

        private function updatePlayingTimes(e:Event):void
        {
            var pos:Number = view.currentState === "paused" ? _pausePosition : _soundChannel.position;

            var progressPercent:Number = pos / _sound.length;
            var offsetRight:Number = view.imgWave.width - view.imgWave.width * progressPercent;

            if (offsetRight <= 0)
                offsetRight = 0;

            view.waveOverlay.right = offsetRight;

            updateCurrentTime();
        }

        private function loadSound(url:String):void
        {
            try
            {
                _sound.load(new URLRequest(url));

                _sound.addEventListener(IOErrorEvent.IO_ERROR, sound_ioErrorHandler, false, 0 ,true);
                _sound.addEventListener(Event.COMPLETE, sound_loadedHandler, false, 0 , true);
            }
            catch (err:Error)
            {
                Alert.show("There was an error playing the item");
            }
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
            view.removeEventListener(Event.ENTER_FRAME, updatePlayingTimes);

            PopUpManager.removePopUp(view);
        }

        private function sound_ioErrorHandler(e:IOErrorEvent):void
        {
            Alert.show("Was unable to play the requested shoudio. Sorry..");

            close();
        }

        private function sound_loadedHandler(e:Event):void
        {
            _soundChannel = _sound.play();
            _soundChannel.addEventListener(Event.SOUND_COMPLETE, soundChannel_soundCompleteHandler, false, 0, true);

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

        public function sliderCreated():void
        {
            view.sliderVolume.value = SoundMixer.soundTransform.volume * 100;
        }

        public function sliderVolume_changeHandler():void
        {
            SoundMixer.soundTransform = new SoundTransform(view.sliderVolume.value / 100);
        }

        public function controlGroupCreatedHandler():void
        {
            view.addEventListener(Event.ENTER_FRAME, updatePlayingTimes);
        }

        public function wave_clickHandler(e:MouseEvent):void
        {
            var position:Number = (e.localX / view.imgWave.width) * _sound.length;

            if (view.currentState === "paused")
            {
                _pausePosition = position;

                updateCurrentTime();
            }
            else
            {
                // Currently playing, skip right ahead and start playing
                _soundChannel.stop();
                _soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundChannel_soundCompleteHandler);

                _soundChannel = _sound.play(position);
                _soundChannel.addEventListener(Event.SOUND_COMPLETE, soundChannel_soundCompleteHandler);
            }
        }

        private function updateCurrentTime():void
        {
            var pos:Number = view.currentState === "paused" ? _pausePosition : _soundChannel.position;

            var secs:Number = Math.round(pos / 1000);
            var mins:Number = secs >= 60 ? Math.floor(secs / 60) : 0;
            var seconds:Number = secs - mins * 60;

            if (mins >= 0)
            {
                if (mins > 9)
                {
                    currentMinutes = mins + "";
                }
                else
                {
                    currentMinutes = "0" + mins;
                }
            }

            currentSeconds = seconds + "";

            if (seconds < 10)
            {
                currentSeconds = "0" + seconds;
            }
        }
    }
}
