package nl.hva.proveit.shoudio.controllers
{
    import mx.managers.PopUpManager;

    import nl.hva.proveit.shoudio.models.ShoudioCollection;
    import nl.hva.proveit.shoudio.views.StartView;

    public class StartController
    {
        public var view:StartView;

        [Bindable]
        public var collection:ShoudioCollection;

        public function btnStart_clickHandler():void
        {
            PopUpManager.removePopUp(view);
        }
    }
}
