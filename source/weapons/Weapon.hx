package weapons;
import flixel.group.FlxGroup;

class Weapon {
    private var damage:Array<Int>;
    private var damageIndex:Int;
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
        this.damageIndex = 0;
        this.bulletArray = playerBulletArray;
    }

    public function reload() {
        curAmmo = magCapacity;
        //TODO: PLAY RELOAD ANIMATION
    }

    public function damageUpgrade() {
        if(damageIndex < damage.length) {
            damageIndex++;
        }
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
}