package items;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;


class Daze extends FlxSprite {
	

	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		loadGraphic(AssetPaths.daze_sprite__png, true, 80, 50);
		animation.add("spin", [0, 1, 2, 3, 4, 5], 9, true);
		animation.play("spin");
	}
	
}