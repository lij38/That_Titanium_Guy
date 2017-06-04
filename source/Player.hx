package;

import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.input.keyboard.FlxKey;
import weapons.*;
import haxe.CallStack;

class Player extends FlxSprite {
	public var speed:Float = 250;
	private var GRAVITY:Float;
	private var jumped:Bool = false;
	private var jump:Float = -1;
	public var faced:Int = FlxObject.RIGHT;
	private var numJump:Int = 0;
	public var numJumpLimit:Int = 2;
	
	private var tumbleTimer:Float = -1;
	private var TumbleTime:Float = 0.3;
	
	private var bulletArray:FlxTypedGroup<Bullet>;
	
	public var money:Int;
	public var maxHealth:Float;
	public var potionCount:Int;
	public var potionSlot:Bool;

	//controls
	private var jumpControl:Array<FlxKey>;
	private var rollControl:Array<FlxKey>;

	public var jetpackFieldMax:Float;
	public var jetpackField:Float;
	
	private var jWeapon:Weapon;
	private var kWeapon:Weapon;
	private var j2ndWeapon:Weapon;
	private var k2ndWeapon:Weapon;
	private var shielding:Bool;
	private var swordNum:Int = 2;
	private var swordTime:Float = 0.25;
	private var swordTimer:Float = -1;
	private var curConfig:String;
	private var dmgTaken:Float;
	private var jetpack:Bool = false;
	private var jrvTimer:Float = -1;
	private var krvTimer:Float = -1;
	
	// sound
	public var sndRifleReload:FlxSound;
	public var sndHurt1:FlxSound;
	public var sndHurt2:FlxSound;
	public var sndHurt3:FlxSound;
	public var sndShield:FlxSound;
	private var sndPotion:FlxSound;
	private var sndJump:FlxSound;
	private var sndRoll:FlxSound;
	private var sndLand:FlxSound;
	private var midAir:Bool;
	private var sndJetpack:FlxSound;

	public var freeze:Bool;

	public function new(?X:Float = 0, ?Y:Float = 0,
						playerBulletArray:FlxTypedGroup<Bullet>,
						gravity:Float) {
		super(X, Y);
		drag.x = 1600;
		GRAVITY = gravity;
		if(Main.SAVE.data.maxHealth == null) {
			health = 100;
			Main.SAVE.data.maxHealth = health;
		} else {
			health = Main.SAVE.data.maxHealth;
		}
		if(Main.SAVE.data.maxFuel == null) {
			jetpackFieldMax = 3;
			jetpackField = 3;
			Main.SAVE.data.maxFuel = jetpackFieldMax;
		} else {
			jetpackFieldMax = Main.SAVE.data.maxFuel;
			jetpackField = jetpackFieldMax;
		}
		//potions
		if(Main.SAVE.data.potionCount == null || Main.SAVE.data.potionCount == 0) {
			potionCount = 0;
			potionSlot = false;
			Main.SAVE.data.potionCount = 0;
		} else {
			potionSlot = true;
			potionCount = Main.SAVE.data.potionCount;
		}
		dmgTaken = 0.0;

		//controls
		if(Main.SAVE.data.jump == null) {
			jumpControl = [SPACE];
			rollControl = [S];
		} else {
			jumpControl = Main.SAVE.data.jump;
			rollControl = Main.SAVE.data.roll;
		}
		loadGraphic(AssetPaths.player__png, true, 334, 182);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		//scale.set(0.35, 0.35);
		
		addAnimation();
		loadSound();
		
		setSize(48, 112);
		offset.set(142, 28);
		acceleration.y = GRAVITY;
		
		bulletArray = playerBulletArray;
		if(Main.SAVE.data.levelCompleted == null || Main.SAVE.data.levelCompleted < 1) {
			jWeapon = new Sword(playerBulletArray);
			j2ndWeapon = new Sword(playerBulletArray);
			kWeapon = new Weapon(playerBulletArray);
			k2ndWeapon = new Weapon(playerBulletArray);
			curConfig = "sword";
			Main.SAVE.data.jWeapon = jWeapon.getName();
			Main.SAVE.data.j2ndWeapon = j2ndWeapon.getName();
			Main.SAVE.data.kWeapon = kWeapon.getName();
			Main.SAVE.data.k2ndWeapon = k2ndWeapon.getName();
			Main.SAVE.data.curConfig = curConfig;
			if (Main.SAVE.data.money == null) {
				money = 0;
			}
			//Main.SAVE.flush();
		} else {
			var jn:String = Main.SAVE.data.jWeapon;
			var j2n:String = Main.SAVE.data.j2ndWeapon;
			var kn:String = Main.SAVE.data.kWeapon;
			var k2n:String = Main.SAVE.data.k2ndWeapon;
			jWeapon = WeaponFactory.getWeapon(jn, playerBulletArray);
			j2ndWeapon = WeaponFactory.getWeapon(j2n, playerBulletArray);
			kWeapon = WeaponFactory.getWeapon(kn, playerBulletArray);
			k2ndWeapon = WeaponFactory.getWeapon(k2n, playerBulletArray);
			curConfig = Main.SAVE.data.curConfig;
			money = Main.SAVE.data.money;
			//trace(curConfig);
		}
		maxHealth = health;
		shielding = false;
		sndPotion = FlxG.sound.load(AssetPaths.potion__wav);

		midAir = false;
		freeze = false;
	}
	
