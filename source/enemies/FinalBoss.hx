package enemies;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.effects.FlxFlicker;
import weapons.*;
import items.Coin;

class FinalBoss extends Enemy {
    private var mapWidth:Float;
	private var chargeTimer:Float = 10;
	private var attackTimer:Float = 0;
	private var stayTimer:Float = 0;
	private var meleeDist:Int = 200;
    private var meleeNum:Int = 0;
    private var rangedDist:Int = 700;
	private var SECOND:Int = 60;
    private var countDown:Float = 120;

    private var _player:Player;
	private var caught:Bool = false;
	private var attacked:Bool = false;
	private var stayed:Bool = false;
	private var stayTime:Float = 1;
	private var rampage:Bool = false;

    private var _catch_pos:FlxPoint;
    private var shootCount:Int = 0;
    private var shootTimer:Float = 0;
	private var bulletCount:Int = 0;
	private var fireTimer:Float = -1;
	private var fireTime:Float = 2.0;
	private var rate:Float = 0.1;
	private var rateTimer:Float = 0;
    private var pHud:HUD;

	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
					bulletArray:FlxTypedGroup<EnemyBullet>, 
					coinsGroup:FlxTypedGroup<Coin>,
					gravity:Float, mapWidth:Float, pHud:HUD, player:Player) {
		super(X, Y, id, bulletArray, coinsGroup, gravity, BOSS3);
		GRAVITY = gravity;
        _player = player;
        //SPEED
        this.speed = 300;
        //map width
        this.mapWidth = mapWidth;

        this.pHud = pHud;

		loadGraphic(AssetPaths.finalBoss__png, true, 399, 387);
		setSize(140, 297);
		offset.set(130, 78);
		this.name = "Supreme Leader. Clint, Don";
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [0], 1, false);
		animation.add("lr", [1,2,3,4,5,6], 12, false);
        animation.add("charge", [11], 1, false);
		animation.add("rampage", [13], 1, false);
		animation.add("attack1", [8,9,10,11], 16, false);
        animation.add("attack2", [12,12,13,13], 16, false);
		animation.add("die", [0, 0, 0, 0, 0, 0], 1, false);
		animation.play("stop");
		this.level = 0;

        _catch_pos = new FlxPoint(_player.x, _player.y);
		health = 5000;
		facing = FlxObject.LEFT;
		playerPos = FlxPoint.get();
		brain = new EnemyFSM(turn);
		range = meleeDist;
		hurtTime = 0.10;
	}

    override public function update(elapsed:Float) {
        if(countDown > 0) {
            countDown -= elapsed;
        } else {
            countDown = 0;
        }
		if (chargeTimer <= stayTime * 20) {
			chargeTimer += elapsed;
		}
		if (countDown == 0 && !rampage) {
			rampage = true;
			speed *= 2;
			stayTime /= 2;
			velocity.x = 0;
			brain.activeState = chargeRampage;
		}
        super.update(elapsed);
    }

    public function getTime():Float {
        return countDown;
    }

	public function stay(elapsed:Float):Void {
		//trace("stay!!!!!!!!!!!!!!");
		stayTimer += elapsed;
		if (stayTimer > stayTime) {
			stayTimer = 0.0;
			brain.activeState = turn;
		}
		stayed = false;
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
		if (playerPos.x <= getMidpoint().x) {
			facing = FlxObject.LEFT;
		} else {
			facing = FlxObject.RIGHT;
		}
		
        if (chargeTimer >= stayTime * 20) {
            brain.activeState = charge;
            chargeTimer = 0;
			return;
        }
		// switch to other states based on player dist
		if (playerPos.y < this.y) {
            brain.activeState = ranged;
        } else if (Math.abs(playerPos.x - getMidpoint().x) <= meleeDist) {
			brain.activeState = melee;
		} else if (Math.abs(playerPos.x - getMidpoint().x) <= rangedDist) {
			brain.activeState = walk;
		} else {
            brain.activeState = ranged;
        }
	}

    // the state of attack in short dist: fast, low damaage
	public function melee(elapsed:Float):Void {
		// attack the enemy
		//trace("attack!!!!!!!1")
		attackTimer += elapsed;
		if (!attacked && attackTimer > 0) {
            if(meleeNum == 0 || meleeNum == 2) {
                animation.play("attack1");
            } else if (meleeNum == 1 || meleeNum == 3) {
                animation.play("attack2");
            }
			meleeNum = (meleeNum + 1) % 4;
			var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
			curBullet.setBullet(getMidpoint().x, y, 1000, facing, 20,
												meleeDist, BOSSMELEE, this);
			attacked = true;
		}
		if (attackTimer >= 0.25) {
			attackTimer = 0.0;
			attacked = false;
			if (meleeNum == 0) {
				brain.activeState = turn;
			}
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

		shootTimer += elapsed;
		if (shootTimer > 0.15) {
			if (facing == FlxObject.LEFT) {
                var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
                curBullet.setBullet(x, y, 250, cast(angle, Int), 15, 2000, SKULL, this);
	        }
	        if (facing == FlxObject.RIGHT) {
                var curBullet:EnemyBullet = bulletArray.recycle(EnemyBullet);
                curBullet.setBullet(x, y, 250, cast(angle, Int) % 360, 15, 2000, SKULL, this);
	        }
            shootTimer = 0;
            shootCount++;
		}
		// stop a bit after shoot
		if (shootCount > 10) {
			shootCount = 0;
			brain.activeState = judgeState;
		}

		if (facing == FlxObject.LEFT) {
			// facing left
			if (getMidpoint().x - playerPos.x <= meleeDist) {
				brain.activeState = melee;
			}
		} else {
			// facing right
			if (playerPos.x - getMidpoint().x <= meleeDist) {
				brain.activeState = melee;
			}
		}
	}

    public function walk(elapsed:Float):Void {
		//trace("walk!!!!!!!!!!!!!!!");
		animation.play("lr");
		if (facing == FlxObject.LEFT) {
			// facing left
			if (getMidpoint().x - playerPos.x <= meleeDist) {
				brain.activeState = melee;
			}
			if (getMidpoint().x - playerPos.x >= rangedDist) {
				brain.activeState = ranged;
			}
		} else {
			// facing right
			if (playerPos.x - getMidpoint().x <= meleeDist) {
				brain.activeState = melee;
			}
			if (playerPos.x - getMidpoint().x >= rangedDist) {
				brain.activeState = ranged;
			}
		}

		if (facing == FlxObject.LEFT) {
			velocity.x = -speed;
		} else if (facing == FlxObject.RIGHT) {
			velocity.x = speed;
		}
	}

	// the state from raising weapon to run towards player
	public function charge(elapsed:Float):Void {
		if (!stayed) {
			stayTimer += elapsed;
			animation.play("charge");
			FlxFlicker.flicker(this, stayTime * 2, 0.10, true, false);
		}
		if (!stayed && stayTimer < stayTime * 2) {
			return;
		}
		if (!stayed && stayTimer > stayTime * 2) {
			stayTimer = 0.0;
			stayed = true;
		}
		//trace("charge!!!!!!!!!!!!!!!");
		if (caught) {
			_player.freeze = true;
			_player.y = this.y;
			if (facing == FlxObject.LEFT) {
				_player.x = this.x;
			} else {
				_player.x = this.x + this.width - _player.width;
			}
		} else {
			if (FlxG.overlap(_player, this)) {
				//_player.freeze = true;
				caught = true;
			}
		}
		
        if (this.x <= 30 || this.x >= mapWidth - this.width - 30) {
            if(caught) {
                _player.hurt(40);
                _player.stun();
                pHud.startDaze();
                caught = false;
                _player.freeze = false;
            }
            brain.activeState = stay;
        }
		
        animation.play("lr");
        if (facing == FlxObject.LEFT) {
            velocity.x = -speed * 3.5;
        } else if (facing == FlxObject.RIGHT) {
            velocity.x = speed * 3.5;
        }
	}
	
	public function chargeRampage(elapsed:Float) {
		if (stayTimer < stayTime * 8) {
			stayTimer += elapsed;
		} else {
			brain.activeState = turn;
			stayTimer = 0;
			originalColor = 0x870000;
			color = originalColor;
			return;
		}
		FlxFlicker.flicker(this, stayTime * 8, 0.10, true, false);
		animation.play("rampage");
		if (stayTimer < 1.0) {
			originalColor = 0x878787;
		} else if (stayTimer < 2.0) {
			originalColor = 0x874444;
		} else if (stayTimer < 3.0) {
			originalColor = 0x872222;
		} else if (stayTimer > 3.5) {
			originalColor = 0x870000;
		}
		color = originalColor;
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