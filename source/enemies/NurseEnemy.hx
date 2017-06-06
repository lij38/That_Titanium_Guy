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
import items.Coin;

class NurseEnemy extends Enemy {
	
	private var rate:Float = 0.5;
	private var dashRate:Float = 1.0;
	private var rateTimer:Float = -1;
	private var attacked:Bool = false;
	private var attackCount:Int = 0;
	
	private var dashRange:Float;
	private var needleRange:Float = 70;
	private var longRange:Float = 250;
	
	private var damageLevel = [for (i in 1...10) i];	
	private var healthLevel = [for (i in 0...10) 20 * i + 50];
	
	
	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
						bulletArray:FlxTypedGroup<EnemyBullet>,
						coinsGroup:FlxTypedGroup<Coin>,
						gravity:Float, level:Int = 0) {
		super(X, Y, id, bulletArray, coinsGroup, gravity, NURSE);
		
		this.level = level;
		
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
		
		health = healthLevel[level];
		facing = FlxObject.LEFT;
		brain = new EnemyFSM(idle);
		speed = 500;
		dashRange = detectRange;
		range = longRange;
	}
	
	public function idle(elapsed:Float):Void {
		if (seesPlayer) {
			brain.activeState = judge;
		}
		randomFacing(elapsed);
		animation.play("stop");
		rateTimer = -1;
		attacked = false;
		attackCount = 0;
	}
	
	public function judge(elapsed:Float):Void {
		if (!seesPlayer) {
			velocity.x = 0;
			brain.activeState = idle;
			animation.play("stop");
			return;
		}
		
		range = longRange;
		if (playerInRange()) {
			brain.activeState = attack;
		} else {
			range = dashRange;
			if (playerInRange()) {
				brain.activeState = dashAttack;
			}
		}
	}
	
	public function attack(elapsed:Float):Void {
		if (rateTimer >= 0) {
			rateTimer += elapsed;
		}
		if (rateTimer > rate) {
			rateTimer = -1;
			attacked = false;
			brain.activeState = judge;
			return;
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
			if (rateTimer == -1) {
				rateTimer = 0;
			}
			animation.play("stop");
		} else if (rateTimer < 0) {
			animation.play("lr");
		}
		if (rateTimer > 0.0 && !attacked) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(getMidpoint().x, getMidpoint().y - 30, 100, facing,
							damageLevel[level], range, 
							HEART, this);
			attacked = true;
		}
	}
	
	public function dashAttack(elapsed:Float):Void {
		if (rateTimer >= 0) {
			rateTimer += elapsed;
		}
		if (rateTimer > dashRate) {
			rateTimer = -1;
			attackCount = 0;
			brain.activeState = judge;
			return;
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
		range = needleRange;
		if (playerInRange()) {
			velocity.x = 0;
			if (rateTimer == -1) {
				rateTimer = 0;
			}
			animation.play("stop");
		} else if (rateTimer < 0) {
			animation.play("lr");
		}
		if (rateTimer > attackCount * 0.2) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(getMidpoint().x, getMidpoint().y - 3, 1000, facing,
							damageLevel[level], range, 
							NEEDLE, this);
			attackCount++;
		}
	}
	
	override public function hurt(damage:Float):Void {
		hurts(damage, rateTimer == -1);
	}
}