	override public function update(elapsed:Float):Void {
		if (freeze) {
			animation.play("Stop");
			return;
		}

		if(swordTimer > -1) {
			swordTimer += elapsed;
		}
		if(swordTimer > swordTime) {
			swordTimer = -1;
		}
		jWeapon.update(elapsed);
		kWeapon.update(elapsed);
		j2ndWeapon.update(elapsed);
		k2ndWeapon.update(elapsed);
		movement(elapsed);			
		super.update(elapsed);
	}
	
	private function movement(elapsed:Float):Void {		
		//var jumpKey:Bool = false;
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		var doubleJump:Bool = false;
		jetpack = false;
		var roll:Bool = false;
		
		//change weapon configuration
		if(FlxG.keys.anyJustPressed([Q])) {
			Main.LOGGER.logLevelAction(0);
			changeWeaponConfig();
		}

		//unshield if shielding
		if(kWeapon.getName() == "shield") {
			if(FlxG.keys.anyJustReleased([K])) {
				if(shielding) {
					shielding = false;
					//trace("unshielded");
				}
			}
		} else if(jWeapon.getName() == "shield") {
			if(FlxG.keys.anyJustReleased([J])) {
				if(shielding) {
					shielding = false;
					//trace("unshielded");
				}
			}
		}

		if(FlxG.keys.anyPressed([R])) {
			jWeapon.reload();
			kWeapon.reload();
		}

		if (!isSwording() && !isTumbling()) {
			tumbleTimer = -1;
			up = FlxG.keys.anyPressed([W]);
			//jumpKey = FlxG.keys.anyPressed([SPACE]);
			left = FlxG.keys.anyPressed([A]);
			right = FlxG.keys.anyPressed([D]);
			down = FlxG.keys.anyPressed([S]);
			doubleJump = FlxG.keys.anyJustPressed(jumpControl);
			
			jetpack = FlxG.keys.anyPressed([SHIFT]);
			
			roll = FlxG.keys.anyJustPressed(rollControl);
		} else if (isTumbling()){
			tumble(FlxObject.NONE, elapsed);
		} else if (isSwording()) {
			jetpack = FlxG.keys.anyPressed([SHIFT]);
		}
		
		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;
		
		// jetpack field
		if (jetpack) {
			if (jetpackField < 0) {
				jetpack = false;
			} else {
				jetpackField -= elapsed;
			}
		} else if (jetpackField < jetpackFieldMax && isTouching(FlxObject.DOWN)) {
			jetpackField += elapsed / 2;
		}
		if (!jetpack) {
			sndJetpack.pause();
		}
		// facing and movement
		if (jetpack) {
			sndJetpack.play();
			numJump = numJumpLimit;
			if (up || down || left || right) {
				acceleration.y = 0;
				facing = faced;
				var mA:Float = 0; // our temporary angle
				if (left) {
					mA = 180;
					if (up) mA += 45;
					else if (down) mA -= 45;
					facing = FlxObject.LEFT;
					faced = FlxObject.LEFT;
				} else if (right) {
					mA = 0;
					if (up) mA -= 45;
					else if (down) mA += 45;
					facing = FlxObject.RIGHT;
					faced = FlxObject.RIGHT;
				} else if (up) {
					mA = -90;
				} else if (down) {
					mA = 90;
				}
				// determine our velocity based on the angle and speed
				velocity.set(speed * 3, 0);
				velocity.rotate(FlxPoint.weak(0, 0), mA);
			} else {
				velocity.set(0, 0);
			}
		} else if (roll) {
			tumble(faced, elapsed);
			jump = -1;
		} else if (!isTumbling()) {
			acceleration.y = GRAVITY;
			if (left) {
				facing = FlxObject.LEFT;
				faced = FlxObject.LEFT;
				velocity.x = -speed;
			} else if (right) {
				facing = FlxObject.RIGHT;
				faced = FlxObject.RIGHT;
				velocity.x = speed;
			}
			
			if (!left && !right) {
				//velocity.x = 0;
				facing = FlxObject.NONE;
			}
			
			// jumping
			if (isTouching(FlxObject.DOWN)) {
				if(midAir) {
					sndLand.play();
				}
				jump = -1;
				numJump = 0;
			}
			
			if (doubleJump && numJump < numJumpLimit) {
				numJump++;
				jump = 0;
				sndJump.play(true);
			}
			if (jump >= 0) {
				jump += elapsed;
				if (jump > 0.33) {
					jump = -1;
				}
			}
			if (jump > 0) {
				velocity.y = -speed * 1.5;
			}
			
		}
		
		//is the player in midair
		if(cast(velocity.y, Int) != 0 && !isTouching(FlxObject.DOWN)) {
			midAir = true;
		} else {
			midAir = false;
		}

		// if the player is moving (velocity is not 0), we need to change the
		// animation to match their facing
		if (isTumbling()) {
			animation.play("tumble");
		} else if (jetpack && !isSwording()) {
			animation.play(curConfig + "JP");
			if(isShielding()) {
				animation.play(curConfig + "JPShield");
			} else if (isSwording()) {
				animation.play(curConfig + "JPSword");
			} else {
				animation.play(curConfig + "JP");
			}
		} else if (!isTouching(FlxObject.DOWN) && !isSwording()) {
			animation.play(curConfig + "Jump");
		} else if (isShielding()) {
			animation.play(curConfig + "Shield");
		} else if(!isSwording()){
			playRun(curConfig);
		}
		if (!isTumbling() && !isSwording()) {
			//trace(Std.string(jrvTimer));
			if(jWeapon.getName() == "revolver") {
				if(FlxG.keys.anyPressed([J]) && !jWeapon.isReloading()) {
					if(jrvTimer > 0.5 && !cast(jWeapon, Revolver).isCharging()) {
						cast(jWeapon, Revolver).charge();
					} else if(jrvTimer < 0) {
						jrvTimer = 0;
					} else if(jrvTimer > -1) {
						jrvTimer += elapsed;
					}
				}
				if(!isShielding()) {
					//fire revolver
					if(FlxG.keys.anyJustReleased([J])) {
						if(cast(jWeapon, Revolver).isCharging()) {
							if(!cast(jWeapon, Revolver).charged) {
								cast(jWeapon, Revolver).discharge();
							}
							jrvTimer = -1;
						}
						if(jWeapon.canFire() && !jWeapon.isReloading()) {
							fireWeapon(jWeapon);
						}
					}
				}
			}
			if(kWeapon.getName() == "revolver") {
				if(FlxG.keys.anyPressed([K]) && !kWeapon.isReloading()) {
					if(krvTimer > 0.5 && !cast(kWeapon, Revolver).isCharging()) {
						cast(kWeapon, Revolver).charge();
					} else if(krvTimer < 0) {
						krvTimer = 0;
					} else if(krvTimer > -1) {
						krvTimer += elapsed;
					}
				}
				if(!isShielding()) {
					//fire revolver
					if(FlxG.keys.anyJustReleased([K])) {
						if(cast(kWeapon, Revolver).isCharging()) {
							if(!cast(kWeapon, Revolver).charged) {
								cast(kWeapon, Revolver).discharge();
							}
							krvTimer = -1;
						}
						if(jWeapon.canFire() && !jWeapon.isReloading()) {
							fireWeapon(jWeapon);
						}
					}
				}
			}
			if(!isShielding()){
				if(curConfig == "ds" && FlxG.keys.anyPressed([J]) && FlxG.keys.anyPressed([K])
					&& jWeapon.canFire()
					&& kWeapon.canFire()
					&& cast(jWeapon, Sword).isWW()) {
					swordTimer = 0;
					jWeapon.attack(getMidpoint().x, y, FlxObject.RIGHT);
					kWeapon.attack(getMidpoint().x, y, FlxObject.LEFT);

					if(jetpack) {
						animation.play(curConfig + "JPDC");
					} else {
						animation.play(curConfig + "DC");
					}
				} else {
					if (FlxG.keys.anyPressed([J])) {
						//RIFLE fully automatic, can hold to fire
						if (jWeapon.getName() == "rifle") {
							if(jWeapon.canFire() && !jWeapon.isReloading()) {
								fireWeapon(jWeapon);
							} 
						} else if (jWeapon.getName() == "shield") { //engage shield
							if (!shielding) {
								shielding = true;
							}
						}
						//Other weapons that cannot hold to fire
						if (FlxG.keys.anyJustPressed([J])) {
							if(jWeapon.getName() != "revolver" && jWeapon.canFire() && !jWeapon.isReloading()) {
								fireWeapon(jWeapon);
							}
						}
					} 
					if (FlxG.keys.anyPressed([K])) {
						//RIFLE fully automatic, can hold to fire
						if (kWeapon.getName() == "rifle") {
							if(kWeapon.canFire() && !kWeapon.isReloading()) {
								fireWeapon(kWeapon);
							} 
						} else if (kWeapon.getName() == "shield") { //engage shield
							if (!shielding) {
								shielding = true;
							}
						}
						
						//Other weapons that cannot hold to fire
						if (FlxG.keys.anyJustPressed([K])) {
							if(kWeapon.getName() != "revolver" && kWeapon.canFire() && !kWeapon.isReloading()) {
								fireWeapon(kWeapon);
							}
						}
					}	
				}
			}
		}
	}

