package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Wife extends FlxSprite {

	public function new(X:Float, Y:Float) {
		super(X, Y);
		loadGraphic(AssetPaths.wife__png, true, 226, 375);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		animation.add("stop", [7], 1, false);
		animation.add("lr", [0, 1, 2, 3, 4, 5, 6], 9, false);
		animation.add("hurt", [8, 9, 9, 9, 9, 9], 6, false);
		animation.play("stop");
		
	}
	
}