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

class JetpackMeleeEnemy extends Enemy {
	
	private var rate:Float = 1.66;
	private var rateTimer:Float = -1;
	private var attacked:Bool = false;
	
	private var damageLevel = [for (i in 1...4) i];	
	private var healthLevel = [for (i in 0...4) 20 * i + 30];
	
	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
						bulletArray:FlxTypedGroup<EnemyBullet>,
						coinsGroup:FlxTypedGroup<Coin>,
						gravity:Float, level:Int = 0) {
		super(X, Y, id, bulletArray, coinsGroup, gravity, JPMELEE);
		this.level = level;
		hurtTime = 0.5;
		
		loadGraphic(AssetPaths.jp_enemy_melee__png, true, 598, 460);
		scale.set(0.35, 0.35);
		setSize(35, 120);
		offset.set(280, 165);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [0, 1], 9, true);
		animation.add("lr", [0, 1], 9, true);
		animation.add("hurt", [5, 5, 5, 5, 0], 12, false);
		animation.add("die", [5, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7], 9, false);
		animation.add("attack", [2, 2, 2, 3, 3, 3, 4, 4, 4, 0, 1, 0, 1, 0, 1], 9, false);
		animation.play("stop");
		
		health = healthLevel[level];
		facing = FlxObject.LEFT;
		brain = new EnemyFSM(idle);
		speed = 400;
		range = 100;
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
		if (rateTimer > rate) {
			rateTimer = -1;
			attacked = false;
		}
		if (rateTimer == -1) {
			if (playerPos.x <= getMidpoint().x) {
				facing = FlxObject.LEFT;
			} else if (playerPos.x > getMidpoint().x) {
				facing = FlxObject.RIGHT;
			}
			velocity.set(0, 0);
			if (getMidpoint().y - playerPos.y > 7) {
				velocity.y = -speed;
			} else if (getMidpoint().y - playerPos.y < -7) {
				velocity.y = speed;
			} else if (playerPos.x < getMidpoint().x) {
				velocity.x = -speed;
			} else if (playerPos.x > getMidpoint().x) {
				velocity.x = speed;
			}
		}
		if (playerInRange()) {
			velocity.set(0, 0);
			if (rateTimer == -1) {
				rateTimer = 0;
			}
			animation.play("attack");
		} else if (rateTimer < 0) {
			animation.play("lr");
		}
		if (rateTimer > 0.66 && !attacked) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(x + 7, y + 10, 1000, facing,
							damageLevel[level], range, 
							Melee, this);
			attacked = true;
		}
		
		if (!seesPlayer) {
			velocity.set(0, 0);
			brain.activeState = idle;
			animation.play("stop");
		}
	}
	
	override public function hurt(damage:Float):Void {
		hurts(damage, rateTimer == -1);
	}
	
}
