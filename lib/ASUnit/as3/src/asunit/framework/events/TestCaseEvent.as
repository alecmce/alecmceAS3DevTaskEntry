package asunit.framework.events
{
    import flash.events.Event;

    /**
     * (c) Yomego 2009
     * @author simone
     */
    public class TestCaseEvent extends Event
    {
        public static const TESTS_COMPLETE:String = "RUNNING_TESTS_COMPLETE";
        public function TestCaseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
        }
    }
}
