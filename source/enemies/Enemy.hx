package enemies;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import weapons.*;
import flixel.util.FlxColor;
import items.Coin;

enum EnemyType {
	WIFE;
	JPRIFLE;
	JPMELEE;
	JPSHIELD;
	SHOTGUN;
	SHIELD;
	MELEE;
	RIFLE;
	TRUCK;
	BOSS1;
	BOSS2;
}

class Enemy extends FlxSprite {
	private var id:Int;
	public var name:String = "";

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
	private var level:Int;
	
	private var hurtTimer:Float = -1;
	public var type:EnemyType;
	
	private var idleTime:Int = Std.random(3) + 3;
	private var idleTimer:Float = 0.0;
	
	public var hasJetpack:Bool = false;
	public var hasShield:Bool = false;
	public var isBoss:Bool = false;
	
	private var bulletSpeedLevel = [for (i in 0...4) 50 * i + 250];
	
	private var dazeTime:Float = 1.0;
	private var dazeTimer:Float = -1;
	
	private var knockBackLen:Float = -1;
	private var knockBackSpeed:Float = 1500;
	private var knockBackDir:Int;
	
	// sound
	public var sndHurt1:FlxSound;
	public var sndHurt2:FlxSound;
	public var sndHurt3:FlxSound;
	
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
		
		sndHurt1 = FlxG.sound.load(AssetPaths.hit_monster1__wav);
		sndHurt2 = FlxG.sound.load(AssetPaths.hit_monster2__wav);
		sndHurt3 = FlxG.sound.load(AssetPaths.hit_monster3__wav);
		
		if (type == JPMELEE || type == JPRIFLE || type == JPSHIELD) {
			hasJetpack = true;
		}
		if (type == SHIELD || type == JPSHIELD) {
			hasShield = true;
		}
		if (type == BOSS1 || type == BOSS2) {
			isBoss = true;
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
			if (id == 34 && level == 1 && !dropItem) {
				// drop rifle in level 1
				var rifle:Coin = new Coin(getMidpoint().x, getMidpoint().y, OTHER);
				rifle.loadGraphic(AssetPaths.rifle__png);
				rifle.onPickUp = onPickUpItem;
				coinsGroup.add(rifle);
				dropItem = true;
			} else if (id != 34 && !dropCoin) {
				var lowB:Int = level * 4 + 2;
				var upB:Int = level * 4 + 6;
				if (isBoss) {
					if (type == BOSS2 && !dropItem && coinCount == 51) {
						var shotgun:Coin = new Coin(getMidpoint().x, getMidpoint().y,
														OTHER);
						shotgun.loadGraphic(AssetPaths.shotgun__png);
						// TODO: add onPickUpItem in PlayState
						shotgun.onPickUp = onPickUpItem;
						coinsGroup.add(shotgun);
						dropItem = true;
					}
					var rx:Float = Math.random() * 600 - 75;
					if (coinCount < 51 && rx < 75) {
						var ry:Float = Math.random() * 15 - 7;
						var coin:Coin = 
							new Coin(getMidpoint().x + rx, getMidpoint().y + 45 + ry,
									COIN, lowB, upB);
						coinsGroup.add(coin);
						coinCount++;
					}
				} else if (type == TRUCK) {
					// always drop potion if this is truck enemy
					var potion:Coin = new Coin(getMidpoint().x, getMidpoint().y, POTION);
					coinsGroup.add(potion);
					dropCoin = true;
				} else {
					var randP:Int = Std.random(10);
					if (randP != 1) {
						var coin:Coin = new Coin(getMidpoint().x, getMidpoint().y, 
												COIN, lowB, upB);
						coinsGroup.add(coin);
						dropCoin = true;
					} else {
						var potion:Coin = new Coin(getMidpoint().x, getMidpoint().y, POTION);
						coinsGroup.add(potion);
						dropCoin = true;
					}
				}
			}
			return;
		} else {
			if (knockBackLen >= 0) {
				trace("isKnockBack");
				knockBackLen -= elapsed * knockBackSpeed;
				if (knockBackDir == FlxObject.LEFT) {
					velocity.x = -knockBackSpeed;
				} else {
					velocity.x = knockBackSpeed;
				}
			} else {
				velocity.x = 0;
			}
			
			
			if (dazeTimer >= 0) {
				dazeTimer += elapsed;
			}
			if (dazeTimer > dazeTime) {
				dazeTimer = -1;
			}
			
			if (hurtTimer >= 0) {
				hurtTimer += elapsed;
			}
			if (hurtTimer > hurtTime) {
				hurtTimer = -1;
			}
			if (isKnockBack()) {
				animation.pause();
				trace(velocity.x);
			} else if (isHurting() || isDizzy()) {
				animation.pause();
				velocity.x = 0;
			} else {
				animation.resume();
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
	
	public function startDaze():Void {
		dazeTimer = 0.0;
	}
	
	public function isDizzy():Bool {
		return dazeTimer > 0 && dazeTimer < dazeTime;
	}
	
	override public function hurt(damage:Float):Void {
		hurts(damage, true);
	}
	
	public function hurts(damage:Float, flag:Bool):Void {
		seesPlayer = true;
		if (health - damage <= 0) {
			animation.play("die");
			alive = false;
		} else if (flag) {
			animation.play("hurt");
			hurtTimer = 0;
		}
		health -= damage;
		color = 0xff0000;
		hurtColorTimer = 0.0;
		//hurtSound();
	}
	
	public function hurtShield(damage:Float, flag:Bool):Void {
		seesPlayer = true;
		if (health - damage <= 0) {
			animation.play("die");
			alive = false;
		} else if (flag) {
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
	
	public function knockBack(len:Int, dir:Int):Void {
		trace("Enemy call knockBack");
		if (knockBackLen < 0) {
			knockBackLen = 0.0;
			knockBackDir = dir;
		}
		if (dir != knockBackDir) {
			if (len > knockBackLen) {
				knockBackDir = dir;
				knockBackLen = len - knockBackLen;
			} else {
				knockBackLen -= len;
			}
		} else {
			knockBackLen += len;
		}
	}
	
	public function isKnockBack():Bool {
		return knockBackLen >= 0;
	}
	
	public function playerInRange():Bool {
		var diffX:Float = playerPos.x - getMidpoint().x;
		var diffY:Float = playerPos.y - getMidpoint().y;
		return Math.abs(diffX) < range &&
				(!hasJetpack || diffY < 15 && diffY > -15);
	}
	
	public function hurtSound():Void {
		var rand:Float = Math.random() * 3;
		if (rand < 1) {
			sndHurt1.play(true);
		} else if (rand < 2) {
			sndHurt2.play(true);
		} else {
			sndHurt3.play(true);
		}
	}
}