package;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class SmallBoss extends Enemy {
	public var stuck:Bool;
	private var dash_count:Int;
	private var stuck_count:Int;
	private var attack_count:Int;
	private var damage_dist:Int = 20;
	public var inDash:Bool;

	public function new(X:Float=0, Y:Float=0, gravity:Float) {
		//super(X, Y);
		super(X, Y, gravity);
		GRAVITY = gravity;
		//loadGraphic(AssetPaths.v__png, true, 552, 381);
		
		//scale.set(0.3, 0.3);
		//setSize(47, 109);
		//offset.set(240, 130);
		//width = 100;
		//height = 50;
		makeGraphic(500, 200, FlxColor.RED);
		
		//setFacingFlip(FlxObject.LEFT, false, false);
		//setFacingFlip(FlxObject.RIGHT, true, false);
		
		//animation.add("stop", [6], 1, false);
		//animation.add("lr", [0, 1, 2, 3, 4, 5], 9, false);
		//animation.add("hurt", [8, 8, 6], 9, false);
		//animation.add("die", [8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10], 9, false);
		//animation.play("stop");
		
		acceleration.y = GRAVITY;
		health = 500;
		facing = FlxObject.LEFT;
		playerPos = FlxPoint.get();
		brain = new EnemyFSM(turn);
		stuck = false;
		dash_count = 0;
		stuck_count = 0;
		attack_count = 0;
		inDash = false;
		
	}

	public function turn():Void {
		trace("turn!!!!!!!!!!!");
		if (playerPos.x <= getMidpoint().x) {
			//velocity.x = -speed;
			facing = FlxObject.LEFT;
		} else {
			facing = FlxObject.RIGHT;
			//velocity.x = speed;
		}
		stuck = false;
		stuck_count = 0;
		//attack_count = 0;
		inDash = false;
		if (Math.abs(playerPos.x - getMidpoint().x) <= damage_dist) {
			brain.activeState = attack;
		} else {
			brain.activeState = dash;
		}
		//animation.play("lr");
	}

	public function dash():Void {
		trace("dash!!!!!!!!!!!!!!!");
		inDash = true;
		if (stuck) {
			dash_count = 0;
			velocity.x = 0;
			stuck_count++;
			if (stuck_count > 10) {
				brain.activeState = turn;
			}

		} else {
			dash_count++;
			if (dash_count < 10) {
				//play the holding sword animation
			} else {
				//velocity.set(speed * 0.5, 0);
				if (facing == FlxObject.LEFT) {
					velocity.x = -speed;
				} else if (facing == FlxObject.RIGHT) {
					velocity.x = speed;
				}
				//FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
			}
		}

	}

	public function attack():Void {
		inDash = false;
		// attack the enemy
		trace("attack!!!!!!!1");
		attack_count++;
		if (attack_count > 10) {
			attack_count = 0;
			brain.activeState = turn;
		}
	}
	
}