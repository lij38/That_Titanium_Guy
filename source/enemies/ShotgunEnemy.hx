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

class ShotgunEnemy extends Enemy {
	
	private var rateTimer:Float = -1;
	private var rateTime:Float = 2.0;
	private var attacked:Bool = false;
	
	private var damageLevel = [for (i in 1...10) i];	
	private var healthLevel = [for (i in 0...10) 20 * i + 30];
	
	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
						bulletArray:FlxTypedGroup<EnemyBullet>,
						coinsGroup:FlxTypedGroup<Coin>,
						gravity:Float, level:Int = 0) {
		super(X, Y, id, bulletArray, coinsGroup, gravity, SHOTGUN);
		this.level = level;
		hurtTime = 0.5;
		
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
		range = 200;
		originalColor = 0xe067cc;
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
		if (rateTimer >= 0) {
			rateTimer += elapsed;
		}
		if (rateTimer > rateTime) {
			rateTimer = -1;
			attacked = false;
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
		
		if (rateTimer >= 0 && !attacked) {
			var angle:Int = 345;
			if (facing == FlxObject.LEFT) {
				angle = 165;
			}
			for (i in 0...5) {
				var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
				curBullet.setBullet(getMidpoint().x, y + 45,
								bulletSpeedLevel[level], angle % 360,
								damageLevel[level], range, SHOTGUN, this);
				angle += 6;
			}
			attacked = true;
		}
		
		if (!seesPlayer) {
			velocity.set(0, 0);
			brain.activeState = idle;
		}
	}
	
}
