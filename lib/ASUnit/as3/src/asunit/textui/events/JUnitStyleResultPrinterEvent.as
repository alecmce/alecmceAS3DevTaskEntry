package asunit.textui.events {
    import flash.events.Event;

    public class JUnitStyleResultPrinterEvent extends Event
    {
        public static const PRINTING_COMPLETE:String = "PRINTING_COMPLETE";

        private var xmlString_:String;

        public function JUnitStyleResultPrinterEvent(type:String, xmlString:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            xmlString_ = xmlString;
        }

        public function get xmlString():String
        {
            return xmlString_;
        }
    }
}
