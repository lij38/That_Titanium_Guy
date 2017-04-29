package;

import flixel.FlxState;
import flixel.FlxSprite;

class OpeningState extends FlxState
{
	private var _background_image:FlxSprite;
	override public function create():Void
	{
		super.create();
		_background_image = new FlxSprite(0, 0);
		_background_image.loadGraphic(Path.BG,true,711,400);
		add(_background_image);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}