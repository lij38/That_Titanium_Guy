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
	private var rifle:Rifle;
	private var laser:Laser;
	private var shotgun:Shotgun;
	private var sword:Sword;

	public function new(?X:Float=0, ?Y:Float=0, playerBulletArray:FlxTypedGroup<Bullet>) {
		super(X, Y);
		//makeGraphic(16, 16, FlxColor.BLUE);
		loadGraphic(AssetPaths.player__png, true, 16, 16);
		scale.set(4, 4);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		animation.add("stop", [3], 1, false);
		//drag.x = drag.y = 1600;
		setSize(40, 50);
		offset.set( -10, -15);
		
		acceleration.y = gravity;
		
		rifle = new Rifle(playerBulletArray);
		laser = new Laser(playerBulletArray);
		shotgun = new Shotgun(playerBulletArray);
		sword = new Sword(playerBulletArray);
	}
	
	override public function update(elapsed:Float):Void {
		movement(elapsed);
		super.update(elapsed);
	}
	
	private function movement(elapsed:Float):Void {
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		var doubleJump:Bool = false;
		
		
		up = FlxG.keys.anyPressed([UP, W, SPACE]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		doubleJump = FlxG.keys.anyJustPressed([UP, W, SPACE]);
		
		var jetpack:Bool = false;
		jetpack = FlxG.keys.anyPressed([SHIFT]);
		
		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;
		
		if (jetpack) {
			
		}
		
		
		
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
		// if the player is moving (velocity is not 0), we need to change the
		// animation to match their facing
		switch (facing) {
			case FlxObject.LEFT, FlxObject.RIGHT:
				animation.play("lr");
			case FlxObject.UP:
				animation.play("u");
			case FlxObject.DOWN:
				animation.play("d");
			case FlxObject.NONE:
				animation.play("stop");
		}
		
		if (FlxG.keys.anyJustPressed([J])) {
			if (facing == FlxObject.NONE) {
				sword.attack(x, y, faced);
			} else {
				sword.attack(x, y, facing);
			}
		}
		if (FlxG.keys.anyJustPressed([K])) {
			if (facing == FlxObject.NONE) {
				shotgun.attack(x, y, faced);
			} else {
				shotgun.attack(x, y, facing);
			}
		}
	}
}