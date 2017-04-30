package weapons;
import flixel.group.FlxGroup;

class Rifle extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.damage = new Array<Int>();
        for(i in 1...6) {
            this.damage.push(i * 10);
        }

        this.type = "ballistic";
        this.range = 1000;
        this.fireRate = 5;
        this.speed = 700;
        this.bulletArray = playerBulletArray;

        this.magCapacity = 20;
        this.curAmmo = 20;
    }

    public function attack(x:Float, y:Float, direction:Int) {
        if(curAmmo < 1) {
            reload();
        }
        var newBullet = new BallBullet(x + 20, y + 20, speed, direction, this.damage[damageIndex], range);
		this.bulletArray.add(newBullet);
        curAmmo--;
    }
}