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

class TruckEnemyAnimation extends FlxSprite {
	
	public function new(X:Float = 0, Y:Float = 0, gravity:Float) {
		super(X, Y);
		
		loadGraphic(AssetPaths.enemy_truck__png, true, 496, 167);
		//scale.set(0.25, 0.25);
		setSize(270, 128);
		offset.set(112, 30);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [0], 1, false);
		animation.add("lr", [3, 3, 0, 3, 3], 9, false);
		animation.add("hurt", [0], 1, false);
		animation.add("die", [0, 0, 0, 0, 0], 9, false);
		animation.add("attack", [1, 1, 2, 2], 9, false);
		animation.add("moving attack", [4, 4, 5, 5], 9, false);
		animation.play("stop");

	}
	
	override public function update(elapsed:Float):Void {	
		super.update(elapsed);
	}
	
}
