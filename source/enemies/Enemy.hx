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
	JPRIFLE;
	JPMELEE;
	JPSHIELD;
	SHIELD;
	MELEE;
	RIFLE;
	TRUCK;
	BOSS;
}

class Enemy extends FlxSprite {
	private var id:Int;
	
	private var bulletArray:FlxTypedGroup<EnemyBullet>;
	private var coinsGroup:FlxTypedGroup<Coin>;
	private var dropCoin:Bool = false;
	private var dropItem:Bool = false;
	private var coinCount:Int = 0;
	public var onPickUpItem:Dynamic->Dynamic->Void;
	
	private var GRAVITY:Float;
	private var brain:EnemyFSM;
	public var speed:Float = 50;
	public var playerPos(default, null):FlxPoint;
	public var seesPlayer:Bool = false;
	public var hurtTime:Float = 0.25;
	private var range:Float;
	private var detectRange:Float = 700;
	private var hurtColorTimer:Float = -1;
	private var originalColor:FlxColor = 0xffffff;
	
	private var hurtTimer:Float = -1;
	public var type:EnemyType;
	
	private var idleTime:Int = Std.random(3) + 3;
	private var idleTimer:Float = 0.0;
	
	public var hasJetpack:Bool = false;
	public var hasShield:Bool = false;
	
	private var bulletSpeedLevel = [for (i in 0...4) 50 * i + 250];
	
	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
						enemiesBulletArray:FlxTypedGroup<EnemyBullet>,
						coinsGroup:FlxTypedGroup<Coin>,
						gravity:Float, type:EnemyType) {
		super(X, Y);
		GRAVITY = gravity;
		bulletArray = enemiesBulletArray;
		this.coinsGroup = coinsGroup;
		this.type = type;
		this.id = id;
		
		if (type == JPMELEE || type == JPRIFLE || type == JPSHIELD) {
			hasJetpack = true;
		}
		if (type == SHIELD || type == JPSHIELD) {
			hasShield = true;
		}
		
		acceleration.y = hasJetpack ? 0 : GRAVITY;
		playerPos = FlxPoint.get();
		
		color = originalColor;
	}
	
	override public function update(elapsed:Float):Void {
		if (!seesPlayer &&
			Math.abs(playerPos.x - getMidpoint().x) < detectRange / 2 &&
			Math.abs(playerPos.y - getMidpoint().y) < detectRange / 2) {
			seesPlayer = true;
		}
		if (seesPlayer &&
			(Math.abs(playerPos.x - getMidpoint().x) > detectRange ||
			Math.abs(playerPos.y - getMidpoint().y) > detectRange)) {
			seesPlayer = false;
		}
		if (!alive) {
			velocity.set(0, 0);
			acceleration.y = GRAVITY;
			super.update(elapsed);
			color = originalColor;
			// spawn coins when die
			if (id != 34 && !dropCoin) {
				if (type == BOSS) {
					var rx:Float = Math.random() * 600 - 75;
					if (coinCount < 50 && rx < 75) {
						var coin:Coin = 
							new Coin(getMidpoint().x + rx, getMidpoint().y + 45, COIN);
						coin.loadCoinGraphic();
						coinsGroup.add(coin);
						coinCount++;
					}
				} else {
					var randP:Int = Std.random(10);
					trace(randP);
					if (randP > 1) {
						var coin:Coin = new Coin(getMidpoint().x, getMidpoint().y, COIN);
						coin.loadCoinGraphic();
						coinsGroup.add(coin);
						dropCoin = true;
					} else {
						var potion:Coin = new Coin(getMidpoint().x, getMidpoint().y, POTION);
						potion.loadPotionGrahpic();
						coinsGroup.add(potion);
						dropCoin = true;
					}
				}
			}
			if (id == 34 && !dropItem) {
				var rifle:Coin = new Coin(getMidpoint().x, getMidpoint().y, OTHER);
				rifle.loadGraphic(AssetPaths.rifle__png);
				rifle.onPickUp = onPickUpItem;
				coinsGroup.add(rifle);
				dropItem = true;
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
		var diffX:Float = playerPos.x - getMidpoint().x;
		var diffY:Float = playerPos.y - getMidpoint().y;
		return Math.abs(diffX) < range &&
				(!hasJetpack || diffY < 15 && diffY > -15);
	}
}