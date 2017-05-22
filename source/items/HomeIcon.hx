package items;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flash.events.MouseEvent;

class HomeIcon extends FlxSprite
{
	public var _onclick:Dynamic;

    public function new(X:Float=0, Y:Float=0, ?OnClick:Void->Void) 
	{
	    super(X, Y);
	    loadGraphic(AssetPaths.shield_imageicon__png, false, 65, 65);

	    _onclick = OnClick;

		FlxG.stage.addEventListener(MouseEvent.CLICK, _mouseClick);
	}

	private function _mouseClick(_):Void
	{
		if (pixelsOverlapPoint(FlxG.mouse.getScreenPosition())) {
			if (_onclick) {
				_onclick();
			}
		}
	} 
}