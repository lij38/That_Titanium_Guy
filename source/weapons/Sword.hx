package weapons;
import flixel.group.FlxGroup;

class Sword extends Weapon {
    private var ki:Bool;
    private var ww:Bool;
    private var dsCutOff:Int;
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        //damage
        if(Main.SAVE.data.swDmg == null) {
            this.damage = 20;
            Main.SAVE.data.swDmg = this.damage;
        } else {
            this.damage = Main.SAVE.data.swDmg;
        }
        //double slash proficiency
        if(Main.SAVE.data.ds == null) {
            this.dsCutOff = 20;
            Main.SAVE.data.ds = this.dsCutOff;
        } else {
            this.dsCutOff = Main.SAVE.data.ds;
        }
        //ki
        if(Main.SAVE.data.ki == null) {
            this.ki = false;
            Main.SAVE.data.ki = this.ki;
        } else {
            this.ki = Main.SAVE.data.ki;
        }
        //whirlwind
        if(Main.SAVE.data.ww == null) {
            this.ww = false;
            Main.SAVE.data.ww = this.ww;
        } else {
            this.ww = Main.SAVE.data.ww;
        }
        this.name = "sword";
        this.type = "melee";
        this.range = 145;
        this.fireRate = 0.25;
        this.speed = 1000;
        this.magCapacity = -1;
        this.curAmmo = -1;
        this.reloadTime = -1;
        this.bulletArray = playerBulletArray;
        Main.SAVE.flush();
    }

    public override function attack(x:Float, y:Float, direction:Int):Bool {
        var newBullet = new MeleeBullet(x, y + 10, speed, direction, this.damage, range);
		this.bulletArray.add(newBullet);
        return true;
    }

    public function isKi():Bool {
        return ki;
    }

    public function isWW():Bool {
        return ww;
    }

    public function isDs():Bool {
        return Std.random(100) < dsCutOff;
    }
}