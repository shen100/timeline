package com.shen.uicomps.components
{
	import flash.display.Shape;

	public class Rect extends Shape
	{
		public function Rect(width:Number = 100, 
							 height:Number = 100, 
							 color:uint = 0xCCCCCC, 
							 isCenter:Boolean = false)
		{
			this.graphics.beginFill(color);
			if(isCenter) {
				this.graphics.drawRect(- width / 2, - height / 2, width, height);
			}else{
				this.graphics.drawRect(0, 0, width, height);	
			}
			this.graphics.endFill();
		}
	}
}