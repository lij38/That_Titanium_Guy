package enemies;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import weapons.*;

class Enemy extends FlxSprite {
	private var bulletArray:FlxTypedGroup<Bullet>;
	
	private var GRAVITY:Float;
	private var brain:EnemyFSM;
	public var speed:Float = 50;
	public var playerPos(default, null):FlxPoint;
	public var seesPlayer:Bool = false;
	public var hurtTime:Float = 0.25;
	private var range:Float;
	private var hurtColorTimer:Float = -1;
	
	private var hurtTimer:Float = -1;
	
	public function new(X:Float = 0, Y:Float = 0, enemiesBulletArray:FlxTypedGroup<Bullet>,
						gravity:Float) {
		super(X, Y);
		GRAVITY = gravity;
		bulletArray = enemiesBulletArray;
		
		acceleration.y = GRAVITY;
		playerPos = FlxPoint.get();
	}
	
/*	public function idle():Void {
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
	}*/
	
	
	
	override public function update(elapsed:Float):Void {
		if (Math.abs(playerPos.x - getMidpoint().x) < 500) {
			seesPlayer = true;
		}
		if (!alive) {
			velocity.set(0, 0);
			super.update(elapsed);
			color = 0xffffff;
			return;
		} else {
			if (hurtTimer >= 0) {
				hurtTimer += elapsed;
			}
			if (hurtTimer > hurtTime) {
				hurtTimer = -1;
			}
			if (isHurting()) {
				velocity.set(0, 0);
			} else {
				brain.update(elapsed);
			}
		}
		if (hurtColorTimer >= 0) {
			hurtColorTimer += elapsed;
		}
		if (hurtColorTimer > hurtTime) {
			hurtColorTimer = -1;
			color = 0xffffff;
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
			hurtTimer = 0;
		}
		health -= damage;
		color = 0xff0000;
		hurtColorTimer = 0.0;
	}
	
	public function isHurting():Bool {
		return hurtTimer > 0 && hurtTimer < hurtTime;
	}
}