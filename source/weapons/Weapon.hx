package weapons;
import flixel.group.FlxGroup;

class Weapon {
    private var damage:Float;
    private var type:String;
    private var range:Float;
    private var fireRate:Float;
    private var speed:Float;
    private var bulletArray:FlxTypedGroup<Bullet>;
    private var magCapacity:Int;
    private var curAmmo:Int;
    private var isReloading:Bool;
    private var name:String;
    private var reloadTime:Float;

    public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        this.name = "";
        this.range = -1;
        this.fireRate = -1;
        this.speed = -1;

        this.magCapacity = -1;
        this.curAmmo = -1;
        this.reloadTime = -1;
        this.bulletArray = playerBulletArray;
    }

    public function getImagePath():String {
        return AssetPaths.IMAGE + this.name + ".png";
    }

    public function reload() {
        curAmmo = magCapacity;
        //TODO: PLAY RELOAD ANIMATION
    }

    public function getName():String {
        return name;
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