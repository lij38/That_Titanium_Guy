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
import items.Coin;

class MeleeEnemyAnimation extends FlxSprite {
	
	public function new(X:Float = 0, Y:Float = 0, gravity:Float) {
		super(X, Y);
		
		loadGraphic(AssetPaths.enemy_melee__png, true, 240, 168);
		//scale.set(0.35, 0.35);
		setSize(40, 125);
		offset.set(100, 20);
		scale.set(1.2, 1.2);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [6], 1, false);
		animation.add("lr", [0, 1, 2, 3, 4, 5], 9, false);
		animation.add("hurt", [10, 10, 10, 10, 6], 12, false);
		animation.add("die", [10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12], 9, false);
		animation.add("attack", [7, 7, 7, 8, 8, 8, 9, 9, 9, 6, 6, 6, 6, 6, 6], 9, false);
		animation.play("stop");

		facing = FlxObject.LEFT;
	}

	override public function update(elapsed:Float):Void {	
		super.update(elapsed);
	}
}