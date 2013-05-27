package nl.hva.proveit.shoudio.controllers
{
    import flash.events.MouseEvent;

    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.views.TextView;

    public class TextViewController
    {
        public var view:TextView;

        public function clickHandler(e:MouseEvent):void
        {
            if (e.target === view)
            {
                close();
            }
        }

        public function close():void
        {
            PopUpManager.removePopUp(view);
        }
    }
}
