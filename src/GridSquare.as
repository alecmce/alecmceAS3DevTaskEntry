package  
{
	import flash.display.DisplayObject;									

	/**
	 * @author Alec McEachran
	 */
	internal class GridSquare 
	{
		private var _x:int;
		
		private var _y:int;
		
		public var members:Vector.<DisplayObject>;
		
		private var memberIndex:int;

		public var neighbours:Vector.<GridSquare>;
		
		private var neighbourIndex:int;
		
		public function GridSquare(x:int, y:int)
		{
			_x = x;
			_y = y;
			
			neighbours = new Vector.<GridSquare>(8);
			neighbourIndex = 0;
			
			members = new Vector.<DisplayObject>();
			memberIndex = 0;
		}
		
		public function get x():int { return _x; }		
		public function get y():int { return _y; }
		
		public function addNeighbour(gridSquare:GridSquare):void
		{
			neighbours[neighbourIndex++] = gridSquare;
		}
		
		public function addMember(object:DisplayObject):void
		{
			members[memberIndex++] = object;
		}
		
		public function getNeighbours():Vector.<DisplayObject>
		{
			var list:Vector.<DisplayObject> = members.concat();
			
			var i:int = neighbourIndex;
			while (i--)
				list = list.concat(neighbours[i].members);
			
			return list;
		}
		
		public function toString(listNeighbours:Boolean = false):String
		{
			var str:String = "(@X@,@Y@)";
			str = str.replace("@X@", _x);			str = str.replace("@Y@", _y);
			
			if (!listNeighbours)
				return str;
			
			var arr:Array = [];
			var i:int = neighbourIndex;
			while (i--)
				arr[i] = neighbours[i].toString();
				
			str += " -> " + arr.join(",");
			
			return str;
		}
				
	}
}
