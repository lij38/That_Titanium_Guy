package enemies;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Boss2Hand extends FlxSprite {
	//private var brain:EnemyFSM;
	
	public function new(X:Float=0, Y:Float=0) {
		super(X, Y);
		loadGraphic(AssetPaths.hand__png);
		setSize(113, 108);
		offset.set(170, 15);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
	}

	override public function update(elapsed:Float):Void {
		//brain.update(elapsed);
		super.update(elapsed);
	}

	public function chasing(elapsed:Float):Void {

	}
}