package animation;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import weapons.*;

class PlayerAnimation extends FlxSprite {
	public var speed:Float = 200;
	private var GRAVITY:Float;

	public function new(?X:Float = 0, ?Y:Float = 0, gravity:Float) {
		super(X, Y);
		GRAVITY = gravity;

		loadGraphic(AssetPaths.player__png, true, 970, 529);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		scale.set(0.4, 0.4);
		
		//addAnimation();
		animation.add("Run", [2, 3, 4, 5, 6, 7, 8, 9], 12, false);
		animation.add("Stop", [1], 1, false);
		
		setSize(31, 80);
		offset.set(460, 220);
		acceleration.y = GRAVITY;
	}
	
	override public function update(elapsed:Float):Void {	
		super.update(elapsed);
	}
}