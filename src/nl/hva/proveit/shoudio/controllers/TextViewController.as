package nl.hva.proveit.shoudio.controllers
{
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.views.TextView;

    public class TextViewController
    {
        public var view:TextView;

        public function btnClose_clickHandler():void
        {
            PopUpManager.removePopUp(view);
        }
    }
}
