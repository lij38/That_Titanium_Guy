package weapons;
import flixel.group.FlxGroup;
import flixel.FlxObject;

class Rifle extends Weapon {   
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.name = "rifle";
        //damage
        if(Main.SAVE.data.rDmg == null) {
            this.damage = 6;
            Main.SAVE.data.rDmg = this.damage;
        } else {
            this.damage = Main.SAVE.data.rDmg;
        }
        //fire rate
        if(Main.SAVE.data.rRate == null) {
            this.fireRate = 0.15;
            Main.SAVE.data.rRate = this.fireRate;
        } else {
            this.fireRate = Main.SAVE.data.rRate;
        }
        this.range = 1500;
        this.speed = 1800;
        this.bulletArray = playerBulletArray;

        //mag capacity
        if(Main.SAVE.data.rMag == null) {
            this.magCapacity = 15;
            Main.SAVE.data.rMag = this.magCapacity;
        } else {
            this.magCapacity = Main.SAVE.data.rMag;
        }
        this.curAmmo = this.magCapacity;
        //reload time
        if(Main.SAVE.data.rRtime == null) {
            this.reloadTime = 2.0;
            Main.SAVE.data.rRtime = this.reloadTime;
        } else {
            this.reloadTime = Main.SAVE.data.rRtime;
        }
        Main.SAVE.flush();
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
        var newBullet = new BallBullet(x + offset, y + 45, speed, direction, this.damage, range);
		this.bulletArray.add(newBullet);
        curAmmo--;
        return true;
    }
}