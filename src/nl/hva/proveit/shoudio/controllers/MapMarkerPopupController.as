package nl.hva.proveit.shoudio.controllers
{
    import mx.controls.Alert;
    import mx.core.FlexGlobals;
    import mx.core.IFlexDisplayObject;
    import mx.effects.AnimateProperty;
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.models.ShoudioCollectionItem;
    import nl.hva.proveit.shoudio.models.ShoudioItemType;
    import nl.hva.proveit.shoudio.views.ImagePlayerView;
    import nl.hva.proveit.shoudio.views.MapMarkerPopup;
    import nl.hva.proveit.shoudio.views.ShoudioPlayerView;
    import nl.hva.proveit.shoudio.views.TextView;
    import nl.hva.proveit.shoudio.views.VideoPlayerView;

    import spark.components.Group;

    public final class MapMarkerPopupController
    {
        private static var _openedPopup:IFlexDisplayObject;

        [Bindable]
        public var btnOpenViewerLabel:String;

        public var view:MapMarkerPopup;

        private var _item:ShoudioCollectionItem;

        public function init():void
        {
            if (item.type === ShoudioItemType.POINT_OF_INTEREST)
            {
                view.txtDescription.includeInLayout = true;
                view.txtDescription.visible = true;
            }
        }

        public function doSomethingAwesome():void
        {
            if (_openedPopup)
            {
                closeOpenPopup();
            }

            switch (item.type)
            {
                case ShoudioItemType.VIDEO:
                    openVideoPlayer();
                    break;

                case ShoudioItemType.POINT_OF_INTEREST:
                case ShoudioItemType.IMAGE:
                    openImageViewer();
                    break;

                case ShoudioItemType.SHOUDIO:
                    openShoudioPlayer();
                    break;

                case ShoudioItemType.TEXT:
                    openTextViewer();
                    break;

                default:
                    Alert.show("Sorry. Was unable to handle type: " + item.type);
            }
        }

        private function closeOpenPopup():void
        {
            PopUpManager.removePopUp(_openedPopup);

            _openedPopup = null;
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

        private function openShoudioPlayer():void
        {
            var shoudioPlayer:ShoudioPlayerView = new ShoudioPlayerView();
            shoudioPlayer.shoudioId = item.shoudioId;

            openViewer(shoudioPlayer, NaN, 150);
        }

        private function openTextViewer():void
        {
            var textViewer:TextView = new TextView();
            textViewer.item = item;

            openViewer(textViewer);
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
            anim.toValue = topLevelApp.mapContainer.y + (topLevelApp.mapContainer.height - viewer.height);
            anim.duration = 350;

            viewer.setStyle("addedEffect", anim);

            PopUpManager.addPopUp(viewer, view);

            _openedPopup = viewer;
        }

        public function get item():ShoudioCollectionItem
        {
            return _item;
        }

        public function set item(value:ShoudioCollectionItem):void
        {
            _item = value;

            switch (_item.type)
            {
                case ShoudioItemType.POINT_OF_INTEREST:
                case ShoudioItemType.IMAGE:
                    btnOpenViewerLabel = "View image";
                    break;

                case ShoudioItemType.SHOUDIO:
                    btnOpenViewerLabel = "Listen";
                    break;

                case ShoudioItemType.TEXT:
                    btnOpenViewerLabel = "View text";
                    break;

                case ShoudioItemType.VIDEO:
                    btnOpenViewerLabel = "Play video";
                    break;

                default:
                    btnOpenViewerLabel = "Try to open";
            }
        }

        public function btnClose_clickHandler():void
        {
            closeOpenPopup();
        }
    }
}
