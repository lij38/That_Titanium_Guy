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
import items.Coin;

class RifleEnemy extends Enemy {
	
	private var bulletCount:Int = 0;
	private var rateTimer:Float = -1;
	private var rateTime:Float = 2.0;
	private var rate:Float = 0.1;
	
	private var damageLevel = [for (i in 1...10) i];	
	private var healthLevel = [for (i in 0...10) 20 * i + 30];
	
	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
						bulletArray:FlxTypedGroup<EnemyBullet>,
						coinsGroup:FlxTypedGroup<Coin>,
						gravity:Float, level:Int = 0) {
		super(X, Y, id, bulletArray, coinsGroup, gravity, RIFLE);
		this.level = level;
		hurtTime = 0.5;
		
		loadGraphic(AssetPaths.enemy_rifle__png, true, 193, 134);
		setSize(35, 122);
		offset.set(77, 0);
		
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
		range = 400;
	}
	
	public function idle(elapsed:Float):Void {
		if (seesPlayer) {
			brain.activeState = attack;
		}
		randomFacing(elapsed);
		animation.play("stop");
		rateTimer = -1;
		bulletCount = 0;
	}
	
	public function attack(elapsed:Float):Void {
		if (rateTimer >= 0) {
			rateTimer += elapsed;
		}
		if (rateTimer > rateTime) {
			rateTimer = -1;
			bulletCount = 0;
		}
		if (rateTimer == -1) {
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
			if (rateTimer < 0) {
				rateTimer = 0;
			}
			animation.play("stop");
		} else if (rateTimer < 0) {
			animation.play("lr");
		}
		
		if (!isHurting() && bulletCount < 3 && rateTimer > rate * bulletCount) {
			bulletCount++;
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet, true);
			curBullet.setBullet(getMidpoint().x, y + 45, 
							bulletSpeedLevel[level], facing, 
							damageLevel[level], range,
							Ranged, this);
		}
		if (!seesPlayer) {
			velocity.set(0, 0);
			brain.activeState = idle;
		}
	}
	
}
