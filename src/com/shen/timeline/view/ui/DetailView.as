package com.shen.timeline.view.ui
{
	import caurina.transitions.Tweener;
	
	import com.shen.core.geom.Size;
	import com.shen.timeline.assets.CloseButtonAsset;
	import com.shen.uicomps.components.Button;
	import com.shen.uicomps.components.Label;
	import com.shen.uicomps.components.skin.ButtonSkin;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class DetailView extends Sprite
	{
		public static const CLOSE:String = "close";
		
		private var bg:Sprite;
		private var foreground:Shape;
		private var closeButton:Button;
		private var title:Label;
		private var contentTxt:TextField;
		private var contentMaxWidth:Number = 780;
		private var contentWidth:Number;
		private var box:Sprite;
		private var vScroller:VScroller;
		
		public function DetailView()
		{
			bg = new Sprite();
			bg.graphics.beginFill(0x000000, 0.8);
			bg.graphics.drawRect(0, 0, 1, 1);
			bg.graphics.endFill();
			addChild(bg);
			
			foreground = new Shape();
			foreground.graphics.beginFill(0x000000);
			foreground.graphics.drawRect(0, 0, 1, 1);
			foreground.graphics.endFill();
			addChild(foreground);
			
			bg.alpha = 0;
			Tweener.addTween(bg, {alpha:1, time:0.3, transition:"easeOutCubic"});
			
			closeButton = new Button();
			closeButton.skin = new ButtonSkin(new CloseButtonAsset());
			addChild(closeButton);
			
			vScroller = new VScroller();
			addChild(vScroller);
			box = new Sprite();
			box.graphics.beginFill(0x000000);
			box.graphics.drawRect(0, 0, 1, 1);
			box.graphics.endFill();
			vScroller.addChild(box);
			
			title = new Label();
			title.textSize = 16;
			title.text = "标题";
			box.addChild(title);
			title.textColor = 0xFFFFFF;
			
			contentTxt = new TextField();
			contentTxt.autoSize = TextFieldAutoSize.LEFT;
			contentTxt.multiline = true;
			contentTxt.wordWrap = true;
			var format:TextFormat = new TextFormat();
			format.color = 0xFFFFFF;
			format.size = 13;
			format.leading = 8;
			format.letterSpacing = 1;
			//contentTxt.background = true;
			//contentTxt.backgroundColor = 0x0000FF;
			contentTxt.defaultTextFormat = format;
			box.addChild(contentTxt);
			closeButton.addEventListener(MouseEvent.CLICK, onClick);
			bg.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void {
			var e:Event = new Event(DetailView.CLOSE);
			this.dispatchEvent(e);
		}
		
		public function set data(data:Object):void {
			contentTxt.text = "中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国" +
				"";
			setSize(bg.width, bg.height);
		}
		
		public function setSize(width:Number, height:Number):void {
			bg.width = width;
			bg.height = height;
			closeButton.x = width - closeButton.width;
			var vScrollerWidth:Number;
			if(width > contentMaxWidth + 2 * closeButton.width + 8) {
				vScrollerWidth = contentMaxWidth;
			}else {
				vScrollerWidth = width - 2 * closeButton.width - 8;
			}
			var size:Size = new Size(vScrollerWidth, height - vScroller.y);
			foreground.width = size.width;
			foreground.height = height;
			foreground.x = (width - size.width) / 2;
			title.x = (size.width - title.width) / 2;
			title.y = 20;
			
			contentTxt.x = 30;
			contentTxt.y = 50;
			contentTxt.width = size.width - 60;
			if(contentTxt.text) {
				contentTxt.text = contentTxt.text;
			}
			vScroller.size = size;
			vScroller.x = (width - size.width) / 2;
		}
	}
}

















