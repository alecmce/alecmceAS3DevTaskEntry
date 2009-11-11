package asunit.textui {
    import asunit.errors.AssertionFailedError;
    import asunit.framework.Test;
    import asunit.framework.TestListener;
    import asunit.textui.ResultPrinter;

    import flash.utils.Dictionary;

    public class DictionaryResultPrinter extends ResultPrinter
    {
        protected var results:Dictionary;

        public function DictionaryResultPrinter() {
            results = new Dictionary();
        }

        override public function startTest(test:Test):void {
            super.startTest(test);
            var result:TestListener = new XMLTestResult(test);
            results[test.getName()] = result;
            result.startTest(test);
        }

        override public function endTest(test:Test):void {
            super.endTest(test);
            results[test.getName()].endTest(test);
        }

        override public function startTestMethod(test:Test, methodName:String):void {
            super.startTestMethod(test, methodName);
            results[test.getName()].startTestMethod(test, methodName);
        }

        override public function endTestMethod(test:Test, methodName:String):void {
            super.endTestMethod(test, methodName);
            results[test.getName()].endTestMethod(test, methodName);
        }

        override public function addFailure(test:Test, t:AssertionFailedError):void {
            super.addFailure(test, t);
            results[test.getName()].addFailure(test, t);
        }

        override public function addError(test:Test, t:Error):void {
            super.addError(test, t);
            results[test.getName()].addError(test, t);
        }
    }
}
