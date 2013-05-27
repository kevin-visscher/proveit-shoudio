package nl.hva.proveit.shoudio.controllers
{
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.system.Security;

    import mx.controls.Alert;
    import mx.core.UIComponent;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.views.VideoPlayerView;

    public class VideoPlayerController
    {
        private static const YOUTUBE_API_URL:String = "http://www.youtube.com/apiplayer?version=3";

        public var view:VideoPlayerView;
        public var youTubeVideoId:String;

        private var _loader:Loader;

        private var _youTubePlayer:Object;

        private var _paused:Boolean;

        public function init():void
        {
            // Allow YouTube to communicate with the SWF
            Security.allowDomain("www.youtube.com");

            var request:URLRequest = new URLRequest(YOUTUBE_API_URL);

            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.INIT, initYouTubePlayer, false, 0, true);
            _loader.load(request);
        }

        public function clickHandler(e:MouseEvent):void
        {
            if (e.target === view)
            {
                close();
            }
        }

        private function initYouTubePlayer(e:Event):void
        {
            var loaderInfo:LoaderInfo = e.target as LoaderInfo;

            loaderInfo.content.addEventListener("onReady", youTubePlayer_readyHandler);
            loaderInfo.content.addEventListener("onError", youTubePlayer_errorHandler);

            var youTubePlayerContainer:UIComponent = new UIComponent();
            youTubePlayerContainer.addChild(loaderInfo.loader);

            view.videoContainer.addElement(youTubePlayerContainer);
        }

        private function youTubePlayer_readyHandler(e:Event):void
        {
            _youTubePlayer = _loader.content as Object;

            _youTubePlayer.setSize(view.width, (view.width / 4) * 3);
            _youTubePlayer.loadVideoById({ videoId: youTubeVideoId });

            view.currentState = "playing";
        }

        private function youTubePlayer_errorHandler(e:Event):void
        {
            var message:String;
            var errorCode:int = (e as Object).data;

            switch (errorCode)
            {
                // The video was either removed or not found
                case 100:
                    message = "Video was either removed or not found";
                    break;

                // The owner of the video didn't allow the video to be embedded
                case 101:
                case 150:
                    message = "Owner doesn't allow the video to be embedded";
                    break;

                default:
                    message = "N/A (" + errorCode + ")";
            }

            Alert.show("YouTube error: " + message);
        }

        public function btnPlayPause_clickHandler():void
        {
            if (_paused)
            {
                _youTubePlayer.playVideo();
            }
            else
            {
                _youTubePlayer.pauseVideo();
            }

            // Togggle the paused status
            _paused = !_paused;

            // Change the state of the view accordingly
            view.currentState = _paused ? "paused" : "playing";
        }

        public function sliderVolume_changeHandler():void
        {
            _youTubePlayer.setVolume(view.sliderVolume.value);
        }

        public function playingStateEnteredHandler():void
        {
            view.sliderVolume.value = _youTubePlayer.getVolume();
        }

        public function close():void
        {
            // Stop the youtube player
            _youTubePlayer.stopVideo();
            _youTubePlayer.destroy();

            // And unload the swf
            _loader.unloadAndStop();

            PopUpManager.removePopUp(view);
        }
    }
}
