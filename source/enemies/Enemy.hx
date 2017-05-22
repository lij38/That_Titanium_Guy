package enemies;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import weapons.*;
import flixel.util.FlxColor;
import items.Coin;

enum EnemyType {
	SHIELD;
	MELEE;
	RIFLE;
	TRUCK;
}

class Enemy extends FlxSprite {
	private var bulletArray:FlxTypedGroup<EnemyBullet>;
	private var coinsGroup:FlxTypedGroup<Coin>;
	private var dropCoin:Bool = false;
	
	private var GRAVITY:Float;
	private var brain:EnemyFSM;
	public var speed:Float = 50;
	public var playerPos(default, null):FlxPoint;
	public var seesPlayer:Bool = false;
	public var hurtTime:Float = 0.25;
	private var range:Float;
	private var detectRange:Float = 500;
	private var hurtColorTimer:Float = -1;
	private var originalColor:FlxColor = 0xffffff;
	
	private var hurtTimer:Float = -1;
	public var type:EnemyType;
	
	private var idleTime:Int = Std.random(3) + 3;
	private var idleTimer:Float = 0.0;
	
	public function new(X:Float = 0, Y:Float = 0, 
						enemiesBulletArray:FlxTypedGroup<EnemyBullet>,
						coinsGroup:FlxTypedGroup<Coin>,
						gravity:Float, type:EnemyType) {
		super(X, Y);
		GRAVITY = gravity;
		bulletArray = enemiesBulletArray;
		this.coinsGroup = coinsGroup;
		
		acceleration.y = GRAVITY;
		playerPos = FlxPoint.get();
		
		color = originalColor;
		
		this.type = type;
	}
	
	override public function update(elapsed:Float):Void {
		if (!seesPlayer &&
			Math.abs(playerPos.x - getMidpoint().x) < 350 &&
			Math.abs(playerPos.y - getMidpoint().y) < 50) {
			seesPlayer = true;
		}
		if (seesPlayer &&
			(Math.abs(playerPos.x - getMidpoint().x) > detectRange ||
			Math.abs(playerPos.y - getMidpoint().y) > 300)) {
			seesPlayer = false;
		}
		if (!alive) {
			velocity.set(0, 0);
			super.update(elapsed);
			color = originalColor;
			if (!dropCoin) {
				coinsGroup.add(new Coin(getMidpoint().x, getMidpoint().y));
				dropCoin = true;
			}
			return;
		} else {
			if (hurtTimer >= 0) {
				hurtTimer += elapsed;
			}
			if (hurtTimer > hurtTime) {
				hurtTimer = -1;
			}
			if (isHurting()) {
				velocity.set(0, 0);
			} else {
				brain.update(elapsed);
			}
		}
		if (hurtColorTimer >= 0) {
			hurtColorTimer += elapsed;
		}
		if (hurtColorTimer > hurtTime) {
			hurtColorTimer = -1;
			color = originalColor;
		}
		super.update(elapsed);
	}
	
	override public function hurt(damage:Float):Void {
		seesPlayer = true;
		if (health - damage <= 0) {
			animation.play("die");
			alive = false;
		} else {
			animation.play("hurt");
			hurtTimer = 0;
		}
		health -= damage;
		color = 0xff0000;
		hurtColorTimer = 0.0;
	}
	
	public function isHurting():Bool {
		return hurtTimer > 0 && hurtTimer < hurtTime;
	}
	
	public function randomFacing(elapse:Float):Void {
		if (idleTimer < idleTime) {
			idleTimer += elapse;
		} else {
			if (facing == FlxObject.LEFT) {
				facing = FlxObject.RIGHT;
			} else {
				facing = FlxObject.LEFT;
			}
			idleTimer = 0.0;
			idleTime = Std.random(3) + 3;
		}
	}
	
	public function playerInRange():Bool {
		return Math.abs(playerPos.x - getMidpoint().x) < range;
	}
}