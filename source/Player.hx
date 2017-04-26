package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;

class Player extends FlxSprite {
	public var speed:Float = 200;
	private var gravity:Float = 1000;
	private var jumped:Bool = false;
	private var jump:Float = 0.0;
	private var faced:Int = FlxObject.RIGHT;
	private var numJump:Int = 0;
	public var numJumpLimit:Int = 2;
	
	private var leftTimer:Float = -1;
	private var rightTimer:Float = -1;
	private var tumbleTimer:Float = -1;
	
	private var TumblePressedBetween:Float = 0.3;
	private var TumbleTime:Float = 0.3;
	
	private var bulletArray:FlxTypedGroup<Bullet>;
	
	public function new(?X:Float=0, ?Y:Float=0, playerBulletArray:FlxTypedGroup<Bullet>) {
		super(X, Y);
		
		/*loadGraphic(AssetPaths.player__png, true, 16, 16);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		scale.set(4, 4);
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("stop", [3], 1, false);
		
		setSize(40, 50);
		offset.set( -10, -15);
		*/
		
		/*loadGraphic(AssetPaths.mainCharacter__png, true, 518, 854);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		scale.set(0.2, 0.2);
		animation.add("lr", [1, 2, 3, 4, 5, 6], 5, false);
		animation.add("stop", [0], 1, false);
		offset.set(230, 360);
		setSize(60, 150);*/
		
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
	}
	
	override public function update(elapsed:Float):Void {
		movement(elapsed);
		super.update(elapsed);
	}
	
	private function movement(elapsed:Float):Void {
		
		if (leftTimer >= 0) {
			leftTimer += elapsed;
		}
		if (leftTimer > TumblePressedBetween) {
			leftTimer = -1;
		}
		if (rightTimer >= 0) {
			rightTimer += elapsed;
		}
		if (rightTimer > TumblePressedBetween) {
			rightTimer = -1;
		}
		
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		var doubleJump:Bool = false;
		var leftP:Bool = false;
		var rightP:Bool = false;
		var jetpack:Bool = false;
		
		if (!isTumbling()) {
			tumbleTimer = -1;
			up = FlxG.keys.anyPressed([UP, W, SPACE]);
			down = FlxG.keys.anyPressed([DOWN, S]);
			left = FlxG.keys.anyPressed([LEFT, A]);
			right = FlxG.keys.anyPressed([RIGHT, D]);
			doubleJump = FlxG.keys.anyJustPressed([UP, W, SPACE]);
			
			leftP = FlxG.keys.anyJustPressed([LEFT, A]);
			rightP = FlxG.keys.anyJustPressed([RIGHT, D]);
			
			jetpack = FlxG.keys.anyPressed([SHIFT]);
		} else {
			tumble(FlxObject.NONE, elapsed);
		}
		
		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;
		
		if (!up && !down && !jetpack) {
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
		}
		
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
				} else if (right) {
					mA = 0;
					if (up) mA -= 45;
					else if (down) mA += 45;
					facing = FlxObject.RIGHT;
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
		if (FlxG.keys.anyJustPressed([J, K])) {
			if (facing == FlxObject.NONE) {
				attack(faced);
			} else {
				attack(facing);
			}
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
	
	private function attack(direction:Int):Void {
		var newBullet = new Bullet(x + 20, y + 20, 500, direction, 10);
		bulletArray.add(newBullet);
	}
	
}