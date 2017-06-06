package enemies;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import weapons.*;
import items.Coin;

class FinalBoss extends Enemy {
	private var dashTimer:Float;
	private var attack_count:Float;
	private var stay_count:Float;
	private var meleeDist:Int = 260;
    private var rangedDist:Int = 900;
	private var SECOND:Int = 60;
    private var countDown:Float = 60;
	
	private var attacked:Bool = false;

	private var bulletCount:Int = 0;
	private var fireTimer:Float = -1;
	private var fireTime:Float = 2.0;
	private var rate:Float = 0.1;
	private var rateTimer:Float = 0;

	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
					bulletArray:FlxTypedGroup<EnemyBullet>, 
					coinsGroup:FlxTypedGroup<Coin>,
					gravity:Float) {
		super(X, Y, id, bulletArray, coinsGroup, gravity, BOSS3);
		GRAVITY = gravity;

        //SPEED
        this.speed = 500;
		loadGraphic(AssetPaths.finalBoss__png, true, 1007, 702);
		scale.set(0.6, 0.6);
		setSize(120, 215);
		offset.set(445, 310);
		this.name = "Supreme Leader. Clint, Don";
		//cast(this, FlxObject).debugBoundingBoxColor = FlxColor.RED;
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [0], 1, false);
		animation.add("lr", [1,2,3,4,5,6,7], 24, false);
		animation.add("attack1", [8,9,10,11], 32, false);
        animation.add("attack2", [12,13,13,12], 32, false);
		animation.add("die", [20, 21, 22, 22, 22, 22, 22, 22, 22, 22, 22,
							22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22], 3, false);
		animation.play("stop");
		this.level = 0;

		acceleration.y = GRAVITY;
		health = 5000;
		facing = FlxObject.LEFT;
		playerPos = FlxPoint.get();
		brain = new EnemyFSM(turn);
		//stuck = false;
		dashTimer = 0;
		attack_count = 0;
		stay_count = 0;
		range = damage_dist;
		hurtTime = 0.10;
	}

    override public function update(elapsed:Float) {
        if(countDown > 0) {
            countDown -= elapsed;
        } else {
            countDown = 0;
        }

        super.update();
    }

    public function getTime():Float {
        return countDown;
    }

	public function stay(elapsed:Float):Void {
		//trace("stay!!!!!!!!!!!!!!");
		stay_count += elapsed;
		if (stay_count > 0.5) {
			stay_count = 0.0;
			brain.activeState = turn;
		}
	}

	public function judgeState(elapsed:Float):Void {
		//trace("judgeState!!!!!!!!!!!!!");
		if (playerPos.x <= getMidpoint().x && facing == FlxObject.LEFT
			|| playerPos.x > getMidpoint().x && facing == FlxObject.RIGHT) {
			brain.activeState = attack;
		} else {
			brain.activeState = turn;
		}
	}

	public function turn(elapsed:Float):Void {
		//trace("turn!!!!!!!!!!!");
		if (playerPos.x <= getMidpoint().x) {
			facing = FlxObject.LEFT;
		} else {
			facing = FlxObject.RIGHT;
		}
		if (Math.abs(playerPos.x - getMidpoint().x) <= damage_dist) {
			brain.activeState = attack;
		} else {
			brain.activeState = dash;
		}
	}


	// the state from raising weapon to run towards player
	public function dash(elapsed:Float):Void {
		//trace("dash!!!!!!!!!!!!!!!");
		if (facing == FlxObject.LEFT) {
			// facing left
			if (getMidpoint().x - playerPos.x <= 200) {
				brain.activeState = dash_attack;
			}
		} else {
			// facing right
			if (playerPos.x - getMidpoint().x <= 200) {
				brain.activeState = dash_attack;
			}
		}
		
		dash_count += elapsed;
		if (dash_count < 3.0) {
			// raising the sword
			velocity.x = 0;
			animation.play("raise");
		} else {
			animation.play("lr");
			//velocity.set(speed * 0.5, 0);
			if (facing == FlxObject.LEFT) {
				velocity.x = -speed * 18;
			} else if (facing == FlxObject.RIGHT) {
				velocity.x = speed * 18;
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
		stuck_count += elapsed;
		if (!attacked && stuck_count >= 0.25) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(getMidpoint().x, y + 100, 1000, facing, 
													30, range, Melee, this);
			attacked = true;
		}
		if (stuck_count >= 0.5) {
			stuck_count = 0;
			brain.activeState = stuck;
			attacked = false;
		}
	}

	// the state of attack in short dist: fast, low damaage
	public function attack(elapsed:Float):Void {
		// attack the enemy
		//trace("attack!!!!!!!1");
		animation.play("attack");
		
		attack_count += elapsed;
		if (!attacked && attack_count >= 0.4) {
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(getMidpoint().x, y + 100, 1000, facing, 15,
												range, Melee, this);
			attacked = true;
		}
		if (attack_count >= 0.66) {
			animation.finish();
			attack_count = 0.0;
			attacked = false;
			brain.activeState = judgeState;
		}
	}

	override public function hurt(damage:Float):Void {
		if (health - damage <= 0) {
			animation.play("die");
			alive = false;
		} 
		health -= damage;
		color = 0xff0000;
		hurtColorTimer = 0.0;
	}	
}