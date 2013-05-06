package nl.hva.proveit.shoudio.controllers
{
    import mx.controls.Alert;
    import mx.core.FlexGlobals;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;
    import nl.hva.proveit.shoudio.models.ShoudioItemType;
    import nl.hva.proveit.shoudio.views.ImagePlayerView;
    import nl.hva.proveit.shoudio.views.MapMarkerPopup;
    import nl.hva.proveit.shoudio.views.VideoPlayerView;

    public final class MapMarkerPopupController
    {
        public var view:MapMarkerPopup;

        public var item:ShoudioCollectionItem;

        public function doSomethingAwesome():void
        {
            switch (item.type)
            {
                case ShoudioItemType.VIDEO:
                    openVideoPlayer();
                    break;

                case ShoudioItemType.IMAGE:
                    openImageViewer();
                    break;

                default:
                    Alert.show("Unable to handle type: " + item.type);
            }
        }

        private function openVideoPlayer():void
        {
            var topLevelApp:Object = FlexGlobals.topLevelApplication;

            var videoPlayer:VideoPlayerView = new VideoPlayerView();
            videoPlayer.x = (topLevelApp.width - topLevelApp.mapContainer.width) / 2;
            videoPlayer.y = (topLevelApp.height - topLevelApp.mapContainer.height) / 2;
            videoPlayer.width = topLevelApp.mapContainer.width;
            videoPlayer.height = topLevelApp.mapContainer.height;
            videoPlayer.youTubeVideoId = item.externalLink;

            PopUpManager.addPopUp(videoPlayer, view);
        }

        private function openImageViewer():void
        {
            var topLevelApp:Object = FlexGlobals.topLevelApplication;

            var imageViewer:ImagePlayerView = new ImagePlayerView();
            imageViewer.x = (topLevelApp.width - topLevelApp.mapContainer.width) / 2;
            imageViewer.y = (topLevelApp.height - topLevelApp.mapContainer.height) / 2;
            imageViewer.width = topLevelApp.mapContainer.width;
            imageViewer.height = topLevelApp.mapContainer.height;
            imageViewer.imageSource = "http://s3.amazonaws.com/noise.shoudio.com/jpg/original/" + item.shoudioId + ".jpg";

            PopUpManager.addPopUp(imageViewer, view);
        }
    }
}
