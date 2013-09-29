package com.shen.core.geom {
	
	public class Size {
		
		private var _width:Number;
		private var _height:Number;
		
		public function Size(width:Number = 0, height:Number = 0) {
			_width = width;
			_height = height;
		}
		
		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
		}

	}
}