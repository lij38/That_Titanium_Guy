package weapons;
import flixel.group.FlxGroup;
import flixel.FlxObject;

class Shotgun extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.name = "shotgun";
        this.damage = new Array<Int>();
        for(i in 1...6) {
            this.damage.push(i * 10);
        }

        this.type = "ballistic";
        this.range = 300;
        this.fireRate = 0.5;
        this.speed = 1500;
        this.bulletArray = playerBulletArray;

        this.magCapacity = 8;
        this.curAmmo = 8;
        this.reloadTime = 3.0;
    }

    public override function attack(x:Float, y:Float, direction:Int):Bool {
        if(curAmmo < 1) {
            reload();
            return false;
        }
        if(direction == FlxObject.LEFT) {
            var angle:Int = 165;
            for(i in 0...5) {
                var newBullet = new ShotgunBullet(x + 20, y, speed, angle, 
											this.damage[damageIndex], range);
                this.bulletArray.add(newBullet);
                angle += 6;
            }
        }
        if(direction == FlxObject.RIGHT) {
            var angle:Int = 345;
            for(i in 0...5) {
                var newBullet = new ShotgunBullet(x + 20, y, speed, angle % 360,
												this.damage[damageIndex], range);
                this.bulletArray.add(newBullet);
                angle += 6;
            }
        }
        curAmmo--;
        return true;
    }
}