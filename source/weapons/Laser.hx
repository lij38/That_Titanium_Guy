package weapons;
import flixel.group.FlxGroup;

class Laser extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.damage = new Array<Int>();
        for(i in 1...6) {
            this.damage.push(i * 12);
        }

        this.type = "energy";
        this.range = 1000;
        this.fireRate = 5;
        this.speed = 1000;
        this.bulletArray = playerBulletArray;

        this.magCapacity = 20;
        this.curAmmo = 20;
    }

    public function attack(x:Float, y:Float, direction:Int) {
        if(curAmmo < 1) {
            reload();
        }
        var newBullet = new EnergyBullet(x + 20, y + 20, speed, direction, this.damage[damageIndex], range);
		this.bulletArray.add(newBullet);
        curAmmo--;
    }
}