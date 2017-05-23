package;

import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import weapons.*;
import haxe.CallStack;

class Player extends FlxSprite {
	public var speed:Float = 250;
	private var GRAVITY:Float;
	private var jumped:Bool = false;
	private var jump:Float = 0.0;
	public var faced:Int = FlxObject.RIGHT;
	private var numJump:Int = 0;
	public var numJumpLimit:Int = 2;
	
	//private var leftTimer:Float = -1;
	//private var rightTimer:Float = -1;
	private var tumbleTimer:Float = -1;
	
	//private var TumblePressedBetween:Float = 0.3;
	private var TumbleTime:Float = 0.3;
	
	private var bulletArray:FlxTypedGroup<Bullet>;
	
	private var money:Int;
	
	private var jWeapon:Weapon;
	private var kWeapon:Weapon;
	private var j2ndWeapon:Weapon;
	private var k2ndWeapon:Weapon;
	private var jWeaponTimer:Float = -0.1;
	private var kWeaponTimer:Float = -0.1;
	private var jReloadTimer:Float = -0.1;
	private var kReloadTimer:Float = -0.1;
	private var shielding:Bool;
	private var swordNum:Int = 2;
	private var swordTime:Float = 0.25;
	private var swordTimer:Float = -1;
	private var curConfig:String;
	private var dmgTaken:Float;

	public function new(?X:Float = 0, ?Y:Float = 0,
						playerBulletArray:FlxTypedGroup<Bullet>,
						gravity:Float) {
		super(X, Y);
		GRAVITY = gravity;
		health = 100;
		dmgTaken = 0.0;

		loadGraphic(AssetPaths.player__png, true, cast(4745 / 5, Int), cast(11109 / 21, Int));
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		scale.set(0.35, 0.35);
		
		addAnimation();
		
		setSize(48, 115);
		offset.set(450, 198);
		acceleration.y = GRAVITY;
		
		bulletArray = playerBulletArray;
		if(Main.SAVE.data.tutComplete == null || Main.SAVE.data.tutComplete == false) {
			jWeapon = new Sword(playerBulletArray);
			j2ndWeapon = new Weapon(playerBulletArray);
			kWeapon = new Weapon(playerBulletArray);
			k2ndWeapon = new Weapon(playerBulletArray);
			curConfig = "sword";
			Main.SAVE.data.jWeapon = jWeapon.getName();
			Main.SAVE.data.j2ndWeapon = j2ndWeapon.getName();
			Main.SAVE.data.kWeapon = kWeapon.getName();
			Main.SAVE.data.k2ndWeapon = k2ndWeapon.getName();
			Main.SAVE.data.curConfig = curConfig;
			Main.SAVE.flush();
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
		}
		shielding = false;
	}
	
	override public function update(elapsed:Float):Void {
		if(jWeaponTimer > -0.1) {
			jWeaponTimer += elapsed;
		}
		if(kWeaponTimer > -0.1) {
			kWeaponTimer += elapsed;
		}
		if(jReloadTimer > -0.1) {
			jReloadTimer += elapsed;
		}
		if(kReloadTimer > -0.1) {
			kReloadTimer += elapsed;
		}
		if(jReloadTimer > jWeapon.getReloadTime()) {
			jReloadTimer = -0.1;
		}
		if(kReloadTimer > kWeapon.getReloadTime()) {
			kReloadTimer = -0.1;
		}
		if(swordTimer > -1) {
			swordTimer += elapsed;
		}
		if(swordTimer > swordTime) {
			swordTimer = -1;
		}
		movement(elapsed);			
		super.update(elapsed);
	}
	
