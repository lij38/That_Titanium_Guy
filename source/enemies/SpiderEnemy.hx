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

class SpiderEnemy extends Enemy {
	
	private var rate:Float = 1.0;
	private var webRate:Float = 0.5;
	private var rateTimer:Float = -1;
	private var attacked:Bool = false;
	
	private var meleeRange:Float = 130;
	private var webRange:Float = 250;
	
	private var webCD:Float = 5;
	private var webCDTimer:Float = 5;
	
	private var damageLevel = [for (i in 1...10) i];	
	private var healthLevel = [for (i in 0...10) 20 * i + 50];
	
	
	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
						bulletArray:FlxTypedGroup<EnemyBullet>,
						coinsGroup:FlxTypedGroup<Coin>,
						gravity:Float, level:Int = 0) {
		super(X, Y, id, bulletArray, coinsGroup, gravity, SPIDER);
		
		this.level = level;
		
		loadGraphic(AssetPaths.spider__png, true, 266, 175);
		setSize(120, 92);
		offset.set(73, 65);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [0], 1, false);
		animation.add("lr", [0, 1, 2, 3], 9, false);
		animation.add("hurt", [8, 8, 8, 8, 0], 12, false);
		animation.add("die", [8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9], 9, false);
		animation.add("attack", [4, 4, 4, 5, 5, 6, 6, 7, 7], 9, false);
		animation.add("spillWeb", [10], 1, false);
		animation.play("stop");
		
		health = healthLevel[level];
		facing = FlxObject.LEFT;
		brain = new EnemyFSM(idle);
		speed = 200;
		range = webRange;
	}
	
	override public function update(elapsed:Float):Void {
		if (webCDTimer < 5) {
			webCDTimer += elapsed;
		}
		super.update(elapsed);
	}
	
	public function idle(elapsed:Float):Void {
		if (seesPlayer) {
			brain.activeState = judge;
		}
		randomFacing(elapsed);
		animation.play("stop");
		rateTimer = -1;
		attacked = false;
	}
	
	public function judge(elapsed:Float):Void {
		if (!seesPlayer) {
			velocity.set(0, 0);
			brain.activeState = idle;
			animation.play("stop");
			return;
		}
		if (webCDTimer >= 5) {
			range = webRange;
			brain.activeState = webAttack;
		} else {
			range = meleeRange;
			brain.activeState = meleeAttack;
		}
	}
	
	public function webAttack(elapsed:Float):Void {
		if (rateTimer >= 0) {
			rateTimer += elapsed;
		}
		if (rateTimer > webRate) {
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
			animation.play("spillWeb");
		} else if (rateTimer < 0) {
			animation.play("lr");
		}
		if (rateTimer > 0.0 && !attacked) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(getMidpoint().x, getMidpoint().y - 5, 400, facing,
							damageLevel[level], range, 
							WEB, this);
			webCDTimer = 0.0;
			attacked = true;
		}
	}
	
	public function meleeAttack(elapsed:Float):Void {
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
			animation.play("attack");
		} else if (rateTimer < 0) {
			animation.play("lr");
		}
		if (rateTimer > 0.50 && !attacked) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(getMidpoint().x, y + 10, 1000, facing,
							damageLevel[level], range, 
							Melee, this);
			attacked = true;
		}
	}
	
	override public function hurt(damage:Float):Void {
		hurts(damage, rateTimer == -1);
	}
}
