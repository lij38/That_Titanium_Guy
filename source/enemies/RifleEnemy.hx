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
import haxe.CallStack;

class RifleEnemy extends Enemy {
	
	private var bulletCount:Int = 0;
	private var fireTimer:Float = -1;
	private var fireTime:Float = 2.0;
	private var rate:Float = 0.1;
	
	private var level:Int;
	private var damageLevel = [for (i in 1...4) i];	
	private var healthLevel = [for (i in 1...4) 50 * i];
	
	public function new(X:Float = 0, Y:Float = 0, 
						bulletArray:FlxTypedGroup<EnemyBullet>,
						gravity:Float, level:Int = 0) {
		super(X, Y, bulletArray, gravity, RIFLE);
		this.level = level;
		
		loadGraphic(AssetPaths.enemy_rifle__png, true, 552, 383);
		scale.set(0.35, 0.35);
		setSize(35, 120);
		offset.set(260, 125);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [6], 1, false);
		animation.add("lr", [0, 1, 2, 3, 4, 5], 9, false);
		animation.add("hurt", [8, 8, 8, 8, 6], 12, false);
		animation.add("die", [8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10], 9, false);
		animation.play("stop");
		
		health = healthLevel[level];
		facing = FlxObject.LEFT;
		brain = new EnemyFSM(idle);
		range = 500;
	}
	
	public function idle(elapsed:Float):Void {
		if (seesPlayer) {
			brain.activeState = attack;
		}
	}
	
	public function attack(elapsed:Float):Void {
		if (fireTimer >= 0) {
			fireTimer += elapsed;
		}
		if (fireTimer > fireTime) {
			fireTimer = -1;
			bulletCount = 0;
		}
		if (fireTimer == -1) {
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
			if (fireTimer < 0) {
				fireTimer = 0;
			}
			animation.play("stop");
		} else if (fireTimer < 0) {
			animation.play("lr");
		}
		
		if (bulletCount < 3 && fireTimer > rate * bulletCount) {
			bulletCount++;
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet, true);
			curBullet.setBullet(x, y + 45, 250, facing, 
							damageLevel[level], range,
							Ranged);
		}
	}
	
	private function playerInRange():Bool {
		return Math.abs(playerPos.x - getMidpoint().x) < range;
	}
	
}