	private function movement(elapsed:Float):Void {
		
		//if (leftTimer >= 0) {
			//leftTimer += elapsed;
		//}
		//if (leftTimer > TumblePressedBetween) {
			//leftTimer = -1;
		//}
		//if (rightTimer >= 0) {
			//rightTimer += elapsed;
		//}
		//if (rightTimer > TumblePressedBetween) {
			//rightTimer = -1;
		//}
		
		var jumpKey:Bool = false;
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		var doubleJump:Bool = false;
		//var leftP:Bool = false;
		//var rightP:Bool = false;
		var jetpack:Bool = false;
		var roll:Bool = false;
		
		//change weapon configuration
		if(FlxG.keys.anyJustPressed([Q])) {
			changeWeaponConfig();
		}

		//unshield if shielding
		if(FlxG.keys.anyJustReleased([K])) {
			if(shielding) {
				shielding = false;
				//trace("unshielded");
			}
		}

		if(FlxG.keys.anyPressed([R])) {
			jReloadTimer = 0.0;
			kReloadTimer = 0.0;
			jWeapon.reload();
			kWeapon.reload();
		}

		if (!isSwording() && !isTumbling()) {
			tumbleTimer = -1;
			up = FlxG.keys.anyPressed([W]);
			jumpKey = FlxG.keys.anyPressed([SPACE]);
			left = FlxG.keys.anyPressed([A]);
			right = FlxG.keys.anyPressed([D]);
			down = FlxG.keys.anyPressed([S]);
			doubleJump = FlxG.keys.anyJustPressed([SPACE]);
			
			//leftP = FlxG.keys.anyJustPressed([LEFT, A]);
			//rightP = FlxG.keys.anyJustPressed([RIGHT, D]);
			
			jetpack = FlxG.keys.anyPressed([SHIFT]);
			
			roll = FlxG.keys.anyJustPressed([S]);
		} else if (isTumbling()){
			tumble(FlxObject.NONE, elapsed);
		}
		
		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;
		
		// double tap rip
		/*if (!up && !down && !jetpack) {
			if (leftP && leftTimer < 0) {
				leftTimer = 0.0;
			} else if (leftTimer >= 0 && leftP) {
				trace(leftTimer);
				if (leftTimer <= TumblePressedBetween) {
					tumble(FlxObject.LEFT, elapsed);
					leftTimer = -1;
					trace("Tumble!!!");
				}
			}
			if (rightP && rightTimer < 0) {
				rightTimer = 0.0;
			} else if (rightTimer >= 0 && rightP) {
				trace(rightTimer);
				if (rightTimer <= TumblePressedBetween) {
					tumble(FlxObject.RIGHT, elapsed);
					rightTimer = -1;
					trace("Tumble!!!");
				}
			}
		}*/
		
		if (jetpack) {
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
				velocity.x = 0;
				facing = FlxObject.NONE;
			}
			
			
			if (jumped && !jumpKey) {
				jumped = false;
			}
			
			if (touching == FlxObject.DOWN && !jumped) {
				jump = 0;
				numJump = 0;
			}
			
			if (doubleJump && numJump < numJumpLimit) {
				numJump++;
				jumped = false;
				jump = 0;
			}
			
			if (jump >= 0 && jumpKey) {
				jumped = true;
				jump += elapsed;
				if (jump > 0.33) {
					jump = -1;
				}
			} else {
				jump = -1;
			}
			
			if (jump > 0) {
				velocity.y = -speed * 1.5;
			}
			
		}
		
