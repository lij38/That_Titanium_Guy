package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import weapons.*;

class Player extends FlxSprite {
	public var speed:Float = 200;
	private var gravity:Float = 1000;
	private var jumped:Bool = false;
	private var jump:Float = 0.0;
	private var faced:Int = FlxObject.RIGHT;
	private var numJump:Int = 0;
	public var numJumpLimit:Int = 2;
	
	//private var leftTimer:Float = -1;
	//private var rightTimer:Float = -1;
	private var tumbleTimer:Float = -1;
	
	//private var TumblePressedBetween:Float = 0.3;
	private var TumbleTime:Float = 0.3;
	
	private var bulletArray:FlxTypedGroup<Bullet>;

	private var jWeapon:Weapon;
	private var kWeapon:Weapon;
	private var j2ndWeapon:Weapon;
	private var k2ndWeapon:Weapon;
	private var jWeaponTimer:Float = -0.1;
	private var kWeaponTimer:Float = -0.1;
	private var jReloadTimer:Float = -0.1;
	private var kReloadTimer:Float = -0.1;
	private var shielding:Bool;

	public function new(?X:Float=0, ?Y:Float=0, playerBulletArray:FlxTypedGroup<Bullet>) {
		super(X, Y);
		
		health = 100;

		loadGraphic(AssetPaths.h__png, true, 408, 435);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		scale.set(0.25, 0.25);
		animation.add("lr", [2, 3, 4, 5, 6, 7, 8, 9], 12, false);
		animation.add("stop", [1], 1, false);
		animation.add("jetpack", [17, 18], 12, false);
		//animation.add("beginjump", [14], 1, false);
		animation.add("midjump", [15], 1, false);
		animation.add("tumble", [10, 11, 12, 13], 12, false);
		offset.set(170, 175);
		setSize(70, 90);
		
		acceleration.y = gravity;
		
		bulletArray = playerBulletArray;

		jWeapon = new Sword(playerBulletArray);
		j2ndWeapon = new Rifle(playerBulletArray);
		kWeapon = new Shield(playerBulletArray);
		k2ndWeapon = new Weapon(playerBulletArray);
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
		if(FlxG.keys.anyJustReleased([J, K])) {
			if(shielding) {
				shielding = false;
				trace("unshielded");
			}
		}

		if (!isTumbling()) {
			tumbleTimer = -1;
			up = FlxG.keys.anyPressed([UP, W]);
			down = FlxG.keys.anyPressed([DOWN, S]);
			left = FlxG.keys.anyPressed([LEFT, A]);
			right = FlxG.keys.anyPressed([RIGHT, D]);
			doubleJump = FlxG.keys.anyJustPressed([UP, W]);
			
			//leftP = FlxG.keys.anyJustPressed([LEFT, A]);
			//rightP = FlxG.keys.anyJustPressed([RIGHT, D]);
			
			jetpack = FlxG.keys.anyPressed([SHIFT]);
			
			roll = FlxG.keys.anyJustPressed([SPACE]);
		} else {
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
				velocity.set(speed * 2, 0);
				velocity.rotate(FlxPoint.weak(0, 0), mA);
			} else {
				velocity.set(0, 0);
			}
		} else if (roll) {
			tumble(faced, elapsed);
		} else if (!isTumbling()) {
			acceleration.y = gravity;
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
			
			
			if (jumped && !up) {
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
			
			if (jump >= 0 && up) {
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
			animation.play("jetpack");
		} else if (velocity.y != 0) {
			animation.play("midjump");
		} else {
			switch (facing) {
				case FlxObject.LEFT, FlxObject.RIGHT:
					animation.play("lr");
				case FlxObject.NONE:
					animation.play("stop");
			}
		}
		if (!isTumbling()) {
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
						trace("shielding");
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


 	
	private function changeWeaponConfig():Void {
		var temp1:Weapon = jWeapon;
		var temp2:Weapon = kWeapon;
		jWeapon = j2ndWeapon;
		j2ndWeapon = temp1;
		kWeapon = k2ndWeapon;
		k2ndWeapon = temp2;
	}

	private function fireWeapon(w: Weapon):Bool {
		if (facing == FlxObject.NONE) {
			return w.attack(x, y, faced);
		} else {
			return w.attack(x, y, facing);
		}
	}

	private function tumble(direction:Int, elapsed:Float):Void {
		acceleration.y = gravity;
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
	
	private function isTumbling():Bool {
		return tumbleTimer >= 0 && tumbleTimer < TumbleTime;
	}
}