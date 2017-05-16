package;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flash.events.MouseEvent;

class MapIcon extends FlxSprite
{
	public var _onclick:Dynamic;

    public function new(X:Float=0, Y:Float=0, ?OnClick:Void->Void) 
	{
	    super(X, Y);
	    loadGraphic(AssetPaths.map_icon__png, false, 70, 70);

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