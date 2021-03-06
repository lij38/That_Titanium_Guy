package animation;

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
		loadGraphic(AssetPaths.dialog1__png, false, 720, 145);
	}

	public function dialog2() {
		visible = true;
		loadGraphic(AssetPaths.dialog2__png, false, 720, 145);
	}

	public function dialog3() {
		visible = true;
		loadGraphic(AssetPaths.dialog3__png, false, 720, 145);
	}

	public function dialog4() {
		visible = true;
		loadGraphic(AssetPaths.dialog4__png, false, 720, 145);
	}

	public function dialog5() {
		visible = true;
		loadGraphic(AssetPaths.dialog5__png, false, 720, 145);
	}
    
}