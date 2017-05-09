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

class RifleEnemy extends Enemy {
	
	private var bulletCount:Int = 0;
	private var fireTimer:Float = -1;
	private var fireTime:Float = 2.0;
	private var rate:Float = 0.1;
	private var rateTimer:Float = 0;
	
	public function new(X:Float = 0, Y:Float = 0, bulletArray:FlxTypedGroup<Bullet>,
						gravity:Float) {
		super(X, Y, bulletArray, gravity);
		
		loadGraphic(AssetPaths.enemy_rifle__png, true, 552, 383);
		scale.set(0.3, 0.3);
		setSize(35, 105);
		offset.set(260, 133);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [6], 1, false);
		animation.add("lr", [0, 1, 2, 3, 4, 5], 9, false);
		animation.add("hurt", [8, 8, 8, 8, 6], 12, false);
		animation.add("die", [8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10], 9, false);
		animation.play("stop");
		
		health = 100;
		facing = FlxObject.LEFT;
		brain = new EnemyFSM(idle);
		range = 300;
	}
	
	public function idle(elapsed:Float):Void {
		if (seesPlayer) {
			brain.activeState = attack;
		}
	}
	
	public function attack(elapsed:Float):Void {
		if (playerPos.x <= getMidpoint().x) {
			velocity.x = -speed;
			facing = FlxObject.LEFT;
		} else {
			facing = FlxObject.RIGHT;
			velocity.x = speed;
		}
		if (playerInRange()) {
			velocity.x = 0;
			shoot(facing, elapsed);
			animation.play("stop");
		} else {
			animation.play("lr");
			rateTimer = -1;
		}
		
	}
	
	private function playerInRange():Bool {
		return Math.abs(playerPos.x - getMidpoint().x) < range;
	}
	
	private function shoot(dir:Int, elapsed:Float):Void {
		
		if (bulletCount < 3) {
			rateTimer += elapsed;
			if (rateTimer > rate * bulletCount) {
				bulletArray.add(new EnemyBullet(x, y + 45, 250, dir, 5, range));
				bulletCount++;
			}
				
		} else {
			if (fireTimer >= 0) {
				fireTimer += elapsed;
			} else {
				fireTimer = 0.0;
			}
		}
		if (fireTimer > fireTime) {
			fireTimer = -1;
			bulletCount = 0;
			rateTimer = 0;
		}
	}
	
}
