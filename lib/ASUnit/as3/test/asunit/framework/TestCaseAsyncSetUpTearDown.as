package asunit.framework
{
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class TestCaseAsyncSetUpTearDown extends TestCase
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

        override protected function setUp():void
        {
            traceOut("setUp called!");
            asyncTimer = new Timer(TIMEOUT, 1);
            listener = addAsync(onSetUpFirstTimeout);
            asyncTimer.addEventListener(TimerEvent.TIMER_COMPLETE, listener);
            asyncTimer.start();
        }

        private function onSetUpFirstTimeout(e:Event):void
        {
            asyncTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, listener);
            traceOut("onSetUpFirstTimeout called!");
            listener = addAsync(onSetUpSecondTimeout);
            asyncTimer.addEventListener(TimerEvent.TIMER_COMPLETE, listener);
            asyncTimer.start();
        }

        private function onSetUpSecondTimeout(e:Event):void
        {
            asyncTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, listener);
            traceOut("onSetUpSecondTimeout called!");
        }



        override protected function cleanUp():void
        {
            traceOut("cleanUp called");
        }

        override protected function tearDown():void
        {
            traceOut("tearDown called!");
            listener = addAsync(onTearDownFirstTimeout);
            asyncTimer.addEventListener(TimerEvent.TIMER_COMPLETE, listener);
            asyncTimer.start();
        }
        private function onTearDownFirstTimeout(e:Event):void
        {
            asyncTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, listener);
            traceOut("onTearDownFirstTimeout called!");
            listener = addAsync(onTearDownSecondTimeout);
            asyncTimer.addEventListener(TimerEvent.TIMER_COMPLETE, listener);
            asyncTimer.start();
        }
        private function onTearDownSecondTimeout(e:Event):void
        {
            asyncTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, listener);
            traceOut("onTearDownSecondTimeout called!");
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
