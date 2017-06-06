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
		
		loadGraphic(AssetPaths.enemy_rifle__png, true, 193, 134);
		//scale.set(0.35, 0.35);
		setSize(35, 122);
		offset.set(77, 0);
		scale.set(1.2, 1.2);
		
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
