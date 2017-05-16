package;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flash.events.MouseEvent;

class LevelIcon extends FlxSprite
{
	private var _onclick:Dynamic;

    public function new(X:Float=0, Y:Float=0, boss:Bool, locked:Bool, ?OnClick:Void->Void) 
	{
	    super(X, Y);
	    if (boss && !locked) {
	    	loadGraphic(AssetPaths.star_red__png, false, 32, 32);
	    } else if (!boss && !locked) {
	    	loadGraphic(AssetPaths.star_yellow__png, false, 32, 32);
	    } else if (boss && locked) {
	    	loadGraphic(AssetPaths.star_red_lock__png, false, 32, 32);
	    } else if (!boss && locked) {
	    	loadGraphic(AssetPaths.star_yellow_lock__png, false, 32, 32);
	    }

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