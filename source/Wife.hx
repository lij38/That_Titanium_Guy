package;

import enemies.Enemy;
import enemies.EnemyFSM;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Wife extends Enemy {
	
	private var stopTime:Float = 3;
	private var stopTimer:Float = 0.0;

	public function new(X:Float, Y:Float) {
		super(X, Y, -1, null, null, 1000, WIFE);
		loadGraphic(AssetPaths.wife__png, true, 79, 131);
		scale.set(0.9, 0.9);
		setSize(72, 121);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		facing = FlxObject.RIGHT;
		animation.add("stop", [7], 1, false);
		animation.add("lr", [1, 2, 3, 4, 5, 6], 9, false);
		animation.add("hurt", [9, 9, 9, 9, 9], 6, false);
		animation.play("stop");
		brain = new EnemyFSM(stop);
	}
	
	public function stop(elapsed:Float):Void {
		if (stopTimer < stopTime) {
			stopTimer += elapsed;
			animation.play("stop");
			velocity.x = 0;
		} else {
			stopTimer = 0.0;
			idleTime = Std.random(3) + 3;
			brain.activeState = idle;
			if (facing == FlxObject.LEFT) {
				facing = FlxObject.RIGHT;
			} else {
				facing = FlxObject.LEFT;
			}
		}
	}
	
	public function idle(elapsed:Float):Void {
		if (idleTimer < idleTime) {
			animation.play("lr");
			idleTimer += elapsed;
			if (facing == FlxObject.LEFT) {
				velocity.x = -speed;
			} else {
				velocity.x = speed;
			}
		} else {
			idleTimer = 0.0;
			brain.activeState = stop;
		}
	}
	
	override public function hurt(damage:Float):Void {
		hurtTimer = 0;
		animation.play("hurt");
	}
	
}