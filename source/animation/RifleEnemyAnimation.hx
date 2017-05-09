package animation;

import flash.utils.Timer;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import weapons.*;

class RifleEnemyAnimation extends FlxSprite {
	
	public function new(X:Float = 0, Y:Float = 0, gravity:Float) {
		super(X, Y);
		
		loadGraphic(AssetPaths.enemy_rifle__png, true, 552, 383);
		scale.set(0.3, 0.3);
		setSize(35, 105);
		offset.set(260, 133);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [6], 1, false);
		animation.add("lr", [0, 1, 2, 3, 4, 5], 9, false);
		animation.add("hurt", [8, 8, 8, 8, 6], 12, false);
		animation.add("die", [8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10], 9, false);
		animation.play("stop");
		
		facing = FlxObject.LEFT;
	}

	override public function update(elapsed:Float):Void {	
		super.update(elapsed);
	}
	
}