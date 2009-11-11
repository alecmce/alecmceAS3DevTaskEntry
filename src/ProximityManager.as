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
	import flash.geom.Rectangle;
	
	
	/**
	 * ProximityManager which attempts to satisfy the criteria of Mike Chambers' competition:
	 * 
	 * @see http://www.mikechambers.com/blog/2009/11/10/actionscript-3-development-task-contest-1/
	 * 
	 * This implementation seeks generates an array of GridSquare objects which each contains a neighbour
	 * list of adjacent squares. A GridSquare's position i in the array is found by: i = x + y * columns
	 * where (x,y) is the 0-based position of the grid on an x-y plane, and columns is the number of columns
	 * in the grid.
	 * 
	 * The neighbours of an object is found by concatenating the member lists of the GridSquare under a displayobject
	 * and the GridSquare's neighbours.
	 * 
	 * @see GridSquare for more details
	 * 
	 * @author Alec McEachran
	 */
	public class ProximityManager
	{
		/** the edge-length of the grid squares */
		private var _gridSize:uint;
		
		/** 1/_gridSize, which is used to avoid division calculations */
		private var _inverseGridSize:Number;
		
		/** the number of columns in the grid */
		private var _columns:int;
		
		/** the number of rows in the grid */
		private var _rows:int;
		
		/** the total number of squares in the grid */
		private var _count:int;
		
		/** an array of grid squares */
		private var _grid:Vector.<GridSquare>;
		
		/**
		 * Class Constructor
		 * 
		 * @param gridSize The size of the edge of the squares into which the rectangular bounds is divided
		 * @param bounds The rectangular bounds of the grid
		 */
		public function ProximityManager(gridSize:uint, bounds:Rectangle)
		{
			_gridSize = gridSize;
			_inverseGridSize = 1 / _gridSize;
			_columns = (bounds.width * _inverseGridSize) + 1;
			_rows = (bounds.height * _inverseGridSize) + 1;
			_count = _columns * _rows;
			_grid = new Vector.<GridSquare>(_count);
			
			generateGrid();
		}
		
		/**
		*	Returns all display objects in the current and adjacent grid cells of the
		*	specified display object.
		*/
		public function getNeighbors(object:DisplayObject):Vector.<DisplayObject>
		{
			var n:int = int(object.x * _inverseGridSize) + _columns * int(object.y * _inverseGridSize);
			var square:GridSquare = _grid[n];
			
			return square.getNeighbours();
		}
		
		/**
		*	Specifies a Vector of DisplayObjects that will be used to populate the grid.
		*/
		public function update(objects:Vector.<DisplayObject>):void
		{
			var i:int = _count;
			while (i--)
				_grid[i].reset();
			
			var i:int = objects.length;
			while (i--)
			{
				var object:DisplayObject = objects[i];
				var n:int = int(object.x * _inverseGridSize) + _columns * int(object.y * _inverseGridSize);
				
				_grid[n].addMember(object);
			}
		}
		
		/**
		 * retrieves a square by its x,y coordinates; used to sanity-test the result of the generateGrid
		 * method, below
		 * 
		 * @param x The horizontal-index of the desired grid square
		 * @param y The vertical-index of the desired grid square
		 * @return The resultant grid square
		 */
		internal function getSquare(x:int, y:int):GridSquare
		{
			return _grid[y * _columns + x];
		}
		
		/**
		 * generate a grid of GridSquare objects which are joined to all other GridSquare objects that
		 * are adjacent to them (including diagonals)
		 */
		private function generateGrid():void
		{
			var g:GridSquare;
			var h:GridSquare;
			var n:int;
			
			var y:int = _rows;
			var notFirstY:Boolean = false;
			while (y--)
			{
				var x:int = _columns;
				var notFirstX:Boolean = false;
				while (x--)
				{
					n = y * _columns + x;
					_grid[n] = g = new GridSquare(x, y);
					
					if (notFirstX && notFirstY)
					{
						h = _grid[n + _columns + 1];
						linkSquares(g, h);
					}
					
					if (notFirstY)
					{
						h = _grid[n + _columns];
						linkSquares(g, h);
						
						if (x > 0)
						{
							h = _grid[n + _columns - 1];
							linkSquares(g, h);
						}
					}
					
					if (notFirstX)
					{
						h = _grid[n + 1];
						linkSquares(g, h);
					}
					
					notFirstX = true;
				}
				
				notFirstY = true;
			}
		}
		
		
		/**
		 * joins two squares together by adding them to each other's neighbour list
		 * 
		 * @param a A GridSquare
		 * @param b A GridSquare
		 */
		private function linkSquares(a:GridSquare, b:GridSquare):void
		{
			a.addNeighbour(b);
			b.addNeighbour(a);
		}
		
	}
}

