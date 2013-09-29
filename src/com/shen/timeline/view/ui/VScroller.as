package com.shen.timeline.view.ui
{

	import com.shen.core.geom.Size;
	import com.shen.timeline.assets.VScrollerThumbAsset;
	import com.shen.uicomps.components.Button;
	import com.shen.uicomps.components.skin.ButtonSkin;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class VScroller extends Sprite {
		
		private var _rightPadding:Number = 0;
		private var step:Number = 30;
		private var _size:Size = new Size(0, 0);
		private var _isScroll:Boolean;
		private var _scrollContent:DisplayObject;
		private var _thumb:Button;
		
		private var thumbTopPadding:Number = 0;
		private var thumbBottomPadding:Number = 0;
		
		private var area:Sprite;
		private var theMask:Sprite;
		
		public function VScroller() {
			theMask = new Sprite();
			theMask.graphics.beginFill(0x000000);
			theMask.graphics.drawRect(0, 0, 1, 1);
			theMask.graphics.endFill();
			
			mask = theMask;
			addChild(theMask);
			
			area = new Sprite();
			area.graphics.beginFill(0x000000);
			area.graphics.drawRect(0, 0, 1, 1);
			area.graphics.endFill();
			addChild(area);
			
			_thumb = new Button();
			_thumb.x = thumbTopPadding;
			_thumb.skin = new ButtonSkin(new VScrollerThumbAsset());
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbMouseDown);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function onMouseWheel(event:MouseEvent):void {
			if(_isScroll) {
				_scrollContent.y += (event.delta * step);
				if(_scrollContent.y > 0) {
					_scrollContent.y = 0;	
				}else if(_scrollContent.y < - (_scrollContent.height - _size.height) ) {
					_scrollContent.y = - (_scrollContent.height - _size.height);	
				}
				var ratio:Number = - _scrollContent.y / (_scrollContent.height - _size.height);
				_thumb.y = ratio * (_size.height - thumbTopPadding - thumbBottomPadding - _thumb.height) + thumbTopPadding;
			}
		}
		
		private function onThumbMouseDown(event:MouseEvent):void {
			var bounds:Rectangle = new Rectangle(_thumb.x, thumbTopPadding, 0, _size.height - thumbTopPadding - thumbBottomPadding - _thumb.height);
			_thumb.startDrag(false, bounds);
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			addEventListener(Event.ENTER_FRAME, onStageEnterFrame);
		}
		
		private function onStageEnterFrame(event:Event):void {
			var percent:Number = (_thumb.y - thumbTopPadding) / (_size.height - thumbTopPadding - thumbBottomPadding - _thumb.height);
			_scrollContent.y = - percent * (_scrollContent.height - _size.height);
		}
		
		private function onStageMouseUp(event:MouseEvent):void {
			_thumb.stopDrag();
			removeEventListener(Event.ENTER_FRAME, onStageEnterFrame);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			var percent:Number = (_thumb.y - thumbTopPadding) / (_size.height - thumbTopPadding - thumbBottomPadding - _thumb.height);
			_scrollContent.y = - percent * (_scrollContent.height - _size.height);
			event.updateAfterEvent();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			if(child != _thumb && child != theMask && child != area) {
				if(_scrollContent) {
					throw new Error("VScroller 已经有 child了!");	
				}else {
					_scrollContent = child;
					size = _size;
				}
			}
			return super.addChild(child);
		}
		
		private function draw():void {
			_isScroll = false;
			if(_scrollContent) {
				//(_scrollContent as Object).minSize = _size;
//				if(_size.height < _scrollContent.height) {
//					addChild(_thumb);
//					_isScroll = true;
//					var ratio:Number = - _scrollContent.y / (_scrollContent.height - _size.height);
//					_thumb.height = _size.height / (_scrollContent.height / _size.height);
//					_thumb.x = _size.width - _thumb.width - _rightPadding;
//					_thumb.y = ratio * (_size.height - thumbTopPadding - thumbBottomPadding - _thumb.height) + thumbTopPadding;
//				}else {
//					if(contains(_thumb)) {
//						removeChild(_thumb);	
//					}
//					_thumb.y = thumbTopPadding;
//				}
				
				if(_size.height < _scrollContent.height) {
					addChild(_thumb);
					_isScroll = true;
					_scrollContent.y = 0;
					_thumb.height = _size.height / (_scrollContent.height / _size.height);
					_thumb.x = _size.width - _thumb.width - _rightPadding;
					_thumb.y = thumbTopPadding;
				}else {
					if(contains(_thumb)) {
						removeChild(_thumb);	
					}
					_thumb.y = thumbTopPadding;
				}
			}
		}
		
		public function set size(size:Size):void {
			_size = size;
			theMask.width = size.width;
			theMask.height = size.height;
			area.width = size.width;
			area.height = size.height;
			draw();
		}
	}
}