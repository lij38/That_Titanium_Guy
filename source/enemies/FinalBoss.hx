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
    private var mapWidth:Float;
	private var chargeTimer:Float;
	private var attackTimer:Float;
	private var stayTimer:Float;
	private var meleeDist:Int = 100;
    private var meleeNum:Int = 1;
    private var rangedDist:Int = 600;
	private var SECOND:Int = 60;
    private var countDown:Float = 60;

	private var caught:Bool = false;
	private var attacked:Bool = false;

    private var _catch_pos:FlxPoint;
    private var shootCount:Int = 0;
	private var bulletCount:Int = 0;
	private var fireTimer:Float = -1;
	private var fireTime:Float = 2.0;
	private var rate:Float = 0.1;
	private var rateTimer:Float = 0;
    private var pHud:HUD;

	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
					bulletArray:FlxTypedGroup<EnemyBullet>, 
					coinsGroup:FlxTypedGroup<Coin>,
					gravity:Float, mapWidth:Float, pHud:HUD) {
		super(X, Y, id, bulletArray, coinsGroup, gravity, BOSS3);
		GRAVITY = gravity;

        //SPEED
        this.speed = 500;
        //map width
        this.mapWidth = mapWidth;

        this.pHud = pHud;

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
        animation.add("charge", [1,2,3,4,5,6,7], 60, false);
		animation.add("attack1", [8,9,10,11], 32, false);
        animation.add("attack2", [12,13,13,12], 32, false);
		animation.add("die", [0], 0.5, false);
		animation.play("stop");
		this.level = 0;

        _catch_pos = new FlxPoint(_player.x, _player.y);
		acceleration.y = GRAVITY;
		health = 5000;
		facing = FlxObject.LEFT;
		playerPos = FlxPoint.get();
		brain = new EnemyFSM(turn);
		chargeTimer = 0;
		attackTimer = 0;
		stayTimer = 0;
		range = meleeDist;
		hurtTime = 0.10;
	}

    override public function update(elapsed:Float) {
        if(countDown > 0) {
            countDown -= elapsed;
        } else {
            countDown = 0;
        }
        if(chargeTimer >= 20) {
            brain.activeState = charge;
            chargeTimer = 0;
        } else {
            chargeTimer += elapsed;
        }
        super.update();
    }

    public function getTime():Float {
        return countDown;
    }

	public function stay(elapsed:Float):Void {
		//trace("stay!!!!!!!!!!!!!!");
		stayTimer += elapsed;
		if (stayTimer > 0.5) {
			stayTimer = 0.0;
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
		// switch to other states based on player dist
		if(playerPos.y > this.y) {
            brain.activeState = ranged;
        } else if (Math.abs(playerPos.x - getMidpoint().x) <= meleeDist) {
			brain.activeState = melee;
		} else if (Math.abs(playerPos.x - getMidpoint().x) <= rangedDist) {
			brain.activeState = walk;
		} else {
            brain.activateState = ranged;
        }
	}

    // the state of attack in short dist: fast, low damaage
	public function melee(elapsed:Float):Void {
		// attack the enemy
		//trace("attack!!!!!!!1")
		attackTimer += elapsed;
		if (!attacked && attackTimer > 0) {
            if(meleeNum == 1) {
                animation.play("attack1");
                meleeNum = 2;
            } else {
                animation.play("attack2");
                meleeNum = 1;
            }
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(getMidpoint().x, y + 100, 1000, facing, 20,
												range, Melee, this);
			attacked = true;
		}
		if (attackTimer >= 0.12) {
			attackTimer = 0.0;
			attacked = false;
			brain.activeState = judgeState;
		}
	}

    //shoot at players from afar
    public function ranged(elapsed:Float):Void {
		//trace("shoot!!!!!!!!!!");
		// stop all actions
        _catch_pos.x = _player.x;
        _catch_pos.y = _player.y;
        var shootPoint = new FlxPoint(this.getMidpoint().x, this.y);
        var angle:Float = angles(shootPoint, _catch_pos) * 360 / (2 * 3.14159265358);

		velocity.x = 0;
		animation.play("stop");

		shootCount ++;
		if (shootCount == 5) {
			if (facing == FlxObject.LEFT) {
                var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
                curBullet.setBullet(x, y, 2000, angle, 15, range, SKULL, this);
	            }
	        }
	        if (facing == FlxObject.RIGHT) {
                var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
                curBullet.setBullet(x, y, 2000, angle % 360, 15, range, SKULL, this);
	        }
		}
		// stop a bit after shoot
		if (shootCount > 100) {
			shootCount = 0;
			brain.activeState = judgeState;
		}

		if (facing == FlxObject.LEFT) {
			// facing left
			if (getMidpoint().x - playerPos.x <= attack_dist) {
				brain.activeState = melee;
			}
		} else {
			// facing right
			if (playerPos.x - getMidpoint().x <= attack_dist) {
				brain.activeState = melee;
			}
		}
	}

	// the state from raising weapon to run towards player
	public function charge(elapsed:Float):Void {
		//trace("charge!!!!!!!!!!!!!!!");
		if (caught) {
			_player.freeze = true;
			_player.x = this.x;
			_player.y = this.y;
		} else {
			if (FlxG.overlap(_player, this)) {
				//_player.freeze = true;
				caught = true;
			}
		}
		
        if (this.x <= 30 || this.x >= _mapWidth - this.width - 30) {
            if(caught) {
                _player.hurt(40);
                _player.stun();
                _pHud.startDaze();
                caught = false;
                _player.freeze = false;
            }
            brain.activeState = turn;
        }

        animation.play("lr");
        if (facing == FlxObject.LEFT) {
            velocity.x = -speed * 3.5;
        } else if (facing == FlxObject.RIGHT) {
            velocity.x = speed * 3.5;
        }
	}

	override public function hurt(damage:Float):Void {
		if (health - damage <= 0) {
            visible = false;
			animation.play("die");
			alive = false;
		} 
		health -= damage;
		color = 0xff0000;
		hurtColorTimer = 0.0;
	}	

    private function angles(Source:FlxPoint, Target:FlxPoint):Float
	{
		var dx:Float = (Target.x) - (Source.x);
		var dy:Float = (Target.y) - (Source.y);
		
		Target.putWeak();
		
		return Math.atan2(dy, dx);
	}
}