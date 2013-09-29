package com.shen.core.util
{
	import com.shen.core.geom.Size;
	
	import flash.external.ExternalInterface;
	
	public class Util {
		
		private static const DAYS_IN_MONTH:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		
		public static function monthHasDays(year:int, month:int):int {
			if(month == 2) {
				if( (year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
					return 29;	
				}
			}
			return DAYS_IN_MONTH[month - 1];
		}
		
		public static function scaleToMax(originalWidth:Number, originalHeight:Number, maxWidth:Number, maxHeight:Number):Size {
			var scale:Number = Math.max(originalWidth / maxWidth, originalHeight / maxHeight);
			var width:Number = originalWidth / scale;
			var height:Number = originalHeight / scale;
			var size:Size = new Size(width, height);
			return size;
		}
		
		public static function scaleToClip(originalWidth:Number, originalHeight:Number, areaWidth:Number, areaHeight:Number):Size {
			var scale:Number = Math.min(originalWidth / areaWidth, originalHeight / areaHeight);
			var width:Number = originalWidth / scale;
			var height:Number = originalHeight / scale;
			var size:Size = new Size(width, height);
			return size;	
		}
		
		public function Util() {
			throw new TypeError("Util 不是构造函数。")
		}
		
	}
}










