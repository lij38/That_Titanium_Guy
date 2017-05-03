package weapons;
import flixel.group.FlxGroup;

class Revolver extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.name = "revolver";
        this.damage = new Array<Int>();
        for(i in 1...6) {
            this.damage.push(i * 10);
        }

        this.type = "ballistic";
        this.range = 1000;
        this.fireRate = 0.0;
        this.speed = 2000;
        this.bulletArray = playerBulletArray;

        this.magCapacity = 6;
        this.curAmmo = 6;
        this.reloadTime = 1.8;
    }

    public override function attack(x:Float, y:Float, direction:Int):Bool {
        if(curAmmo < 1) {
            reload();            
            return false;
        }
        var newBullet = new RevolverBullet(x + 20, y + 20, speed, direction, this.damage[damageIndex], range);
		this.bulletArray.add(newBullet);
        curAmmo--;
        return true;
    }
}