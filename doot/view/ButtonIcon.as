﻿package doot.view {
	import doot.motion.MotionTween;

	import flash.display.DisplayObject;
	import flash.events.Event;


	/**
 * @author colin
 */
	final public class ButtonIcon implements IButtonElement{
		private var motion : MotionTween;
		private var overHProp : Object;
	
			this.overProp    = overProp==null   ?{}:overProp;
			this.normalHProp = normalHProp==null?{}:normalHProp;
			this.normalProp  = normalProp==null ?{}:normalProp;
			
			if(button!=null)button.addElement(this);
		}
	
		public function buttonOver(e : Event) : void {
			motion.startTween(IButtonClip(e.target).getSelect()?overHProp:overProp);
		}
		
		public function buttonOut(e : Event) : void {
			init(IButtonClip(e.target));
		}

		public function buttonDown(e : Event) : void {
		}

		public function buttonReset(e : Event) : void {
			buttonOut(e);
		}

		public function init(btn : IButtonClip) : void {
			motion.startTween(btn.getSelect()?normalHProp:normalProp);			
		}
	}
}