package nl.hva.proveit.shoudio.controllers
{
    import mx.core.FlexGlobals;
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

            FlexGlobals.topLevelApplication.currentState = "sidebarVisible";
        }

        public function init():void
        {
            view.lblRouteDescription.text = collection.description;
            view.lblRouteName.text = collection.name;
            view.lblUsername.text = collection.items[0].userName;
            view.lblRating.text = collection.rating + "/ 5";
        }
    }
}
