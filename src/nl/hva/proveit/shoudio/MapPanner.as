package nl.hva.proveit.shoudio
{
    import com.modestmaps.Map;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class MapPanner
    {
        private static const DELAY:Number = 50;

        private var _map:Map;

        private var _handler:Function;

        private var _timer:Timer;

        private var _panToX:Number;
        private var _panToY:Number;

        private var _stepX:Number;
        private var _stepY:Number;

        private var _currentX:Number;
        private var _currentY:Number;

        private var _endX:Number;
        private var _endY:Number;

        public function MapPanner(map:Map)
        {
            _map = map;

            _timer = new Timer(DELAY);
            _timer.addEventListener(TimerEvent.TIMER, onTimerTick, false, 0, true);
        }

        public function start(currentX:Number, panToX:Number, currentY:Number, panToY:Number, handler:Function):void
        {
            _panToX = panToX;
            _panToY = panToY;

            _currentX = currentX;
            _currentY = currentY;

            _endX = (currentX - panToX);
            _endY = (currentY - panToY);

            _stepX = _endX / DELAY;
            _stepY = _endY / DELAY;

            _timer.repeatCount = (_endX / _stepX) > (_endY / _stepY) ? (_endX / _stepX) : (_endY / _stepY);

            _handler = handler;

            _timer.start();
        }


        private function onTimerTick(e:TimerEvent):void
        {
            _map.panBy(_stepX, _stepY);

            if (_currentX !== _endX)
                _currentX += _stepX;

            if (_currentY !== _endY)
                _currentY += _stepY;

            if (_currentX === _endX && _currentY === _endY)
            {
                _handler();
                _timer.stop();
            }
        }

        public function get panToX():Number
        {
            return _panToX;
        }

        public function set panToX(value:Number):void
        {
            _panToX = value;
        }

        public function get panToY():Number
        {
            return _panToY;
        }

        public function set panToY(value:Number):void
        {
            _panToY = value;
        }
    }
}
