package weapons;
import flixel.group.FlxGroup;

class Shotgun extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.damage = new Array<Int>();
        damage.push(60);
        for(i in 1...5) {
            this.damage.push(cast(damage[i - 1] * 1.5, Int));
        }

        this.type = "ballistic";
        this.range = 300;
        this.fireRate = 5;
        this.speed = 1000;
        this.bulletArray = playerBulletArray;

        this.magCapacity = 8;
        this.curAmmo = 8;
    }

    public function attack(x:Float, y:Float, direction:Int) {
        if(curAmmo < 1) {
            reload();
        }
        var newBullet = new ShotgunBullet(x + 20, y, speed, direction, this.damage[damageIndex], range);
		this.bulletArray.add(newBullet);
        curAmmo--;
    }
}