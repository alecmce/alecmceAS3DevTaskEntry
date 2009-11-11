/*
	The MIT License

	Copyright (c) 2009 Alec McEachran

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
*/

package  
{
	import flash.display.DisplayObject;

	/**
	 * The GridSquare is an internal class used by the ProximityManager to act as a bucket
	 * into which DisplayObjects in a certain locus of positions are put.
	 * 
	 * The GridSquare also contains an array of other GridSquares to which it is adjacent.
	 * The neighbours are defined by the ProximityManager when it generates the grid
	 * 
	 * @author Alec McEachran
	 */
	final internal class GridSquare 
	{
		/** the x-position for debugging */
		private var _x:int;
		
		/** the y-position, for debugging */
		private var _y:int;
		
		/** the array of display objects that are contained within this GridSquare */
		public var members:Vector.<DisplayObject>;
		
		/** the top-index of the members array */
		private var memberIndex:int;
		
		/** the array of GridSquares that lie adjacent to this GridSquare */
		public var neighbours:Vector.<GridSquare>;
		
		/** the top-index of the neighbour array */
		private var neighbourIndex:int;
		
		/**
		 * Class Constructor
		 * 
		 * @param x The object's x-position in the grid defined by ProximityManager
		 * @param y The object's y-position in the grid defined by ProximityManager
		 */
		public function GridSquare(x:int, y:int)
		{
			_x = x;
			_y = y;
			
			neighbours = new Vector.<GridSquare>(8);
			neighbourIndex = 0;
			
			members = new Vector.<DisplayObject>();
			memberIndex = 0;
		}
		
		/**
		 * clear the members array
		 */
		public function reset():void
		{
			members.length = 0;
			memberIndex = 0;
		}
		
		/**
		 * add a neighbour reference to an adjacent GridSquare
		 * 
		 * @param gridSquare The adjacent GridSquare to be added as a neighbour
		 */
		public function addNeighbour(gridSquare:GridSquare):void
		{
			neighbours[neighbourIndex++] = gridSquare;
		}
		
		/**
		 * Add a display object as a member
		 * 
		 * @param object The object to be added as a member
		 */
		public function addMember(object:DisplayObject):void
		{
			members[memberIndex++] = object;
		}
		
		/**
		 * @return an array of members of this and of all the neighbours
		 */
		public function getNeighbours():Vector.<DisplayObject>
		{
			var list:Vector.<DisplayObject> = members.concat();
			
			var i:int = neighbourIndex;
			while (i--)
				list = list.concat(neighbours[i].members);
			
			return list;
		}
		
		
		/**
		 * A human-readable string describing this object's position in the grid
		 * 
		 * @param listNeighbours Whether to list all the neighbours of this GridSquare
		 * 
		 * @return A string dsecribing this GridSquare
		 */
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
