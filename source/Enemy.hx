package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Enemy extends FlxSprite {
	private var GRAVITY:Float;
	public var speed:Float = 200;
	
	public function new(X:Float=0, Y:Float=0, gravity:Float) {
		super(X, Y);
		GRAVITY = gravity;
		
		loadGraphic(AssetPaths.v__png, true, 552, 381);
		scale.set(0.3, 0.3);
		setSize(47, 109);
		offset.set(240, 130);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [6], 1, false);
		animation.add("lr", [0, 1, 2, 3, 4, 5], 9, false);
		animation.add("hurt", [8, 8, 6], 9, false);
		animation.add("die", [8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10], 9, false);
		animation.play("stop");
		
		acceleration.y = GRAVITY;
		health = 100;
	}
	
	override public function update(elapsed:Float):Void {
		if (health < 0 && animation.finished) {
			kill();
		}
		super.update(elapsed);
	}
	
	override public function hurt(damage:Float):Void {
		if (health - damage < 0) {
			animation.play("die");
			alive = false;
		} else {
			animation.play("hurt");
		}
		health -= damage;
	}
}