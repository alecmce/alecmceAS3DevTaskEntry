package asunit.textui {
    import asunit.framework.TestResult;

    public class XMLResultPrinter extends DictionaryResultPrinter {

/*
<testsuites>
  <testsuite name="Flash Profile Card AsUnit Test Suite" errors="1" failures="1" tests="8" time="8.002">
    <testcase classname="lib.test.cases.FailureTest" name="testError" time="0.049">
      <error type="java.lang.NullPointerException">
          <!-- stack trace -->
      </error>
      <failure type="Error">Reference runtime test error</failure>
    </testcase>
    <testcase classname="lib.test.cases.FailureTest" name="testAssertion">
      <failure type="AssertionFailedError">Reference assertion test failure</failure>
    </testcase>
  </testsuite>
</testsuites>
*/
        override public function printResult(result:TestResult, runTime:Number):void {
            super.printResult(result, runTime);

/*
            if(result.errorCount()) {
                var error:TestFailure;
                for each(error in result.errors()) {
                    results[error.failedTest().getName()].addFailure(error);
                }
            }
            if(result.failureCount()) {
                var failure:TestFailure;
                for each(failure in result.failures()) {
                    results[failure.failedTest().getName()].addFailure(failure);
                }
            }
*/
            trace("<XMLResultPrinter>");
            trace("<?xml version='1.0' encoding='UTF-8'?>");
            trace("<testsuites>");
            trace("<testsuite name='AllTests' errors='" + result.errorCount() + "' failures='" + result.failureCount() + "' tests='" + result.runCount() + "' time='" + elapsedTimeAsString(runTime) + "'>");
            var xmlTestResult:XMLTestResult;
            for each(xmlTestResult in results) {
                trace(xmlTestResult.toString());
            }
            trace("</testsuite>");
            trace("</testsuites>");
            trace("</XMLResultPrinter>");
        }

    }
}
