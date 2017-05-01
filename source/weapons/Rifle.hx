package weapons;
import flixel.group.FlxGroup;

class Rifle extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.name = "rifle";
        this.damage = new Array<Int>();
        for(i in 1...6) {
            this.damage.push(i * 10);
        }

        this.type = "ballistic";
        this.range = 1000;
        this.fireRate = 0.2;
        this.speed = 1300;
        this.bulletArray = playerBulletArray;

        this.magCapacity = 20;
        this.curAmmo = 20;
        this.reloadTime = 1.5;
    }

    public override function attack(x:Float, y:Float, direction:Int):Bool {
        if(curAmmo < 1) {
            reload();
            return false;
        }
        var newBullet = new BallBullet(x + 20, y + 20, speed, direction, this.damage[damageIndex], range);
		this.bulletArray.add(newBullet);
        curAmmo--;
        return true;
    }
}