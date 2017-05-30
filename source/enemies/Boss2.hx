package enemies;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import weapons.*;
import items.*;
import flixel.FlxSprite;
import flixel.math.FlxVelocity;

class Boss2 extends Enemy {
	//public var stuck:Bool;
	private var dash_count:Int;
	private var stuck_count:Int;
	private var attack_count:Int;
	private var stay_count:Int;
	private var shoot_count:Int;
	private var damage_dist:Int = 400;
	private var SECOND:Int = 60;

	private var bulletCount:Int = 0;
	private var fireTimer:Float = -1;
	private var fireTime:Float = 2.0;
	private var rate:Float = 0.1;
	private var rateTimer:Float = 0;

	private var _hand:Boss2Hand;

	public function new(X:Float=0, Y:Float=0, id:Int = -1,
					bulletArray:FlxTypedGroup<EnemyBullet>, 
					coinsGroup:FlxTypedGroup<Coin>, 
					gravity:Float, hand:Boss2Hand) {
		super(X, Y, id, bulletArray, coinsGroup, gravity, BOSS);
		GRAVITY = gravity;

		setSize(120, 200);
		makeGraphic(120, 200, FlxColor.WHITE);

		_hand = hand;


		loadGraphic(AssetPaths.boss2__png, true, 536, 272);
		//scale.set(0.7, 0.7);
		setSize(250, 272);
		offset.set(150, 0);
		//debugBoundingBoxColor = FlxColor.RED;
		

		cast(this, FlxObject).debugBoundingBoxColor = FlxColor.RED;
		//makeGraphic(120, 200, FlxColor.WHITE);
		
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [4], 1, false);
		//animation.add("raise", [0, 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 
			//5, 5, 5, 5, 5, 5, 5, 5, 5], 3, false, false, false);
		animation.add("lr", [8, 9, 0, 1, 2, 3], 4, true);
		//animation.add("stuck_attack", [13, 14, 15, 16, 17, 18], 12, false);
		//animation.add("stuck", [18], 1, false);
		//animation.add("stuck_stop", [18, 19, 20], 3, false);
		//animation.add("attack", [0, 1, 2, 3, 4, 13, 14, 15, 16, 17], 9, false);
		//animation.add("die", [20, 21, 22, 22, 22, 22, 22, 22], 3, false);

		animation.play("stop");

		acceleration.y = GRAVITY;
		health = 800;
		facing = FlxObject.LEFT;
		playerPos = FlxPoint.get();
		brain = new EnemyFSM(turn);
		//stuck = false;
		dash_count = 0;
		stuck_count = 0;
		attack_count = 0;
		stay_count = 0;
		shoot_count = 0;
		range = 300;
	}

	override public function update(elapsed:Float):Void {
		//if (health < 0 && animation.finished) {
			//kill();
		//}

		_hand.x = x - 20;
		_hand.y = y + 120;
		
		if (!alive) {
			velocity.set(0, 0);
			super.update(elapsed);
			return;
		} else {
			brain.update(elapsed);
		}
		
		super.update(elapsed);
	}

	public function stay(elapsed:Float):Void {
		trace("stay!!!!!!!!!!!!!!");
		stay_count++;
		if (stay_count > 60) {
			stay_count = 0;
			brain.activeState = turn;
		}
	}

	public function judgeState(elapsed:Float):Void {
		trace("judgeState!!!!!!!!!!!!!");
		if (playerPos.x <= getMidpoint().x && facing == FlxObject.LEFT
			|| playerPos.x > getMidpoint().x && facing == FlxObject.RIGHT) {
			brain.activeState = turn;
		} else {
			brain.activeState = stay;
		}
	}

	public function turn(elapsed:Float):Void {
		trace("turn!!!!!!!!!!!");
		if (playerPos.x <= getMidpoint().x) {
			facing = FlxObject.LEFT;
		} else {
			facing = FlxObject.RIGHT;
		}
		//stuck_count = 0;
		if (Math.abs(playerPos.x - getMidpoint().x) <= damage_dist) {
			brain.activeState = shoot;
		} else {
			brain.activeState = walk;
		}
		
	} 

	public function walk(elapsed:Float):Void {
		trace("walk!!!!!!!!!!!!!!!");
		animation.play("lr");
		if (facing == FlxObject.LEFT) {
			// facing left
			if (getMidpoint().x - playerPos.x <= 300) {
				brain.activeState = shoot;
			}
		} else {
			// facing right
			if (playerPos.x - getMidpoint().x <= 300) {
				brain.activeState = shoot;
			}
		}

		if (facing == FlxObject.LEFT) {
			velocity.x = -speed;
		} else if (facing == FlxObject.RIGHT) {
			velocity.x = speed;
		}
	}

	public function attack(elapsed:Float):Void {
		// attack the enemy
		trace("attack!!!!!!!");
		attack_count++;
		if (attack_count == 54) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(x, y + 120, 250, facing, 15, range, Melee);
		}
		if (attack_count > 67) {
			//animation.finish();
			attack_count = 0;
			brain.activeState = judgeState;
		}
	}

	public function shoot(elapsed:Float):Void {
		trace("shoot!!!!!!!!!!");
		velocity.x = 0;
		animation.play("stop");
		shoot_count++;
		if (shoot_count == 54) {
			if (facing == FlxObject.LEFT) {
	            var angle:Int = 165;
	            for(i in 0...5) {
	            	var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
	                curBullet.setBullet(x - 125, y + 120, 250, angle, 15, range, SHOTGUN);
	                angle += 6;
	            }
	        }
	        if (facing == FlxObject.RIGHT) {
	            var angle:Int = 345;
	            for(i in 0...5) {
	            	var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
	                curBullet.setBullet(x + 125, y + 120, 250, angle % 360, 15, range, SHOTGUN);
	                angle += 6;
	            }
	        }
		}
		if (shoot_count > 67) {
			shoot_count = 0;
			brain.activeState = judgeState;
		}
	}

