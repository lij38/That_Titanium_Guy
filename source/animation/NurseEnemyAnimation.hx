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

class NurseEnemyAnimation extends FlxSprite {
	
	public function new(X:Float = 0, Y:Float = 0, gravity:Float) {
		super(X, Y);
		
		loadGraphic(AssetPaths.nurse__png, true, 196, 132);
		setSize(75, 127);
		offset.set(59, 0);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [0], 1, false);
		animation.add("lr", [1, 2, 3, 4, 5, 6], 9, false);
		animation.add("hurt", [8, 8, 8, 8, 0], 12, false);
		animation.add("die", [9, 9, 10, 10, 10, 10, 10, 10,
								10, 10, 10], 9, false);
		//animation.add("attack", [4, 4, 4, 5, 5, 6, 6, 7, 7], 9, false);
		//animation.add("spillWeb", [10], 1, false);
		animation.play("stop");
	}
	
}
