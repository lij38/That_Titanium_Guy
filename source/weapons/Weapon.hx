package weapons;
import flixel.group.FlxGroup;

class Weapon {
    private var damage:Array<Int>;
    private var damageIndex:Int;
    private var type:String;
    private var range:Float;
    private var fireRate:Int;
    private var speed:Float;
    private var bulletArray:FlxTypedGroup<Bullet>;
    private var magCapacity:Int;
    private var curAmmo:Int;

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
}