/*
	public function catch_start(elapsed:Float):Void {
		FlxVelocity.moveTowardsPoint(catcher, playerPos, Std.int(speed));
		brain.activeState = catch_process;
	}

	public function dist(p1:FlxPoint, p2:FlxPoint):Float {
		return Math.sqrt(Math.pow((p1.x-p2.x), 2) + Math.pow((p1.y-p2.y), 2));
	}

	public function catch_process(elapsed:Float):Void {
		var point1 = catcher.getMidpoint();
		if (dist(point1, playerPos) < 10) {
			trace("catched>>>>>>>>>>>>.");
			FlxVelocity.moveTowardsPoint(catcher, new FlxPoint(x, y), Std.int(speed));
			brain.activeState = catch_back;
		}
	}

	public function catch_back(elapsed:Float):Void {
		brain.activeState = walk;
	}
	*/

	/*



	// the state from raising weapon to run towards player
	public function dash(elapsed:Float):Void {
		//trace("dash!!!!!!!!!!!!!!!");
		if (facing == FlxObject.LEFT) {
			// facing left
			if (getMidpoint().x - playerPos.x <= 100) {
				brain.activeState = dash_attack;
			}
		} else {
			// facing right
			if (playerPos.x - getMidpoint().x <= 100) {
				brain.activeState = dash_attack;
			}
		}
		
		dash_count++;
		if (dash_count < SECOND * 7) {
			// raising the sword
			velocity.x = 0;
			animation.play("raise");
		} else {
			animation.play("lr");
			//velocity.set(speed * 0.5, 0);
			if (facing == FlxObject.LEFT) {
				velocity.x = -speed * 11;
			} else if (facing == FlxObject.RIGHT) {
				velocity.x = speed * 11;
			}
			//FlxVelocity.moveTowardsPoint(this, playerPos, Std.int(speed));
		}
		

	}

	// the state of attacking until stuck, high damage attack
	public function dash_attack(elapsed:Float):Void {
		//trace("stuck_attack!!!!!!!!");
		animation.play("stuck_attack");
		dash_count = 0;
		velocity.x = 0;
		stuck_count++;
		if (stuck_count == 15) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(x, y + 120, 250, facing, 30, range, Melee);
		}
		if (stuck_count > 30) {
			stuck_count = 0;
			brain.activeState = stuck;
		}
	}

	// the state of stuck on the ground
	public function stuck(elapsed:Float):Void {
		//trace("stuck!!!!!!!!");
		animation.play("stuck");
		stuck_count++;
		if (stuck_count > 120) {
			stuck_count = 0;
			brain.activeState = stuck_stop;
		}
	}

	// the state after stuck: pick up weapon
	public function stuck_stop(elapsed:Float):Void {
		//trace("stuck_stop!!!!!!!!");
		animation.play("stuck_stop");
		stuck_count++;
		if (stuck_count > 60) {
			stuck_count = 0;
			brain.activeState = turn;
		}
	}

	// the state of attack in short dist: fast, low damaage
	public function attack(elapsed:Float):Void {
		// attack the enemy
		//trace("attack!!!!!!!1");
		animation.play("attack");
		
		attack_count++;
		if (attack_count == 54) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(x, y + 120, 250, facing, 15, range, Melee);
		}
		if (attack_count > 67) {
			animation.finish();
			attack_count = 0;
			brain.activeState = judgeState;
		}
	}

	override public function hurt(damage:Float):Void {
		if (health - damage < 0) {
			animation.play("die");
			alive = false;
		} //else {
			//animation.play("hurt");
			//hurtTimer = 0;
		//}
		health -= damage;
	}
	*/
	
}