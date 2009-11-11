/*
	The MIT License

	Copyright (c) 2009 Mike Chambers

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
	import flash.utils.Dictionary;	

	public class ProximityManager
	{
		private var _gridSize:uint;
		
		private var _inverseGridSize:Number;
		
		private var _bounds:Rectangle;
		
		private var _columns:int;
		
		private var _rows:int;
		
		private var _grid:Vector.<GridSquare>;
		
		private var _gridReference:Dictionary;
		
		public function ProximityManager(gridSize:uint, bounds:Rectangle = null)
		{
			_gridSize = gridSize;
			_inverseGridSize = 1 / _gridSize;
			_bounds = bounds;
			_columns = (_bounds.width * _inverseGridSize) + 1;
			_rows = (_bounds.height * _inverseGridSize) + 1;
			_grid = new Vector.<GridSquare>(_rows * _columns);
			_gridReference = new Dictionary(true);
			
			generateGrid();
		}
		
		/**
		*	Returns all display objects in the current and adjacent grid cells of the
		*	specified display object.
		*/
		public function getNeighbors(displayObject:DisplayObject):Vector.<DisplayObject>
		{
			var square:GridSquare = _gridReference[displayObject];
			return square.getNeighbours();
		}
		
		/**
		*	Specifies a Vector of DisplayObjects that will be used to populate the grid.
		*/
		public function update(objects:Vector.<DisplayObject>):void
		{
			var i:int = objects.length;
			while (i--)
			{
				var object:DisplayObject = objects[i];
				var n:int = (object.x + object.y * _columns) * _inverseGridSize;
				
				_grid[n].addMember(object);
				_gridReference[object] = _grid[n];
			}
		}
		
		
		internal function getSquare(x:int, y:int):GridSquare
		{
			return _grid[y * _columns + x];
		}

		
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
		
		private function linkSquares(a:GridSquare, b:GridSquare):void
		{
			a.addNeighbour(b);
			b.addNeighbour(a);
		}
	}
}

