package nl.hva.proveit.shoudio.controllers
{
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;
    import flash.system.Security;

    import mx.controls.Alert;
    import mx.core.UIComponent;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.views.VideoPlayerView;

    public class VideoPlayerController
    {
        private static const YOUTUBE_EMBED_URL:String = "http://www.youtube.com/v/";
        private static const YOUTUBE_EMBED_URL_PARAMS:String = "?playerapiid=ytplayer&version=3&autoplay=1";

        public var view:VideoPlayerView;
        public var youTubeVideoId:String;

        private var _loader:Loader;

        private var _youtubePlayer:Object;

        public function init():void
        {
            // Allow YouTube to communicate with the SWF
            Security.allowDomain("www.youtube.com");

            var request:URLRequest = new URLRequest(YOUTUBE_EMBED_URL + youTubeVideoId + YOUTUBE_EMBED_URL_PARAMS);

            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_securityErrorHandler, false, 0, true);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler, false, 0, true);
            _loader.contentLoaderInfo.addEventListener(Event.INIT, loader_initHandler, false, 0, true);
            _loader.load(request);
        }

        private function loader_initHandler(e:Event):void
        {
            _youtubePlayer = _loader.content;
            _youtubePlayer.addEventListener("onReady", youtubePlayer_readyHandler);

            var youTubePlayerContainer:UIComponent = new UIComponent();
            youTubePlayerContainer.addChild(_loader);

            view.videoContainer.addElement(youTubePlayerContainer);
        }

        private function youtubePlayer_readyHandler(e:Event):void
        {
            _youtubePlayer.setSize(400, 300);
        }

        private function loader_securityErrorHandler(e:SecurityErrorEvent):void
        {
            Alert.show("error loading the video");
        }

        private function loader_ioErrorHandler(e:IOErrorEvent):void
        {
            Alert.show("error loading the video");
        }

        public function clickHandler(e:MouseEvent):void
        {
            if (e.target === view)
            {
                close();
            }
        }

        public function close():void
        {
            // And unload the swf
            _loader.unloadAndStop();

            PopUpManager.removePopUp(view);
        }
    }
}