		// if the player is moving (velocity is not 0), we need to change the
		// animation to match their facing
		if (isTumbling()) {
			animation.play("tumble");
		} else if (jetpack) {
			animation.play(curConfig + "JP");
		} else if (!isTouching(FlxObject.DOWN) && !isSwording()) {
			animation.play(curConfig + "Jump");
		} else if (isShielding()) {
			animation.play(curConfig + "Shield");
		} else if(!isSwording()){
			playRun(curConfig);
		}
		if (!isTumbling() && !isSwording() && !isShielding()) {
			if(FlxG.keys.anyPressed([J])) {
				//RIFLE fully automatic, can hold to fire
				if(jWeapon.getName() == "rifle") {
					if((jWeaponTimer == -0.1 || jWeaponTimer > jWeapon.getRate())
						&& jReloadTimer == -0.1) {
						if(!fireWeapon(jWeapon)) {
							jReloadTimer = 0.0;
						} 
						jWeaponTimer = 0.0;
					} 
				} else if(jWeapon.getName() == "shield") { //engage shield
					if(!shielding) {
						shielding = true;
						trace("shielding");
					}
				}
				//Other weapons that cannot hold to fire
				if(FlxG.keys.anyJustPressed([J])) {
					if((jWeaponTimer == -0.1 || jWeaponTimer > jWeapon.getRate())
						&& jReloadTimer == -0.1) {
						if(!fireWeapon(jWeapon)) {
							jReloadTimer = 0.0;
						} 
						jWeaponTimer = 0.0;
					}
				}
			} else if(FlxG.keys.anyPressed([K])) {
				//RIFLE fully automatic, can hold to fire
				if(kWeapon.getName() == "rifle") {
					if((kWeaponTimer == -0.1 || kWeaponTimer > kWeapon.getRate())
						&& kReloadTimer == -0.1) {
						if(!fireWeapon(kWeapon)) {
							kReloadTimer = 0.0;
						} 
						kWeaponTimer = 0.0;
					} 
				} else if(kWeapon.getName() == "shield") { //engage shield
					if(!shielding) {
						shielding = true;
						//trace("shielding");
					}
				}
				//Other weapons that cannot hold to fire
				if(FlxG.keys.anyJustPressed([K])) {
					if((kWeaponTimer == -0.1 || kWeaponTimer > kWeapon.getRate())
						&& kReloadTimer == -0.1) {
						if(!fireWeapon(kWeapon)) {
							kReloadTimer = 0.0;
						} 
						kWeaponTimer = 0.0;
					}
				}
			}		
		}
	}

	public function isShielding():Bool {
		return shielding;
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

	public function getAmmoCap(which:Int):Int {
		if(which == 0) {
			if(jWeapon == null) {
				return -1;
			}
			return jWeapon.getMaxAmmo();
		} else {
			if(kWeapon == null) {
				return -1;
			}
			return kWeapon.getMaxAmmo();
		}
	}

	public function isReloading(which:Int):Bool {
		if(which == 0) {
			return jReloadTimer != -0.1;
		} else {
			return kReloadTimer != -0.1;
		}
	}

	public function pickUpShield():Void {
		trace(Std.string(Main.SAVE.data.tutComplete));
		if(Main.SAVE.data.tutComplete == null || Main.SAVE.data.tutComplete == false) {
			kWeapon = new Shield(bulletArray);
			Main.SAVE.data.kWeapon = kWeapon.getName();
			curConfig = "swsh";
			Main.SAVE.data.curConfig = curConfig;
			Main.SAVE.flush();
		}
	}
	
	public function pickUpRifle():Void {
		trace(Std.string(Main.SAVE.data.riflePickUp));
		if(Main.SAVE.data.riflePickUp == null || Main.SAVE.data.riflePickUp == false) {
			this.j2ndWeapon = new Rifle(bulletArray);
			Main.SAVE.data.riflePickUp = true;
			Main.SAVE.flush();
		}
	}
	
	// TODO: implement player pick up coin
	public function pickUpCoin(value:Int):Void {
		trace("pick up coin: " + value);
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
		jWeapon = j2ndWeapon;
		j2ndWeapon = temp1;
		kWeapon = k2ndWeapon;
		k2ndWeapon = temp2;
		if(jWeapon.getName() == "sword" && kWeapon.getName() == "shield" ||
			kWeapon.getName() == "sword" && jWeapon.getName() == "shield") {
			curConfig = "swsh";
		} else {
			curConfig = jWeapon.getName();
		}
		Main.SAVE.data.jWeapon = jWeapon.getName();
		Main.SAVE.data.j2ndWeapon = j2ndWeapon.getName();
		Main.SAVE.data.kWeapon = kWeapon.getName();
		Main.SAVE.data.k2ndWeapon = k2ndWeapon.getName();
		Main.SAVE.data.curConfig = curConfig;
		Main.SAVE.flush();
	}

	// //helper for checking condition in changeWeaponConfig
	// private function checkConfig(w1:String, w2:String):Bool {
	// 	if(jWeapon.getName() == w1 && kWeapon.getName() == w2 ||
	// 		kWeapon.getName() == w1 && jWeapon.getName() == w2) {
	// 		return true;
	// 	}
	// 	return false;
	// }

	// //helper single arg
	// private function singleCheckConfig(w:String):Bool {
	// 	if(jWeapon.getName() == w || kWeapon.getName() == w) {
	// 		return true;
	// 	}
	// 	return false;
	// }

	private function fireWeapon(w: Weapon):Bool {
		if(w.getName() == "sword") {
			swordTimer = 0;
			if(swordNum % 2 == 0) {
				animation.play(curConfig + "Stab");
			} else {
				animation.play(curConfig + "Cut");
			}
			//trace(swordNum);
			swordNum++;
			if(swordNum > 2) {
				swordNum = 0;
			}
		}
		if (facing == FlxObject.NONE) {
			return w.attack(getMidpoint().x, y, faced);
		} else {
			return w.attack(getMidpoint().x, y, facing);
		}
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
		
		//rifle standing
		animation.add("rifleStop", [41], 1, false);
		//rifle run
		animation.add("rifleRun", [42, 43, 44, 45, 46, 47, 48, 49], 12, false);
		//rifle jump
		animation.add("rifleJump", [50], 1, false);
		//rifle jetpack
		animation.add("rifleJP", [51, 52], 12, false);

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
		//engage shield
		animation.add("swshShield", [104], 3, false);
	}
	
	override public function hurt(damage:Float):Void {
		super.hurt(damage);
		this.dmgTaken += damage;
		FlxFlicker.flicker(this, 0.5, 0.10);
	}
}