		private function fireWeapon(w: Weapon):Bool {
			var offX:Int = 0;
			var offY:Int = 0;
			if(curConfig == "ds" && (cast(jWeapon, Sword).isDs() || cast(kWeapon, Sword).isDs())) {
				swordTimer = 0;
				if (facing == FlxObject.NONE) {
					jWeapon.attack(getMidpoint().x, y, faced);
					kWeapon.attack(getMidpoint().x, y, faced);
				} else {
					jWeapon.attack(getMidpoint().x, y, facing);
					kWeapon.attack(getMidpoint().x, y, facing);
				}
				if(jetpack) {
					animation.play(curConfig + "JPDC");
				} else {
					animation.play(curConfig + "DC");
					//trace("doublecut");
				}
				swordNum++;
				if(swordNum > 2) {
					swordNum = 0;
				}
				return true;
			} else if (w.getName() == "sword") {
				swordTimer = 0;
				if(swordNum % 2 == 0) {
					if(jetpack) {
						animation.play(curConfig + "JPStab");
					} else {
						animation.play(curConfig + "Stab");
					}
				} else {
					if(jetpack) {
						animation.play(curConfig + "JPCut");
					} else {
						animation.play(curConfig + "Cut");
					}
				}
				//trace(swordNum);
				swordNum++;
				if(swordNum > 2) {
					swordNum = 0;
				}
			} else if (curConfig == "dr") {
				if(w == kWeapon) {
					offY = -15;
				}
			} else if (curConfig == "drv" || curConfig == "dsg") {
				if(w == jWeapon) {
					offY = 6;
				} else {
					offY = -9;
					offX = 70;
				}
			} else if(curConfig == "swsg" || curConfig == "swrv") {
				offX = 50;
				offY = 9;
			} else if(curConfig == "rsg" || curConfig == "rrv") {
				offX = 30;
				offY = -9;
			} else if(curConfig == "sgrv") {
				if(w.getName() == "shotgun") {
					offY = 5;
				} else {
					offX = 20;
					offY = -8;
				}
			}
		
			if (facing == FlxObject.NONE) {
				if(faced == FlxObject.LEFT) {
					return w.attack(getMidpoint().x - offX, y + offY, faced);
				} else {
					return w.attack(getMidpoint().x + offX, y + offY, faced);
				}
			} else if(facing == FlxObject.RIGHT) {
				return w.attack(getMidpoint().x + offX, y + offY, facing);
			} else {
				return w.attack(getMidpoint().x - offY, y + offY, facing);
			}
	}		

