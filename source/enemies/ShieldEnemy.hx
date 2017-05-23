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

class ShieldEnemy extends Enemy {
	
	private var rate:Float = 3.0;
	private var rateTimer:Float = -1;
	private var attacked:Bool = false;
	
	private var level:Int;
	private var damageLevel = [for (i in 1...4) i / 2];	
	private var healthLevel = [for (i in 1...4) 50 * i + 20];
	
	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
						bulletArray:FlxTypedGroup<EnemyBullet>,
						coinsGroup:FlxTypedGroup<Coin>,
						gravity:Float, level:Int = 0) {
		super(X, Y, id, bulletArray, coinsGroup, gravity, SHIELD);
		this.level = level;
		
		loadGraphic(AssetPaths.enemy_shield__png, true, 568, 481);
		scale.set(0.35, 0.35);
		setSize(35, 122);
		offset.set(265, 176);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [6], 1, false);
		animation.add("lr", [0, 1, 2, 3, 4, 5], 9, false);
		animation.add("shield", [10, 10, 10, 10, 6], 12, false);
		animation.add("hurt", [11, 11, 11, 11, 6], 12, false);
		animation.add("die", [11, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13], 9, false);
		animation.add("attack", [7, 7, 7, 8, 8, 8, 9, 9, 9], 9, false);
		animation.play("stop");
		
		health = healthLevel[level];
		facing = FlxObject.LEFT;
		brain = new EnemyFSM(idle);
		range = 90;
		originalColor = 0xffcc00;
		color = originalColor;
		
	}
	
	public function idle(elapsed:Float):Void {
		if (seesPlayer) {
			brain.activeState = attack;
		}
		randomFacing(elapsed);
		animation.play("stop");
		rateTimer = -1;
		attacked = false;
	}
	
	public function attack(elapsed:Float):Void {
		if (!seesPlayer) {
			velocity.set(0, 0);
			brain.activeState = idle;
		}
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
			if (rateTimer == -1) {
				rateTimer = 0;
			}
			if (rateTimer <= 1.0) {
				animation.play("attack");
			} else {
				animation.play("stop");
			}
		} else if (rateTimer < 0) {
			animation.play("lr");
		}
		if (rateTimer > 0.66 && !attacked) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(x + 7, y + 10, 1000, facing,
							damageLevel[level], range, 
							Melee);
			attacked = true;
		}
		
	}
	
	override public function hurt(damage:Float):Void {
		seesPlayer = true;
		if (health - damage <= 0) {
			animation.play("die");
			alive = false;
		} else if (rateTimer == -1 || rateTimer > 1) {
			if (damage <= 0) {
				animation.play("shield");
			} else {
				animation.play("hurt");
				color = 0xff0000;
			}
			hurtTimer = 0;
		}
		health -= damage;
		hurtColorTimer = 0.0;
	}
	
}
