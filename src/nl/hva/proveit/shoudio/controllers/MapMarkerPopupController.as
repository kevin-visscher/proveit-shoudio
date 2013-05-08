package nl.hva.proveit.shoudio.controllers
{
    import mx.controls.Alert;
    import mx.core.FlexGlobals;
    import mx.effects.AnimateProperty;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;
    import nl.hva.proveit.shoudio.models.ShoudioItemType;
    import nl.hva.proveit.shoudio.views.ImagePlayerView;
    import nl.hva.proveit.shoudio.views.MapMarkerPopup;
    import nl.hva.proveit.shoudio.views.VideoPlayerView;

    import spark.components.Group;

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
                    Alert.show("Sorry. Was unable to handle type: " + item.type);
            }
        }

        private function openVideoPlayer():void
        {
            var videoPlayer:VideoPlayerView = new VideoPlayerView();
            videoPlayer.youTubeVideoId = item.externalLink;

            openViewer(videoPlayer);
        }

        private function openImageViewer():void
        {
            var imageViewer:ImagePlayerView = new ImagePlayerView();
            imageViewer.imageSource = "http://s3.amazonaws.com/noise.shoudio.com/jpg/original/" + item.shoudioId + ".jpg";

            openViewer(imageViewer);
        }

        private final function openViewer(viewer:Group, width:Number = NaN, height:Number = NaN):void
        {
            var topLevelApp:Object = FlexGlobals.topLevelApplication;

            viewer.x = (topLevelApp.width - topLevelApp.mapContainer.width) / 2;
            viewer.y = topLevelApp.height;

            viewer.width = width || topLevelApp.mapContainer.width;
            viewer.height = height || topLevelApp.mapContainer.height;

            var anim:AnimateProperty = new AnimateProperty(viewer);
            anim.property = "y";
            anim.fromValue = viewer.y;
            anim.toValue = (topLevelApp.height - viewer.height) / 2 + (topLevelApp.mapContainer.height - viewer.height) / 2;
            anim.duration = 350;

            viewer.setStyle("addedEffect", anim);

            PopUpManager.addPopUp(viewer, view);
        }
    }
}