	public function isShielding():Bool {
		return shielding;
	}

	public function usePotion() {
		if(potionCount > 0) {
			potionCount--;
			heal();
		}
	}

	public function heal() {
		health += maxHealth * 0.3;
		if (health > maxHealth) {
			health = maxHealth;
		}
		sndPotion.play(true);
	}

	public function getSpike():Float {
		if(isShielding()) {
			if(jWeapon.getName() == "shield") {
				return cast(jWeapon, Shield).getSpike();
			} else {
				return cast(kWeapon, Shield).getSpike();
			}
		} else {
			return 0;
		}
    }

    public function getReflect():Float {
        if(isShielding()) {
			if(jWeapon.getName() == "shield") {
				return cast(jWeapon, Shield).getReflect();
			} else {
				return cast(kWeapon, Shield).getReflect();
			}
		} else {
			return 0;
		}
    }

    public function getDaze():Bool {
        if(isShielding()) {
			if(jWeapon.getName() == "shield") {
				return cast(jWeapon, Shield).getDaze();
			} else {
				return cast(kWeapon, Shield).getDaze();
			}
		} else {
			return false;
		}
    }

	public function getWeaponName(which:Int):String {
		if(which == 0) {
			if(jWeapon == null) {
				return "";
			}
			return jWeapon.getName();
		} else {
			if(kWeapon == null) {
				return "";
			}
			return kWeapon.getName();
		}
	}

