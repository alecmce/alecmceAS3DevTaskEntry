package asunit.framework
{

    public class TestCaseSetUpTearDown extends TestCase
    {

        //Set SHOW_TRACES to true if you want to see the sequence of setUp/test/tearDown
        private const SHOW_TRACES:Boolean = false;

        private function traceOut(message:String):void
        {
            if (SHOW_TRACES)
               trace(message);
        }

        override protected function setUp():void
        {
            traceOut("setUp called!");

        }

        override protected function cleanUp():void
        {
            traceOut("cleanUp called");
        }

        override protected function tearDown():void
        {
            traceOut("tearDown called!");
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
            assertTrue(true);
        }
        public function testThirdTest():void
        {
            traceOut("testThird");
            assertTrue(true);
            assertFalse(false);
            assertTrue(true);

        }
    }
}
