package weapons;
import flixel.group.FlxGroup;

class Sword extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.damage = new Array<Int>();
        for(i in 1...6) {
            this.damage.push(i * 20);
        }

        this.type = "energy";
        this.range = 75;
        this.fireRate = 5;
        this.speed = 1000;
        this.bulletArray = playerBulletArray;
    }

    public function attack(x:Float, y:Float, direction:Int) {
        var newBullet = new MeleeBullet(x + 20, y, speed, direction, this.damage[damageIndex], range);
		this.bulletArray.add(newBullet);
    }
}