	public function getAmmo(which:Int):Int {
		if(which == 0) {
			if(jWeapon == null) {
				return -1;
			}
			return jWeapon.getCurAmmo();
		} else {
			if(kWeapon == null) {
				return -1;
			}
			return kWeapon.getCurAmmo();
		}
	}

	public function isReloading(which:Int):Bool {
		if(which == 0) {
			return jWeapon.isReloading();
		} else {
			return kWeapon.isReloading();
		}
	}

	public function pickUpShield():Void {
		//trace(Std.string(Main.SAVE.data.tutComplete));
		if(Main.SAVE.data.levelCompleted == null || Main.SAVE.data.levelCompleted < 1) {
			kWeapon = new Shield(bulletArray);
			k2ndWeapon = new Shield(bulletArray);
			Main.SAVE.data.kWeapon = kWeapon.getName();
			Main.SAVE.data.k2ndWeapon = k2ndWeapon.getName();
			curConfig = "swsh";
			Main.SAVE.data.curConfig = curConfig;
			//Main.SAVE.flush();
		}
	}
	
	public function pickUpRifle():Void {
		trace(Std.string(Main.SAVE.data.riflePickUp));
		if(Main.SAVE.data.riflePickUp == null || Main.SAVE.data.riflePickUp == false) {
			this.j2ndWeapon = new Rifle(bulletArray);
			this.k2ndWeapon = new Weapon(bulletArray);
			Main.SAVE.data.riflePickUp = true;
			Main.SAVE.data.j2ndWeapon = j2ndWeapon.getName();
			Main.SAVE.data.k2ndWeapon = k2ndWeapon.getName();
			//Main.SAVE.flush();
			changeWeaponConfig();
		}
		sndRifleReload.play(true);
	}
	
	public function pickUpCoin(value:Int):Void {
		//trace("pick up coin: " + value);
		money += value;
	}

	public function getDamageTaken() {
		return this.dmgTaken;
	}

	private function playRun(option:String) {
		switch (facing) {
			case FlxObject.LEFT, FlxObject.RIGHT:
				animation.play(option + "Run");
			case FlxObject.NONE:
				animation.play(option + "Stop");
		}
	}
 	
