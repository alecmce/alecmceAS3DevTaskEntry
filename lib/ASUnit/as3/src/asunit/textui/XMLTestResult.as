package asunit.textui {


    import asunit.framework.Test;
    import asunit.framework.TestFailure;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getTimer;
    import asunit.framework.TestListener;
    import asunit.errors.AssertionFailedError;
    import asunit.framework.TestMethod;
    import flash.utils.Dictionary;

    internal class XMLTestResult implements TestListener {

        private var _duration:Number;
        private var start:Number;
        private var test:Test;
        private var testName:String;
        private var failureHash:Dictionary;
        private var failures:Array;
        private var errorHash:Dictionary;
        private var errors:Array;
        private var methodHash:Dictionary;
        private var methods:Array;

        public function XMLTestResult(test:Test) {
            this.test = test;
            testName = test.getName().split("::").join(".");
            failures = new Array();
            errors = new Array();
            methods = new Array();

            failureHash = new Dictionary();
            errorHash = new Dictionary();
            methodHash = new Dictionary();
        }

        public function startTest(test:Test):void {
            start = getTimer();
        }

        public function run(test:Test):void {
        }

        public function addError(test:Test, t:Error):void {
            var failure:TestFailure = new TestFailure(test, t);
            errors.push(failure);
            errorHash[failure.failedMethod()] = failure;
        }

        public function addFailure(test:Test, t:AssertionFailedError):void {
            var failure:TestFailure = new TestFailure(test, t);
            failures.push(failure);
            failureHash[failure.failedMethod()] = failure;
        }

        public function startTestMethod(test:Test, methodName:String):void {
            var method:TestMethod = new TestMethod(test, methodName);
            methods.push(method);
            methodHash[method.getName()] = method;
        }

        public function endTestMethod(test:Test, methodName:String):void {
            methodHash[methodName].endTest(test);
        }

        public function endTest(test:Test):void {
            _duration = (getTimer() - start) * .001;
        }

        private function errorCount():int {
            return errors.length;
        }

        private function failureCount():int {
            return failures.length;
        }

        private function duration():Number {
            return _duration;
        }

        private function renderSuiteOpener():String {
            return "<testsuite name='" + testName + "' errors='" + errorCount() + "' failures='" + failureCount() + "' tests='" + methods.length + "' time='" + duration() + "'>\n";
        }

        private function renderTestOpener(methodName:String):String {
            return "<testcase classname='" + testName + "' name='" + methodName + "' time='" + methodHash[methodName].duration() + "'>\n";
        }

        private function renderTestBody(method:String):String {
            if(errorHash[method]) {
                return renderError(errorHash[method]);
            }
            else if(failureHash[method]) {
                return renderFailure(failureHash[method]);
            }
            else {
                return "";
            }
        }

        private function renderError(failure:TestFailure):String {
            return "<error type='" + getQualifiedClassName(failure.thrownException()).split("::").join(".") + "'><![CDATA[\n" + failure.thrownException().getStackTrace() + "\n]]></error>\n";
        }

        private function renderFailure(failure:TestFailure):String {
            return "<failure type='" + getQualifiedClassName(failure.thrownException()).split("::").join(".") + "'><![CDATA[\n" + failure.thrownException().getStackTrace() + "\n]]></failure>\n";
        }

        private function renderTestCloser():String {
            return '</testcase>\n';
        }

        private function renderSuiteCloser():String {
            return '</testsuite>\n';
        }

        public function toString():String {
            var str:String = '';
            str += renderSuiteOpener();
            for(var name:String in methodHash) {
                str += renderTestOpener(name);
                str += renderTestBody(name);
                str += renderTestCloser();
            }
            str += renderSuiteCloser();
            return str;
        }
    }


}
