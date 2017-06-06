package animation;

import enemies.Enemy;
import enemies.EnemyFSM;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class WifeAnimation extends FlxSprite {
	public var speed:Float = 200;
	private var GRAVITY:Float;

	public function new(X:Float, Y:Float, gravity:Float) {
		super(X, Y);

		loadGraphic(AssetPaths.wife__png, true, 79, 131);
		scale.set(1.15, 1.15);
		setSize(72, 121);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		facing = FlxObject.RIGHT;
		animation.add("stop", [7], 1, false);
		animation.add("lr", [1, 2, 3, 4, 5, 6], 9, false);
		animation.add("hurt", [9, 9, 9, 9, 9], 6, false);
		animation.play("stop");
		//brain = new EnemyFSM(stop);
	}

	override public function update(elapsed:Float):Void {	
		super.update(elapsed);
	}
	
}