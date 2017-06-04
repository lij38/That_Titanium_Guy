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
import flixel.FlxG;
import flixel.math.FlxAngle;

class Boss2 extends Enemy {
	// timing variables
	private var attack_count:Float;
	private var stay_count:Float;
	private var shoot_count:Int;
	private var catch_count:Int;

	// distances
	private var attack_dist:Int = 300;
	private var shoot_dist:Int = 550;
	private var catch_dist:Int = 1000;

	private var SECOND:Int = 60;

	private var bulletCount:Int = 0;
	private var fireTimer:Float = -1;
	private var fireTime:Float = 2.0;
	private var rate:Float = 0.1;
	private var rateTimer:Float = 0;

	private var _hand:Boss2Hand;
	private var _in_catch:Bool;
	private var _in_attack:Bool;
	private var _player:Player;
	private var _catch_pos:FlxPoint;
	private var _catch_player:Bool;

	public function new(X:Float=0, Y:Float=0, id:Int = -1,
					bulletArray:FlxTypedGroup<EnemyBullet>, 
					coinsGroup:FlxTypedGroup<Coin>, 
					gravity:Float, hand:Boss2Hand, player:Player) {

		super(X, Y, id, bulletArray, coinsGroup, gravity, BOSS2);
		GRAVITY = gravity;
		_hand = hand;
		_player = player;
		this.name = "MAJ. Beat, Dead";

		loadGraphic(AssetPaths.boss2__png, true, 534, 302);
		setSize(275, 272);
		offset.set(145, 15);
		
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [4], 5, false);
		animation.add("lr", [9, 10, 1, 2, 3, 4], 8, true);
		animation.add("catch_start", [5, 6, 7, 8], 4, true);
		animation.add("catch_end", [8, 7, 6, 5], 4, true);
		animation.add("die", [0, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
			12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12], 4, false);

		animation.play("stop");

