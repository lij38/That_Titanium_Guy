package enemies;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import weapons.*;
import flixel.util.FlxColor;
import items.Coin;


class EnemyGen extends Enemy {
//	private var id:Int;
    //private var lvl:Int;

	// private var bulletArray:FlxTypedGroup<EnemyBullet>;
	// private var coinsGroup:FlxTypedGroup<Coin>;
	// private var dropCoin:Bool = false;
	// private var coinCount:Int = 0;
	
	//private var GRAVITY:Float;
	//private var brain:EnemyFSM;
	//public var playerPos(default, null):FlxPoint;
	//public var seesPlayer:Bool = false;
	//public var hurtTime:Float = 0.25;
	//private var detectRange:Float = 700;
	//private var hurtColorTimer:Float = -1;
	//private var originalColor:FlxColor = 0xffffff;
    private var enemies:FlxTypedGroup<Enemy>;

    private var genTime:Float = 3.0;
    private var genTimer:Float = -1;

	
	//CAP
	public function new(X:Float = 0, Y:Float = 0, id:Int = -1,
						enemiesBulletArray:FlxTypedGroup<EnemyBullet>,
						coinsGroup:FlxTypedGroup<Coin>,
						gravity:Float, enemies:FlxTypedGroup<Enemy>, lvl:Int) {
		super(X, Y, id, enemiesBulletArray, coinsGroup, gravity, ENEMYG);
        loadGraphic(AssetPaths.gen__png);
        this.enemies = enemies;
        this.level = lvl;
        health = 200;
        brain = new EnemyFSM(nothing);
    }

    override public function update(elapsed:Float):Void {
        if (genTimer >= 0 && genTimer < genTime) {
            genTimer += elapsed;
        } 
        super.update(elapsed);
    }

    override public function hurt(damage:Float):Void {
		seesPlayer = true;
		if (health - damage <= 0) {
			alive = false;
		}
		health -= damage;
		color = 0xff0000;
		hurtColorTimer = 0.0;
    }

    override public function knockBack(len:Int, dir:Int):Void {
    
    }

    override public function startDaze():Void {
    
    }

    public function generate(elapsed:Float):Void {
        trace(enemies.countLiving());
        if (genTimer < 0) {
            genTimer = 0;
        }
        if (!seesPlayer) {
            brain.activeState = nothing;
        }
        if (genTimer >= genTime && enemies.countLiving() < 60) {
            var enem:String = randType();
                if (enem != null) {
                    enemies.add(EnemyFactory.getEnemy(enem, getMidpoint().x - 17, getMidpoint().y - 60, id, bulletArray, coinsGroup, GRAVITY, level));
                } else {
                    enemies.add(EnemyFactory.getEnemy("TRUCK", getMidpoint().x, getMidpoint().y - 60, id, bulletArray, coinsGroup, GRAVITY, level));
                }
            genTimer = 0;
        }
    }

    private function randType():String {
        var randP:Int = Std.random(5);
        switch randP {
            case 0: return "RIFLE";
            case 1: return "JPRIFLE";
            case 2: return "MELEE";
            case 3: return "JPMELEE";
            case 4: return "SHIELD";
            case 5: return "JPSHIELD";
        }
        return null;
    // 	JPRIFLE;
    // 	JPMELEE;
    // 	JPSHIELD;
    // 	SHOTGUN;
    // 	SHIELD;
    // 	MELEE;
    // 	RIFLE;
    // 	TRUCK;
    // 	SPIDER;
    }
    
    public function nothing(elapsed:Float):Void {
        trace(seesPlayer);
        if (seesPlayer) {
            brain.activeState = generate;
        }
    }

}