﻿package doot.view {
	final public class NavButtonClip extends FASTEventDispatcher implements IButtonClip{
		public static var FILEPREFIX:String = 'FILEPREFIX';

		public function NavButtonClip(mc:InteractiveObject,navId:String="",targetContainer:String=""){
			var para:Array = n.split("$");
			base = new NavButton(hitArea,
		}

		public function addElement(element : IButtonElement) : IButtonClip {
			base.addElement(element);
		}

		public function select(bln:Boolean=true) : IButtonClip {
			base.select(bln);
		}