		acceleration.y = GRAVITY;
		health = 1150;
		facing = FlxObject.LEFT;
		playerPos = FlxPoint.get();
		brain = new EnemyFSM(turn);
		attack_count = 0.0;
		stay_count = 0;
		shoot_count = 0;
		catch_count = 0;
		range = 650;
		_hand.visible = false;
		_in_catch = false;
		_in_attack = false;
		hurtTime = 0.10;
	}

	override public function update(elapsed:Float):Void {
		if (!_in_catch && !_in_attack) {
			_hand.x = x - 20;
			_hand.y = y + 120;
		}
		
		if (!alive) {
			velocity.set(0, 0);
			super.update(elapsed);
			return;
		} else {
			brain.update(elapsed);
		}
		_hand.facing = facing;
		
		super.update(elapsed);
	}

	public function stay(elapsed:Float):Void {
		//trace("stay!!!!!!!!!!!!!!");
		stay_count += elapsed;
		if (stay_count > 0.4) {
			stay_count = 0.0;
			brain.activeState = turn;
		}
	}

	public function judgeState(elapsed:Float):Void {
		//trace("judgeState!!!!!!!!!!!!!");
		if (playerPos.x <= getMidpoint().x && facing == FlxObject.LEFT
			|| playerPos.x > getMidpoint().x && facing == FlxObject.RIGHT) {
			brain.activeState = turn;
		} else {
			brain.activeState = stay;
		}
	}

	public function turn(elapsed:Float):Void {
		//trace("turn!!!!!!!!!!!");
		// make turn
		if (playerPos.x <= getMidpoint().x) {
			facing = FlxObject.LEFT;
		} else {
			facing = FlxObject.RIGHT;
		}

		// switch to other states based on player dist
		if (Math.abs(playerPos.x - getMidpoint().x) <= attack_dist) {
			brain.activeState = attack_start;
		} else if (Math.abs(playerPos.x - getMidpoint().x) <= shoot_dist) {
			brain.activeState = shoot;
		} else if (Math.abs(playerPos.x - getMidpoint().x) <= catch_dist) {
			brain.activeState = walk;
		} else {
			_catch_pos = new FlxPoint(_player.x, _player.y);
			brain.activeState = catch_start;
		}
	} 

	public function walk(elapsed:Float):Void {
		//trace("walk!!!!!!!!!!!!!!!");
		animation.play("lr");
		if (facing == FlxObject.LEFT) {
			// facing left
			if (getMidpoint().x - playerPos.x <= shoot_dist) {
				brain.activeState = shoot;
			}
			if (getMidpoint().x - playerPos.x >= catch_dist) {
				brain.activeState = catch_start;
				_catch_pos = new FlxPoint(_player.x, _player.y);
			}
		} else {
			// facing right
			if (playerPos.x - getMidpoint().x <= shoot_dist) {
				brain.activeState = shoot;
			}
			if (playerPos.x - getMidpoint().x >= catch_dist) {
				brain.activeState = catch_start;
				_catch_pos = new FlxPoint(_player.x, _player.y);
			}
		}

		if (facing == FlxObject.LEFT) {
			velocity.x = -speed * 5;
		} else if (facing == FlxObject.RIGHT) {
			velocity.x = speed * 5;
		}
	}

	public function attack_start(elapsed:Float):Void {
		//trace("attack start!!!!!!!!!!!!!!!!");
		animation.play("catch_start");
		attack_count += elapsed;
		if (attack_count > 1.0) {
			animation.finish();
			_hand.visible = true;
			_in_attack = true;
			brain.activeState = attack;
			attack_count = 0.0;
			if (_hand.facing == FlxObject.LEFT) {
				_hand.velocity.x = -speed * 6;
			} else {
				_hand.velocity.x = speed * 6;
			}
		}
	}

	public function attack(elapsed:Float):Void {
		// attack the enemy
		//trace("attack!!!!!!!");
		//attack_count++;
		_hand.velocity.y = 0;
		if (_hand.facing == FlxObject.LEFT) {
			_hand.velocity.x = -speed * 6;
		} else {
			_hand.velocity.x = speed * 6;
		}
		if (_hand.facing == FlxObject.LEFT && _hand.x < x - 300) {
			_hand.velocity.x = 0;
			brain.activeState = attack_end;
			
		} else if (_hand.facing == FlxObject.RIGHT && _hand.x > x + 300){
			_hand.velocity.x = 0;
			brain.activeState = attack_end;
		}

		if (FlxG.overlap(_player, _hand)) {
			if(!_player.isShielding()) {
				_player.hurt(20);
			}			
			brain.activeState = attack_end;
			if (_hand.facing == FlxObject.LEFT) {
				_player.x -= 100;
			} else {
				_player.x += 100;
			}
		}
	}

	public function attack_end(elapsed:Float):Void {
		//trace("attack end!!!!!!!!!!!!!!!!!!");
		//_hand.velocity.x = 0;
		animation.play("catch_end");
		attack_count += elapsed;
		if (attack_count > 1.0) {
			_hand.visible = false;
			_in_attack = false;
			animation.finish();
			//brain.activeState = judgeState;
			//attack_count = 0;
		} 

		if (attack_count > 1.2) {
			brain.activeState = judgeState;
			attack_count = 0;
		}
	}

	public function shoot(elapsed:Float):Void {
		//trace("shoot!!!!!!!!!!");
		// stop all actions
		velocity.x = 0;
		animation.play("stop");

		shoot_count ++;
		if (shoot_count == 10) {
			if (facing == FlxObject.LEFT) {
	            var angle:Int = 135;
	            for(i in 0...5) {
	            	var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
	                curBullet.setBullet(x - 150, y + 125, 550, angle, 15, range, SHOTGUN, this);
	                angle += 18;
	            }
	        }
	        if (facing == FlxObject.RIGHT) {
	            var angle:Int = 315;
	            for(i in 0...5) {
	            	var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
	                curBullet.setBullet(x + 350, y + 125, 550, angle % 360, 15, range, SHOTGUN, this);
	                angle += 18;
	            }
	        }
		}
		// stop a bit after shoot
		if (shoot_count > 130) {
			shoot_count = 0;
			brain.activeState = judgeState;
		}

		if (facing == FlxObject.LEFT) {
			// facing left
			if (getMidpoint().x - playerPos.x <= attack_dist) {
				brain.activeState = attack_start;
			}
		} else {
			// facing right
			if (playerPos.x - getMidpoint().x <= attack_dist) {
				brain.activeState = attack_start;
			}
		}
	}

	public function catch_start(elapsed:Float):Void {
		//trace("catch start!!!!!!!!!!!!!!!!!!!");
		velocity.x = 0;
		catch_count ++;

		// play animation: emit hand
		if (catch_count < 60) {
			animation.play("catch_start");

		} else if (catch_count == 60) {
			animation.finish();

			// hand moves to catch pos
			_hand.visible = true;
			_in_catch = true;
			moveTowardsPoint(_hand, _hand.getMidpoint(), _catch_pos, Std.int(speed * 18));
		} else {

			// catch the player and return
			if (FlxG.overlap(_player, _hand)) {
				_catch_player = true;
				_player.freeze = true;
				catch_count = 0;
				brain.activeState = catch_process;
				return;
			}

			// return when reached point and not catch the player
			var point1 = _hand.getMidpoint();
			if (dist(_catch_pos, point1) < 10) {
				catch_count = 0;
				_hand.velocity.x = 0;
				_hand.velocity.y = 0;
				brain.activeState = catch_stop;
			}
		}
		
	}

	public function catch_stop(elapsed:Float):Void {
		catch_count++;
		if (catch_count > 180) {
			brain.activeState = catch_process;
			catch_count = 0;
		}
	}

	

	public function catch_process(elapsed:Float):Void {
		_in_catch = true;
		var point1 = _hand.getMidpoint();
		//trace("catched>>>>>>>>>>>>.");
		// if catched, player moves with the hand
		if (_catch_player) {
			_player.freeze = true;
			_player.x = _hand.x;
			_player.y = _hand.y;
		} else {
			if (FlxG.overlap(_player, _hand)) {
				//_player.freeze = true;
				_catch_player = true;
			}
		}
		var point2 = new FlxPoint(x, y);
		if (facing == FlxObject.LEFT) {
			moveTowardsPoint(_hand, _hand.getMidpoint(), new FlxPoint(x - 200, y + 125), Std.int(speed * 12));
			point2.x = x - 200;
			point2.y = y + 125;
		} else {
			moveTowardsPoint(_hand, _hand.getMidpoint(), new FlxPoint(x + 450, y + 125), Std.int(speed * 12));
			point2.x = x + 450;
			point2.y = y + 125;
		}
		if (dist(point1, point2) < 20) {
			_player.freeze = false;
			brain.activeState = catch_back;
			_in_catch = false;
			_catch_player = false;
		}
	}

	public function catch_back(elapsed:Float):Void {
		//trace("catch end!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		catch_count ++;
		animation.play("catch_end");
		_hand.visible = false;
		if (catch_count > 60) {
			animation.finish();
			brain.activeState = judgeState;
			catch_count = 0;
		}
	}

	override public function hurt(damage:Float):Void {
		if (health - damage <= 0) {
			animation.play("die");
			alive = false;
		} //else {
			//animation.play("hurt");
			//hurtTimer = 0;
		//}
		health -= damage;
		color = 0xff0000;
		hurtColorTimer = 0.0;
	}

	// helper funcitons
	private function dist(p1:FlxPoint, p2:FlxPoint):Float {
		return Math.sqrt(Math.pow((p1.x-p2.x), 2) + Math.pow((p1.y-p2.y), 2));
	}

	private function moveTowardsPoint(object:FlxSprite, Source:FlxPoint, Target:FlxPoint, Speed:Float):Void
	{
		var a:Float = angleBetweenPoint(Source, Target);
		
		object.velocity.x = Math.cos(a) * Speed;
		object.velocity.y = Math.sin(a) * Speed;
		
		Target.putWeak();
		Source.putWeak();
	}

	private function angleBetweenPoint(Source:FlxPoint, Target:FlxPoint):Float
	{
		var dx:Float = (Target.x) - (Source.x);
		var dy:Float = (Target.y) - (Source.y);
		
		Target.putWeak();
		
		return Math.atan2(dy, dx);
	}
	
}