package 
{
	import asunit.framework.TestSuite;					

	/**
	 * @author Alec McEachran
	 */
	public class AllTests extends TestSuite
	{

		public function AllTests() 
		{
			addTest(new GridSquareTest());			addTest(new ProximityManagerTest());		}
		
	}
}
