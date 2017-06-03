package weapons;
import flixel.group.FlxGroup;

class Revolver extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.name = "revolver";
        //damage
        if(Main.SAVE.data.rvDmg == null) {
            this.damage = 13;
            Main.SAVE.data.rvDmg = this.damage;
        } else {
            this.damage = Main.SAVE.data.rvDmg;
        }
        this.type = "ballistic";
        this.range = 1500;
        this.fireRate = 0.0;
        this.speed = 2000;
        this.bulletArray = playerBulletArray;

        //mag capacity
        if(Main.SAVE.data.rvMag == null) {
            this.magCapacity = 6;
            Main.SAVE.data.rvMag = this.magCapacity;
        } else {
            this.magCapacity = Main.SAVE.data.rvMag;
        }
        this.curAmmo = this.magCapacity;
        //reload time
        if(Main.SAVE.data.rvRtime == null) {
            this.reloadTime = 3.0;
            Main.SAVE.data.rvRtime = this.reloadTime;
        } else {
            this.reloadTime = Main.SAVE.data.rvRtime;
        }
        Main.SAVE.flush();
    }

    public override function attack(x:Float, y:Float, direction:Int):Bool {
        if(curAmmo < 1) {
            reload();            
            return false;
        }
        var newBullet = new RevolverBullet(x + 20, y + 20, speed, direction, this.damage, range);
		this.bulletArray.add(newBullet);
        curAmmo--;
        return true;
    }
}