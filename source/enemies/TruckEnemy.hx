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

class TruckEnemy extends Enemy {
	
	private var bulletCount:Int = 0;
	private var rateTimer:Float = -1;
	private var rateTime:Float = 1.5;
	private var rate:Float = 0.1;
	
	private var level:Int;
	private var damageLevel = [for (i in 1...4) i];	
	private var healthLevel = [for (i in 1...4) 50 * i + 40];
	
	
	public function new(X:Float = 0, Y:Float = 0, 
						bulletArray:FlxTypedGroup<EnemyBullet>,
						gravity:Float, level:Int = 0) {
		super(X, Y, bulletArray, gravity, TRUCK);
		
		this.level = level;
		
		loadGraphic(AssetPaths.enemy_truck__png, true, 1980, 667);
		scale.set(0.25, 0.25);
		setSize(270, 133);
		offset.set(865, 282);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [0], 1, false);
		animation.add("lr", [3, 3, 0, 3, 3], 9, false);
		animation.add("hurt", [0], 1, false);
		animation.add("die", [0, 0, 0, 0, 0], 9, false);
		animation.add("attack", [1, 1, 2, 2], 9, false);
		animation.add("moving attack", [4, 4, 5, 5], 9, false);
		animation.play("stop");
		
		health = healthLevel[level];
		facing = FlxObject.LEFT;
		brain = new EnemyFSM(idle);
		range = 550;
		speed = 200;
		detectRange = 800;
	}
	
	public function idle(elapsed:Float):Void {
		if (seesPlayer) {
			brain.activeState = attack;
		}
		velocity.set(0, 0);
		animation.play("stop");
		rateTimer = -1;
		bulletCount = 0;
	}
	
	public function attack(elapsed:Float):Void {
		if (!seesPlayer) {
			brain.activeState = idle;
		}
		if (rateTimer >= 0) {
			rateTimer += elapsed;
		}
		if (rateTimer > rateTime) {
			rateTimer = -1;
			bulletCount = 0;
		}
		//if (rateTimer < 0) {
			if (playerPos.x <= getMidpoint().x) {
				velocity.x = -speed;
				facing = FlxObject.LEFT;
			} else {
				facing = FlxObject.RIGHT;
				velocity.x = speed;
			}
		//}
		if (playerInRange()) {
			velocity.x = 0;
			if (playerTooClose()) {
				if (playerPos.x <= getMidpoint().x) {
					velocity.x = speed / 1.66;
				} else {
					velocity.x = -speed / 1.66;
				}
			}
			if (rateTimer < 0) {
				rateTimer = 0;
			}
		}
		
		if (rateTimer >= 0) {
			if (velocity.x == 0 && rateTimer < rate * 3) {
				animation.play("attack");
			} else if (rateTimer < rate * 3) {
				animation.play("moving attack");
			} else if (velocity.x != 0) {
				animation.play("lr");
			} else {
				animation.play("stop");
			}
		} else {
			if (velocity.x == 0) {
				animation.play("stop");
			} else {
				animation.play("lr");
			}
		}
			
		
		if (!isHurting() && bulletCount < 3 && rateTimer > rate * bulletCount) {
			bulletCount++;
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet, true);
			curBullet.setBullet(getMidpoint().x, y + 42, 250, facing, 
							/*damageLevel[level]*/0 , range,
							Ranged);
			
		}
	}
	
	// return whether player is too close
	private function playerTooClose():Bool {
		return Math.abs(playerPos.x - getMidpoint().x) < 400;
	}
	
}
