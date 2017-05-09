package weapons;
import flixel.group.FlxGroup;

class Sword extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.damage = new Array<Int>();
        for(i in 1...6) {
            this.damage.push(i * 20);
        }
        
        this.name = "sword";
        this.type = "melee";
        this.range = 130;
        this.fireRate = 0.25;
        this.speed = 4000;
        this.bulletArray = playerBulletArray;
    }

    public override function attack(x:Float, y:Float, direction:Int):Bool {
        var newBullet = new MeleeBullet(x + 7, y + 10, speed, direction, this.damage[damageIndex], range);
		this.bulletArray.add(newBullet);
        return true;
    }
}