	private function changeWeaponConfig():Void {
		var temp1:Weapon = jWeapon;
		var temp2:Weapon = kWeapon;
		if(shielding) {
			shielding = false;
		}
		jWeapon = j2ndWeapon;
		j2ndWeapon = temp1;
		kWeapon = k2ndWeapon;
		k2ndWeapon = temp2;
		if(jWeapon.getName() == "sword" && kWeapon.getName() == "shield" ||
			kWeapon.getName() == "sword" && jWeapon.getName() == "shield") {
			curConfig = "swsh";
		} else if(jWeapon.getName() == "rifle" && kWeapon.getName() == "shield" ||
				kWeapon.getName() == "rifle" && jWeapon.getName() == "shield"){
			curConfig = "rsh";
		} else if(jWeapon.getName() == "sword" && kWeapon.getName() == "rifle" ||
				kWeapon.getName() == "sword" && jWeapon.getName() == "rifle") {
			curConfig = "swr";
		} else if(jWeapon.getName() == "sword" && kWeapon.getName() == "sword") {
			curConfig = "ds";
		} else if(jWeapon.getName() == "rifle" && kWeapon.getName() == "rifle") {
			curConfig = "dr";
		} else if(jWeapon.getName() == "shotgun" && kWeapon.getName() == "shotgun") {
			curConfig = "dsg";
		} else if(jWeapon.getName() == "revolver" && kWeapon.getName() == "revolver") {
			curConfig = "drv";
		} else if(jWeapon.getName() == "rifle" && kWeapon.getName() == "shotgun" ||
				kWeapon.getName() == "rifle" && jWeapon.getName() == "shotgun") {
			curConfig = "rsg";
		} else if(jWeapon.getName() == "rifle" && kWeapon.getName() == "revolver" ||
				kWeapon.getName() == "rifle" && jWeapon.getName() == "revolver") {
			curConfig = "rrv";
		} else if(jWeapon.getName() == "shotgun" && kWeapon.getName() == "revolver" ||
				kWeapon.getName() == "shotgun" && jWeapon.getName() == "revolver") {
			curConfig = "sgrv";
		} else if(jWeapon.getName() == "shotgun" && kWeapon.getName() == "shield" ||
				kWeapon.getName() == "shotgun" && jWeapon.getName() == "shield"){
			curConfig = "sgsh";
		} else if(jWeapon.getName() == "revolver" && kWeapon.getName() == "shield" ||
				kWeapon.getName() == "revolver" && jWeapon.getName() == "shield"){
			curConfig = "rvsh";
		} else if(jWeapon.getName() == "sword" && kWeapon.getName() == "shotgun" ||
				kWeapon.getName() == "sword" && jWeapon.getName() == "shotgun") {
			curConfig = "swsg";
		} else if(jWeapon.getName() == "sword" && kWeapon.getName() == "revolver" ||
				kWeapon.getName() == "sword" && jWeapon.getName() == "revolver") {
			curConfig = "swrv";
		} else {
			curConfig = jWeapon.getName();
		}
		Main.SAVE.data.jWeapon = jWeapon.getName();
		Main.SAVE.data.j2ndWeapon = j2ndWeapon.getName();
		Main.SAVE.data.kWeapon = kWeapon.getName();
		Main.SAVE.data.k2ndWeapon = k2ndWeapon.getName();
		Main.SAVE.data.curConfig = curConfig;
		//Main.SAVE.flush();
	}

	private function tumble(direction:Int, elapsed:Float):Void {
		acceleration.y = GRAVITY;
		if (direction == FlxObject.LEFT) {
			velocity.x = -speed * 3;
		} else if (direction == FlxObject.RIGHT) {
			velocity.x = speed * 3;
		}
		if (tumbleTimer < 0) {
			tumbleTimer = 0.0;
			sndRoll.play(true);
		} else if (tumbleTimer < TumbleTime) {
			tumbleTimer += elapsed;
		} else {
			tumbleTimer = -1;
		}
		
	}
	
	public function isTumbling():Bool {
		return tumbleTimer >= 0 && tumbleTimer < TumbleTime;
	}

	private function isSwording():Bool {
		return swordTimer >= 0 && swordTimer < swordTime;
	}

