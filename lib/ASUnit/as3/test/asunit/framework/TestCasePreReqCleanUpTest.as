package asunit.framework
{
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class TestCasePreReqCleanUpTest extends TestCase
    {

        private var listener:Function;
        private var asyncTimer:Timer;

        //Set SHOW_TRACES to true if you want to see the sequence of setUp/test/tearDown
        private const SHOW_TRACES:Boolean = false;

        private const TIMEOUT:int = 0;

        private function traceOut(message:String):void
        {
            if (SHOW_TRACES)
               trace(message);
        }

        //this is executed BEFORE all the tests
        override protected function preReq():void
        {
            traceOut("preReq called!");
            asyncTimer = new Timer(TIMEOUT, 1);
            listener = addAsync(onPreReqFirstTimeout);
            asyncTimer.addEventListener(TimerEvent.TIMER_COMPLETE, listener);
            asyncTimer.start();
        }

        private function onPreReqFirstTimeout(e:Event):void
        {
            asyncTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, listener);
            traceOut("onPreReqFirstTimeout called!");
            listener = addAsync(onPreReqSecondTimeout);
            asyncTimer.addEventListener(TimerEvent.TIMER_COMPLETE, listener);
            asyncTimer.start();
        }

        private function onPreReqSecondTimeout(e:Event):void
        {
            asyncTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, listener);
            traceOut("onPreReqSecondTimeout called!");
        }

        //this is executed AFTER all the tests
        override protected function cleanUp():void
        {
            traceOut("cleanUp called!");
            listener = addAsync(onCleanUpFirstTimeout);
            asyncTimer.addEventListener(TimerEvent.TIMER_COMPLETE, listener);
            asyncTimer.start();
        }
        private function onCleanUpFirstTimeout(e:Event):void
        {
            asyncTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, listener);
            traceOut("onCleanUpFirstTimeout called!");
            listener = addAsync(onCleanUpSecondTimeout);
            asyncTimer.addEventListener(TimerEvent.TIMER_COMPLETE, listener);
            asyncTimer.start();
        }
        private function onCleanUpSecondTimeout(e:Event):void
        {
            asyncTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, listener);
            traceOut("onCleanUpSecondTimeout called!");
        }

        //series of simple tests to check the correct sequence of calls
        public function testFirstTest():void
        {
            traceOut("testFirstTest");
            assertTrue(true);
        }
        public function testSecondTest():void
        {
            traceOut("testSecondTest");
            assertTrue(true);
        }
        public function testThirdTest():void
        {
            traceOut("testThird");
            assertTrue(true);
        }
    }
}
