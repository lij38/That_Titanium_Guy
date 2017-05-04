package enemies;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Enemy extends FlxSprite {
	private var GRAVITY:Float;
	private var brain:EnemyFSM;
	public var speed:Float = 100;
	public var playerPos(default, null):FlxPoint;
	public var seesPlayer:Bool = false;
	
	public function new(X:Float=0, Y:Float=0, gravity:Float) {
		super(X, Y);
		GRAVITY = gravity;
		
		
		loadGraphic(AssetPaths.v__png, true, 552, 381);
		scale.set(0.3, 0.3);
		setSize(35, 109);
		offset.set(250, 130);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [6], 1, false);
		animation.add("lr", [0, 1, 2, 3, 4, 5], 9, false);
		animation.add("hurt", [8, 8, 8, 8, 6], 12, false);
		animation.add("die", [8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10], 9, false);
		animation.play("stop");
		
		acceleration.y = GRAVITY;
		health = 100;
		playerPos = FlxPoint.get();
		facing = FlxObject.LEFT;
		brain = new EnemyFSM(idle);
	}
	
	public function idle():Void {
		if (seesPlayer) {
			brain.activeState = chase;
		}
	}
	
	public function chase():Void {
		if (playerPos.x <= getMidpoint().x) {
			velocity.x = -speed;
			facing = FlxObject.LEFT;
		} else {
			facing = FlxObject.RIGHT;
			velocity.x = speed;
		}
		animation.play("lr");
	}
	
	override public function update(elapsed:Float):Void {
		//if (health < 0 && animation.finished) {
			//kill();
		//}
		if (!alive) {
			velocity.set(0, 0);
			super.update(elapsed);
			return;
		} else {
			brain.update();
		}
		super.update(elapsed);
	}
	
	override public function hurt(damage:Float):Void {
		seesPlayer = true;
		if (health - damage < 0) {
			animation.play("die");
			alive = false;
		} else {
			animation.play("hurt");
		}
		health -= damage;
	}
}