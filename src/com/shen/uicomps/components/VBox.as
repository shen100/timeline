package com.shen.uicomps.components
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[Event(name="resize", type="flash.events.Event")]
	public class VBox extends Sprite
	{
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const CENTER:String = "center";
		public static const NONE:String = "none";
		
		private var _spacing:Number = 5;
		private var _alignment:String = NONE;
		private var _width:Number = 0;
		private var _height:Number = 0;
	
		override public function addChild(child:DisplayObject) : DisplayObject {
			super.addChild(child);
			child.addEventListener(Event.RESIZE, onResize);
			draw();
			return child;
		}

		override public function addChildAt(child:DisplayObject, index:int) : DisplayObject {
			super.addChildAt(child, index);
			child.addEventListener(Event.RESIZE, onResize);
			draw();
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			super.removeChild(child);            
			child.removeEventListener(Event.RESIZE, onResize);
			draw();
			return child;
		}
	
		override public function removeChildAt(index:int):DisplayObject {
			var child:DisplayObject = super.removeChildAt(index);
			child.removeEventListener(Event.RESIZE, onResize);
			draw();
			return child;
		}
	
		protected function onResize(event:Event):void {
			invalidate();
		}

		protected function doAlignment():void {
			if(_alignment != NONE)
			{
				for(var i:int = 0; i < numChildren; i++)
				{
					var child:DisplayObject = getChildAt(i);
					if(_alignment == LEFT)
					{
						child.x = 0;
					}
					else if(_alignment == RIGHT)
					{
						child.x = _width - child.width;
					}
					else if(_alignment == CENTER)
					{
						child.x = (_width - child.width) / 2;
					}
				}
			}
		}
	
		public function draw() : void
		{
			_width = 0;
			_height = 0;
			var ypos:Number = 0;
			for(var i:int = 0; i < numChildren; i++)
			{
				var child:DisplayObject = getChildAt(i);
				child.y = ypos;
				ypos += child.height;
				ypos += _spacing;
				_height += child.height;
				_width = Math.max(_width, child.width);
			}
			
			doAlignment();
			_height += _spacing * (numChildren - 1);
		}
		
		/**
		 * Gets / sets the spacing between each sub component.
		 */
		public function set spacing(s:Number):void
		{
			_spacing = s;
			invalidate();
		}
		public function get spacing():Number
		{
			return _spacing;
		}
		
		/**
		 * Gets / sets the horizontal alignment of components in the box.
		 */
		public function set alignment(value:String):void
		{
			_alignment = value;
			invalidate();
		}
		public function get alignment():String
		{
			return _alignment;
		}
		protected function invalidate():void
		{
			//			draw();
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		protected function onInvalidate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}
	
	}
}