package;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class Arrow extends FlxSprite
{
    public function new(X:Float=0, Y:Float=0) 
	{
	    super(X, Y);
	    loadGraphic(AssetPaths.arrow__png, true, 32, 20);
	}
    
}