package 
{
	import asunit.textui.TestRunner;	

	/**
	 * Runs all the tests present in this folder  
	 */
	public class UnitRunner extends TestRunner 
	{
		public function UnitRunner() 
		{
			start(AllTests);
		}
	}
}
