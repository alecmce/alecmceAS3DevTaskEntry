package  
{
	import asunit.framework.TestCase;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;	

	/**
	 * (c) 2009 Yomego
	 *
	 * @author Alec McEachran
	 */
	public class ProximityManagerTest extends TestCase
	{
		
		private var bounds:uint;
		
		private var rectangle:Rectangle;
		
		public var proximityManager:ProximityManager;
		
		override protected function setUp():void
		{
			bounds = 35;
			rectangle = new Rectangle(0, 0, 70, 70);
			proximityManager = new ProximityManager(bounds, rectangle);
		}
		
		override protected function tearDown():void
		{
			proximityManager = null;
		}

		public function testConstruction():void
		{
			assertTrue("proximityManager constructs", proximityManager is ProximityManager);
		}
		
		public function testGridSquareLinks():void
		{
			var square:GridSquare = proximityManager.getSquare(1,1);
			var str:String = square.toString(true);
			
			assertTrue("(0,0) is a neighbour of (1,1)", str.indexOf("(0,0)") != -1);			assertTrue("(1,0) is a neighbour of (1,1)", str.indexOf("(1,0)") != -1);			assertTrue("(2,0) is a neighbour of (1,1)", str.indexOf("(2,0)") != -1);			assertTrue("(0,1) is a neighbour of (1,1)", str.indexOf("(0,1)") != -1);			assertTrue("(2,1) is a neighbour of (1,1)", str.indexOf("(2,1)") != -1);			assertTrue("(0,2) is a neighbour of (1,1)", str.indexOf("(0,2)") != -1);			assertTrue("(1,2) is a neighbour of (1,1)", str.indexOf("(1,2)") != -1);			assertTrue("(2,2) is a neighbour of (1,1)", str.indexOf("(2,2)") != -1);		}
		
		public function testOneDisplayObjectIsRetrievable():void
		{
			var sprite:Sprite = new Sprite();
			var vector:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			vector[0] = sprite;
			
			proximityManager.update(vector);
			vector = proximityManager.getNeighbors(sprite);
			
			assertEquals("length of vector is 1", 1, vector.length);
			assertSame("member of vector is sprite", sprite, vector[0]);
		}
		
		public function testImmediateNeighbourIsRetrievable():void
		{
			var a:Sprite = new Sprite();
						var b:Sprite = new Sprite();
			b.x = 5;
			
			var vector:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			vector[0] = a;			vector[1] = b;
			
			proximityManager.update(vector);
			vector = proximityManager.getNeighbors(a);
			
			assertEquals("length of vector is 2", 2, vector.length);
			assertTrue("a is a member of vector", vector.indexOf(a) != -1);			assertTrue("b is a member of vector", vector.indexOf(b) != -1);
		}
		
		
		public function testNearNeighbourIsRetrievable():void
		{
			var a:Sprite = new Sprite();
			
			var b:Sprite = new Sprite();
			b.x = 40;
			
			var vector:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			vector[0] = a;
			vector[1] = b;
			
			proximityManager.update(vector);
			vector = proximityManager.getNeighbors(a);
			
			assertEquals("length of vector is 2", 2, vector.length);
			assertTrue("a is a member of vector", vector.indexOf(a) != -1);
			assertTrue("b is a member of vector", vector.indexOf(b) != -1);
		}
		
		
		public function testDiagonalNeighbourIsRetrievable():void
		{
			var a:Sprite = new Sprite();
			
			var b:Sprite = new Sprite();
			b.x = 40;			b.y = 40;
			
			var vector:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			vector[0] = a;
			vector[1] = b;
			
			proximityManager.update(vector);
			vector = proximityManager.getNeighbors(a);
			
			assertEquals("length of vector is 2", 2, vector.length);
			assertTrue("a is a member of vector", vector.indexOf(a) != -1);
			assertTrue("b is a member of vector", vector.indexOf(b) != -1);
		}
		
	}
}
