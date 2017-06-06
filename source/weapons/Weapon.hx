package weapons;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.system.FlxSound;
import flixel.FlxG;

class Weapon extends FlxObject {
    private var damage:Float;
    private var type:String;
    private var range:Float;
    private var fireRate:Float;
    private var speed:Float;
    private var bulletArray:FlxTypedGroup<Bullet>;
    private var magCapacity:Int;
    private var curAmmo:Int;
    private var name:String;
    private var reloadTime:Float;
    private var fTimer:Float;
    private var rTimer:Float;
    private var sndReload:FlxSound;
    private var sndFire:FlxSound;

    public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        this.name = "";
        this.range = -1;
        this.fireRate = -1;
        this.speed = -1;

        this.magCapacity = -1;
        this.curAmmo = -1;
        this.reloadTime = -1;
        this.bulletArray = playerBulletArray;
        this.fTimer = -1;
        this.rTimer = -1;
        this.sndReload = FlxG.sound.load(AssetPaths.rifle_reload__wav);
        super();
    }

    override public function update(elapsed:Float) {
        if(fTimer > -1) {
            fTimer += elapsed;
        }
        if(rTimer > -1) {
            rTimer += elapsed;
        }
        if(fTimer > fireRate) {
            fTimer = -1;
        }
        if(rTimer > this.reloadTime) {
            rTimer = -1;
            curAmmo = magCapacity;
        }
        super.update(elapsed);
    }

    public function getImagePath():String {
        return AssetPaths.IMAGE + this.name + ".png";
    }

    public function reload():Bool {
        rTimer = 0;
        //TODO: PLAY RELOAD ANIMATION
        sndReload.play();
		return magCapacity > 0;
    }

    public function getName():String {
        return name;
    }

    public function canFire():Bool {
        return fTimer == -1 || fTimer > this.fireRate;
    }

    public function isReloading():Bool {
        return rTimer != -1;
    }

    public function attack(x:Float, y:Float, direction:Int):Bool {
        return true;
    }

    public function getRate():Float {
        return fireRate;
    }

    public function getReloadTime():Float {
        return reloadTime;
    }

    public function getCurAmmo():Int {
        return curAmmo;
    }

    public function getMaxAmmo():Int {
        return magCapacity;
    }
}