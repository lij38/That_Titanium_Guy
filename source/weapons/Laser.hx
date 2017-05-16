package weapons;
import flixel.group.FlxGroup;

class Laser extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.damage = new Array<Int>();
        for(i in 1...6) {
            this.damage.push(i * 12);
        }
        this.damageIndex = 0;
        this.name = "laser rifle";
        this.type = "energy";
        this.range = 1000;
        this.fireRate = 0.2;
        this.speed = 1500;
        this.bulletArray = playerBulletArray;

        this.magCapacity = 20;
        this.curAmmo = 20;
        this.reloadTime = 1.5;
    }

    public override function attack(x:Float, y:Float, direction:Int): Bool {
        if(curAmmo < 1) {
            reload(); 
            return false;
        }
        var newBullet = new EnergyBullet(x + 20, y + 20, speed, direction, this.damage[damageIndex], range);
		this.bulletArray.add(newBullet);
        curAmmo--;
        return true;
    }
}