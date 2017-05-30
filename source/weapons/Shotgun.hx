package weapons;
import flixel.group.FlxGroup;
import flixel.FlxObject;

class Shotgun extends Weapon {
    private var pushBack:Float;
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.name = "shotgun";
        //damage
        if(Main.SAVE.data.sgDmg == null) {
            this.damage = 10;
            Main.SAVE.data.sgDmg = this.damage;
        } else {
            this.damage = Main.SAVE.data.sgDmg;
        }
        
        this.type = "shotgun";
        this.range = 300;
        //fire rate
        if(Main.SAVE.data.sgRate == null) {
            this.fireRate = 0.5;
            Main.SAVE.data.sgRate = this.fireRate;
        } else {
            this.fireRate = Main.SAVE.data.sgRate;
        }
        this.speed = 1500;
        this.bulletArray = playerBulletArray;

        //pushback
        if(Main.SAVE.data.pushBack == null) {
            this.pushBack = 6;
            Main.SAVE.data.pushBack = 6;
        } else {
            this.pushBack = Main.SAVE.data.pushBack;
        }
        //mag capacity
        if(Main.SAVE.data.sgMag == null) {
            this.magCapacity = 8;
            Main.SAVE.data.sgMag = this.magCapacity;
        } else {
            this.magCapacity = Main.SAVE.data.sgMag;
        }
        this.curAmmo = this.magCapacity;
        //reload time
        if(Main.SAVE.data.sgRtime == null) {
            this.reloadTime = 3;
            Main.SAVE.data.sgRtime = this.reloadTime;
        } else {
            this.reloadTime = Main.SAVE.data.sgRtime;
        }
        Main.SAVE.flush();
    }

    public override function attack(x:Float, y:Float, direction:Int):Bool {
        if(curAmmo < 1) {
            reload();
            return false;
        }
        if(direction == FlxObject.LEFT) {
            var angle:Int = 165;
            for(i in 0...5) {
                var newBullet = new ShotgunBullet(x + 20, y, speed, angle, this.damage, range, pushBack);
                // var newBullet = new ShotgunBullet(x + 20, y, speed, angle, 
				// 							this.damage, range);
                this.bulletArray.add(newBullet);
                angle += 6;
            }
        }
        if(direction == FlxObject.RIGHT) {
            var angle:Int = 345;
            for(i in 0...5) {
                var newBullet = new ShotgunBullet(x + 20, y, speed, angle % 360, this.damage, range, pushBack);
                // var newBullet = new ShotgunBullet(x + 20, y, speed, angle % 360,
				// 								this.damage, range);
                this.bulletArray.add(newBullet);
                angle += 6;
            }
        }
        curAmmo--;
        return true;
    }
}