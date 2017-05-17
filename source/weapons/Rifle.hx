package weapons;
import flixel.group.FlxGroup;
import flixel.FlxObject;

class Rifle extends Weapon {   
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.name = "rifle";
        this.damage = new Array<Int>();
        for(i in 1...6) {
            this.damage.push(i * 6);
        }
        this.damageIndex = 0;
        this.type = "ballistic";
        this.range = 1000;
        this.fireRate = 0.15;
        this.speed = 1500;
        this.bulletArray = playerBulletArray;

        this.magCapacity = 15;
        this.curAmmo = 15;
        this.reloadTime = 1.5;
    }

    public override function attack(x:Float, y:Float, direction:Int):Bool {
        if(curAmmo < 1) {
            reload();
            return false;
        }
        var offset:Int = 50;
        if(direction == FlxObject.LEFT) {
            offset = offset * -1;
            offset += -5;
        }
        var newBullet = new BallBullet(x + offset, y + 45, speed, direction, this.damage[damageIndex], range);
		this.bulletArray.add(newBullet);
        curAmmo--;
        return true;
    }
}