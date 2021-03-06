﻿package doot.model {
	import doot.I18n;
	import doot.ResolveLink;
	import doot.model.encoder.PNGEncoder;
	import doot.net.LoaderFactory;
	import doot.ui.Prompt;
	import doot.view.ButtonClip;
	import doot.view.events.ButtonClipEvent;

	import com.fastframework.core.AS2;
	import com.fastframework.core.SingletonError;
	import com.fastframework.log.FASTLog;
	import com.fastframework.log.ILog;
	import com.fastframework.net.ILoader;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.utils.ByteArray;

	/** 
	 * @author digi3colin
	 */
	public class ActionLogger implements ILog{
		private static var ins : ActionLogger;
		public static const URL_BUG : String = "URL_BUG";

		public static function instance():ActionLogger {
			return ins || new ActionLogger();
		}

		public function ActionLogger() {
			if(ins!=null)throw new SingletonError(this);
			ins = this;

			base = FASTLog.instance();

			ldSaveScreenCaptureImage = LoaderFactory.instance().getXMLLoader();
			ldSaveScreenCaptureImage.when(Event.COMPLETE, onScreenCaptureUpload);

			ldSaveMessage = LoaderFactory.instance().getXMLLoader();
			ldSaveMessage.when(Event.COMPLETE, onBugSubmitted);
		}

		private var txt:TextField;
		private var mcRoot:Sprite;
		private var ldSaveScreenCaptureImage:ILoader;
		private var ldSaveMessage:ILoader;
		private var btn:ButtonClip;
		
		private var base:FASTLog;

		public function setTextField(txt:TextField):void{
			this.txt = txt;
		}

		public function setRootSprite(mc:Sprite):void{
			this.mcRoot = mc;
		}

		public function log(str:String,debugLevel:int=0):void{
			txt.appendText(str+'\n');
		}

		public function addGlobalError(loaderInfo:*) : void {
			base.addGlobalError(loaderInfo);
		}

		private var screencap:BitmapData;
		public function submit(...e):void{
			screencap = new BitmapData(500,300,false,0);
			screencap.draw(this.mcRoot, new Matrix(0.5,0,0,0.5));

			Prompt.instance().popup(I18n.t("Bug report."), I18n.t("The following user activity will be submitted.")+"\n"+txt.text, cancel, doSubmit, true);
		}
		
		private function cancel():void{
			//do nothing.
		}
		
		private function doSubmit():void{
			mcBtn.visible = false;

			var data:ByteArray = PNGEncoder.encode(screencap);
			ldSaveScreenCaptureImage.sendBinaryAndLoad(ResolveLink.instance().create(I18n.t(ActionLogger.URL_BUG)+'/saveScreenshot'), data);		
		}
		
		private function onScreenCaptureUpload(...e):void{
			var xResult:XML = ldSaveScreenCaptureImage.getContext();
			base.log('ActionLogger.onScreenCaptureUpload:'+xResult['file'],0);

			var urlVariables:URLVariables = new URLVariables();
			urlVariables['details']	= txt.text;
			urlVariables['screenshot']	= xResult['file'];

			ldSaveMessage.sendAndLoad(
				ResolveLink.instance().create(I18n.t(ActionLogger.URL_BUG)+'/submit'),
				urlVariables,
				URLRequestMethod.POST
			);
		}
		
		private function onBugSubmitted(...e):void{
			Prompt.instance().popup("Bug report.", "Thank you for your report. We will address the bug and fix it as soon as possible! You may click the OK button to reload this page.", null, reload, false);
		}

		private function reload():void{
			AS2.instance().getURL("./");
		}

		private var mcBtn:Sprite;
		public function setButton(mc : Sprite) : void {
			btn = new ButtonClip(mcBtn = mc);
			btn.when(ButtonClipEvent.CLICK,	submit);
		}

		public function setLogger(logger : ILog) : void {
			base.setLogger(logger);
		}
	}
}
