package enemies;

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

class MeleeEnemy extends Enemy {
	
	private var bulletCount:Int = 0;
	private var rate:Float = 1.0;
	private var rateTimer:Float = -1;
	private var attacked:Bool = false;
	
	
	public function new(X:Float = 0, Y:Float = 0, bulletArray:FlxTypedGroup<Bullet>,
						gravity:Float) {
		super(X, Y, bulletArray, gravity);
		
		loadGraphic(AssetPaths.enemy_melee__png, true, 492, 476);
		scale.set(0.3, 0.3);
		setSize(35, 105);
		offset.set(230, 186);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [6], 1, false);
		animation.add("lr", [0, 1, 2, 3, 4, 5], 9, false);
		animation.add("hurt", [10, 10, 10, 10, 6], 12, false);
		animation.add("die", [10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12], 9, false);
		animation.add("attack", [7, 7, 7, 8, 8, 8, 9, 9, 9], 9, false);
		animation.play("stop");
		
		health = 50;
		facing = FlxObject.LEFT;
		brain = new EnemyFSM(idle);
		range = 90;
	}
	
	public function idle(elapsed:Float):Void {
		if (seesPlayer) {
			brain.activeState = attack;
		}
	}
	
	public function attack(elapsed:Float):Void {
		//trace(rateTimer);
		if (rateTimer >= 0) {
			rateTimer += elapsed;
		}
		if (rateTimer > rate) {
			rateTimer = -1;
			attacked = false;
		}
		if (rateTimer == -1) {
			//trace("turn");
			if (playerPos.x <= getMidpoint().x) {
				velocity.x = -speed;
				facing = FlxObject.LEFT;
			} else {
				facing = FlxObject.RIGHT;
				velocity.x = speed;
			}
		}

		if (playerInRange()) {
			velocity.x = 0;
			shoot(facing, elapsed);
			animation.play("attack");
		} else if (rateTimer < 0) {
			animation.play("lr");
		}
		
	}
	
	private function playerInRange():Bool {
		return Math.abs(playerPos.x - getMidpoint().x) < range;
	}
	
	private function shoot(dir:Int, elapsed:Float):Void {
		if (rateTimer == -1) {
			rateTimer = 0;
		}
		if (rateTimer > 0.33 && !attacked) {
			bulletArray.add(new MeleeBullet(x + 7, y + 10, 4000, dir, 1, range));
			attacked = true;
		}
	}
	
	override public function hurt(damage:Float):Void {
		seesPlayer = true;
		if (health - damage < 0) {
			animation.play("die");
			alive = false;
		} else if (rateTimer == -1) {
			animation.play("hurt");
			hurtTimer = 0;
		}
		health -= damage;
	}
	
}
