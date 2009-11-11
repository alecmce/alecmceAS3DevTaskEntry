package asunit.textui {
    import asunit.framework.TestResult;
    import asunit.textui.events.JUnitStyleResultPrinterEvent;

    public class JUnitStyleResultPrinter extends DictionaryResultPrinter
    {
        private var resultsXML:String;

        override public function printResult(result:TestResult, runTime:Number):void
        {
            super.printResult(result, runTime);

            resultsXML = "";
            resultsXML += "<?xml version='1.0' encoding='UTF-8'?>\n";
            resultsXML += "<testresults>\n";
            resultsXML += "<testsuite name='AllTests' errors='" + result.errorCount() + "' ";
            resultsXML += "failures='" + result.failureCount() + "' ";
            resultsXML += "tests='" + result.runCount() + "' ";
            resultsXML += "time='" + elapsedTimeAsString(runTime) + "'>\n";

            var xmlTestResult:XMLTestResult;
            for each(xmlTestResult in results)
                resultsXML += xmlTestResult.toString();

            resultsXML += "</testsuite>\n";
            resultsXML += "</testresults>\n";

            dispatchEvent(new JUnitStyleResultPrinterEvent(JUnitStyleResultPrinterEvent.PRINTING_COMPLETE, resultsXML));
        }


    }
}
