package nl.hva.proveit.shoudio.controllers
{
    import flash.events.Event;

    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.views.ImagePlayerView;

    public class ImagePlayerController
    {
        public var view:ImagePlayerView;

        public function init():void
        {

        }

        public function btnClose_clickHandler():void
        {
            PopUpManager.removePopUp(view);
        }

        public function image_readyHandler(e:Event):void
        {
            if (view.image.width > view.width)
                view.image.width = view.width;

            if (view.image.height > view.height)
                view.image.height = view.height;

            view.currentState = "done";
        }
    }
}
