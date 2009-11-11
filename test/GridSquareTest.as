package  
{
	import asunit.framework.TestCase;						

	/**
	 * (c) 2009 Yomego
	 *
	 * @author Alec McEachran
	 */
	public class GridSquareTest extends TestCase 
	{

		public var gridSquare:GridSquare;

		override protected function setUp():void
		{
			gridSquare = new GridSquare(3,1);
		}
		
		override protected function tearDown():void
		{
			gridSquare = null;
		}

		public function testConstruction():void
		{
			assertTrue("gridSquare constructs", gridSquare is GridSquare);
		}
		
	}
}
