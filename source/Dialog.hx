package;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class Dialog extends FlxSprite
{
    public function new(X:Float=0, Y:Float=0) 
	{
	    super(X, Y);
	    visible = false;
	}

	public function dialog1() {
		visible = true;
		loadGraphic("assets/images/dialog1.png", true, 500, 120);
	}

	

	public function dialog2() {
		visible = true;
		loadGraphic("assets/images/dialog2.png", true, 500, 120);
	}
    
}