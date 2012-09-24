﻿package doot.net {
	import com.fastframework.net.ILoadParser;
	import com.fastframework.net.ILoader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;

	/**
		private var bmp:Bitmap;
		public function ParseIMG(target:DisplayObjectContainer){
			bmp = new Bitmap();
		}

		public function toBitmapData():BitmapData{
			return bmp.bitmapData.clone();
		}

		public function onLoad(loader:ILoader):void{
			var ldr:Loader = loader.getContext();
			var bm:BitmapData = new BitmapData(ldr.width,ldr.height,true,0);
			bm.draw(ldr);
			bmp.bitmapData = bm;
			bmp.smoothing = true;
			target.addChild(bmp);
			loader.dispatchEvent(new LoaderEvent(LoaderEvent.READY));
		}

		public function getContext() : * {
			return target;
		}
	}
}