	private function addAnimation() {
		animation.add("Run", [2, 3, 4, 5, 6, 7, 8, 9], 12, false);
		animation.add("Stop", [1], 1, false);
		animation.add("JP", [15, 16], 12, false);
		animation.add("Jump", [14], 1, false);
		animation.add("tumble", [10, 11, 12, 13], 12, false);
		
		//SWORD
		//sword run
		animation.add("swordRun", [33, 34, 35, 36, 37, 38, 39, 40], 12, false);
		//sword standing
		animation.add("swordStop", [23], 1, false);
		//sword jetpack
		animation.add("swordJP", [31, 32], 12, false);
		//sword jump
		animation.add("swordJump", [30], 1, false);
		//sword stab
		animation.add("swordStab", [21, 22, 22, 21], 16, false);
		//sword cut
		animation.add("swordCut", [17, 18, 19, 20], 16, false);
		
		//RIFLE
		//rifle standing
		animation.add("rifleStop", [41], 1, false);
		//rifle run
		animation.add("rifleRun", [42, 43, 44, 45, 46, 47, 48, 49], 12, false);
		//rifle jump
		animation.add("rifleJump", [50], 1, false);
		//rifle jetpack
		animation.add("rifleJP", [51, 52], 12, false);

		//SWORD SHIELD
		//sword shield run
		animation.add("swshRun", [96, 97, 98, 99, 100, 101, 102, 103], 12, false);
		//sword shield standing
		animation.add("swshStop", [85], 1, false);
		//sword shield jump
		animation.add("swshJump", [92], 1, false);
		//sword shield stab
		animation.add("swshStab", [83, 84, 84, 83], 16, false);
		//sword shield cut
		animation.add("swshCut", [79, 80, 81, 82], 16, false);
		//sword shield jetpack
		animation.add("swshJP", [93, 94], 12, false);
		animation.add("swshJPCut", [86, 87, 88, 89], 16, false);
		animation.add("swshJPStab", [90, 91, 91, 90], 16, false);
		animation.add("swshJPShield", [95], 1, false);
		//shield
		animation.add("swshShield", [104], 3, false);

		//SWORD RIFLE
		//standing
		animation.add("swrStop", [106], 1, false);
		//jumping
		animation.add("swrJump", [107], 1, false);
		//run
		animation.add("swrRun", [71, 72, 73, 74, 75, 76, 77, 78], 12, false);
		//stab
		animation.add("swrStab", [57, 58, 58, 57], 16, false);
		//cut
		animation.add("swrCut", [53, 54, 55, 56], 16, false);
		//jetpack
		animation.add("swrJP", [108, 109], 12, false);
		animation.add("swrJPStab", [90, 91, 91, 90], 16, false);
		animation.add("swrJPCut", [86, 87, 88, 89], 16, false);

		//RIFLE SHIELD
		//standing
		animation.add("rshStop", [110], 1, false);
		//jumping
		animation.add("rshJump", [120], 1, false);
		//running
		animation.add("rshRun", [111, 112, 113, 114, 115, 116, 117, 118], 12, false);
		//shielding
		animation.add("rshShield", [192], 1, false);
		//jetpack
		animation.add("rshJP", [121, 122], 12, false);
		animation.add("rshJPShield", [123], 1, false);

		//DOUBLE RIFLE
		//standing
		animation.add("drStop", [124], 1, false);
		//jumping
		animation.add("drJump", [134], 1, false);
		//running
		animation.add("drRun", [125, 126, 127, 128, 129, 130, 131, 132], 12, false);
		//jetpack
		animation.add("drJP", [135, 136], 12, false);

		//DOUBLE SWORD
		//standing 
		animation.add("dsStop", [143], 1, false);
		//jumping
		animation.add("dsJump", [155], 1, false);
		//run
		animation.add("dsRun", [147, 148, 149, 150, 151, 152, 153, 154], 12, false);
		//stab
		animation.add("dsStab", [141, 142, 142, 141], 16, false);
		//cut 
		animation.add("dsCut", [144, 145, 146], 16, false);
		//double cut
		animation.add("dsDC", [137, 138, 139, 140], 16, false);
		//jet pack
		animation.add("dsJP", [156, 157], 12, false);
		animation.add("dsJPDC", [158, 159, 160, 161], 16, false);
		animation.add("dsJPStab", [162, 163, 163, 162], 16, false);
		animation.add("dsJPCut", [165, 166, 167], 16, false);

		//RIFLE SHOTGUN
		//standing
		animation.add("rsgStop", [168], 1, false);
		//jumping
		animation.add("rsgJump", [177], 1, false);
		//running
		animation.add("rsgRun", [169, 170, 171, 172, 173, 174, 175, 176], 12, false);
		//jetpack
		animation.add("rsgJP", [178, 179], 12, false);

		//RIFLE REVOLVER
		//standing
		animation.add("rrvStop", [180], 1, false);
		animation.add("rrvRun", [181, 182, 183,184,185,186,187,188], 12, false);
		animation.add("rrvJump", [189], 1, false);
		animation.add("rrvJP", [190, 191], 12, false);

		//SHOTGUN REVOLVER
		animation.add("sgrvStop", [193], 1, false);
		animation.add("sgrvRun", [194,195,196,197,198,199,200,201], 12, false);
		animation.add("sgrvJump", [202], 1, false);
		animation.add("sgrvJP", [203, 204], 12, false);

		//DOUBLE REVOLVER
		animation.add("drvStop", [205], 1, false);
		animation.add("drvRun", [206,207,208,209,210,211,212,213], 12, false);
		animation.add("drvJump", [214], 1, false);
		animation.add("drvJP", [215, 216], 12, false);

		//REVOLVER SHIELD
		animation.add("rvshStop", [217], 1, false);
		animation.add("rvshRun", [218,219,220,221,222,223,224,225], 12, false);
		animation.add("rvshJump", [226], 1, false);
		animation.add("rvshJP", [227, 228], 12, false);
		animation.add("rvshJPShield", [229], 1, false);
		animation.add("rvshShield", [230], 1, false);

		//SWORD REVOLVER
		animation.add("swrvStop", [237], 1, false);
		animation.add("swrvJump", [238], 1, false);
		animation.add("swrvRun", [247,248,249,250,251,252,253,254], 12, false);
		animation.add("swrvCut", [231,232,233,234], 16, false);
		animation.add("swrvStab", [235,236,236,235], 16, false);
		animation.add("swrvJP", [245, 246], 12, false);
		animation.add("swrvJPCut", [239, 240,241,242], 16, false);
		animation.add("swrvJPStab", [243, 244, 244, 243], 16, false);

		//DOUBLE SHOTGUN
		animation.add("dsgStop", [255], 1, false);
		animation.add("dsgRun", [256,257,258,259,260,261,262,263], 12, false);
		animation.add("dsgJump", [264], 1, false);
		animation.add("dsgJP", [265,266], 12, false);

		//SHOTGUN SHIELD
		animation.add("sgshStop", [267], 1, false);
		animation.add("sgshRun", [268,269,270,271,272,273,274,275], 12, false);
		animation.add("sgshJump", [276], 1, false);
		animation.add("sgshJP", [277, 278], 12, false);
		animation.add("sgshJPShield", [279], 1, false);
		animation.add("sgshShield", [280], 1, false);

		//SWORD SHOTGUN
		animation.add("swsgStop", [287], 1, false);
		animation.add("swsgJump", [288], 1, false);
		animation.add("swsgRun", [297, 298, 299, 300, 301, 302, 303, 304], 12, false);
		animation.add("swsgCut", [281,282,283,284], 16, false);
		animation.add("swsgStab", [285, 286, 286, 285], 16, false);
		animation.add("swsgJP", [295, 296], 12, false);
		animation.add("swsgJPCut", [289,290,291,292], 16, false);
		animation.add("swsgJPStab", [293, 294, 294, 293], 16, false);
	}
	
	private function loadSound():Void {
		sndHurt1 = FlxG.sound.load(AssetPaths.hit_human1__wav);
		sndHurt2 = FlxG.sound.load(AssetPaths.hit_human2__wav);
		sndHurt3 = FlxG.sound.load(AssetPaths.hit_human3__wav);
		sndShield = FlxG.sound.load(AssetPaths.shield__wav);
		sndJump = FlxG.sound.load(AssetPaths.jump__wav);
		sndLand = FlxG.sound.load(AssetPaths.land__wav);
		sndRoll = FlxG.sound.load(AssetPaths.roll__wav);
		sndJetpack = FlxG.sound.load(AssetPaths.jetpack__wav);
		sndRifleReload = FlxG.sound.load(AssetPaths.rifle_reload__wav);
	}
	
	override public function hurt(damage:Float):Void {
		super.hurt(damage);
		this.dmgTaken += damage;
		color = 0xff0000;
		FlxFlicker.flicker(this, 0.5, 0.10, true, true, hurtComplete);
		var rand:Float = Math.random() * 3;
		if (rand < 1) {
			sndHurt1.play(true);
		} else if (rand < 2) {
			sndHurt2.play(true);
		} else {
			sndHurt3.play(true);
		}
	}
	
	private function hurtComplete(_):Void {
		color = 0xffffff;
	}
}