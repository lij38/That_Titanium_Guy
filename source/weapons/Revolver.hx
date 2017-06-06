package weapons;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxSound;

class Revolver extends Weapon {
    private var cTimer:Float;
    private var chargeVal:Float;
    public var charged:Bool;
    private var sndCharge:FlxSound;
    private var sndCFire:FlxSound;
    private var CTIME = 1.6;

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
        //charge
        if(Main.SAVE.data.charge == null) {
            this.chargeVal = 2;
            Main.SAVE.data.charge = this.chargeVal;
        } else {
            this.chargeVal = Main.SAVE.data.charge;
        }
        cTimer = -1;
        charged = false;
        sndCharge = FlxG.sound.load(AssetPaths.laser_charge1__wav);
        sndFire = FlxG.sound.load(AssetPaths.pulse_laser__wav);
        sndCFire = FlxG.sound.load(AssetPaths.laser_fire3__wav);
        sndReload = FlxG.sound.load(AssetPaths.laser_reload__wav);

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

    override public function update(elapsed:Float) {
        if(cTimer > -1) {
            cTimer += elapsed;
        }
        if(cTimer > CTIME) {
            charged = true;
        }
        super.update(elapsed);
    }

    public function isCharging():Bool {
        return cTimer >= 0;
    }

    public function charge() {
        sndCharge.play();
        cTimer = 0;
    }

    public function discharge() {
        sndCharge.stop();
        cTimer = -1;
        charged = false;
    }

    public override function attack(x:Float, y:Float, direction:Int):Bool {
        if(curAmmo < 1) {
            reload();            
            return false;
        }
        var newBullet;
        if(direction == FlxObject.RIGHT) {
            if(charged) {
                newBullet = new RevolverBullet(x + 25, y + 30, speed, direction, this.damage * chargeVal, range, charged);
            } else {
                newBullet = new RevolverBullet(x + 25, y + 30, speed, direction, this.damage, range, charged);
            }
        } else {
            if(charged) {
                newBullet = new RevolverBullet(x - 115, y + 30, speed, direction, this.damage * chargeVal, range, charged);
            } else {
                newBullet = new RevolverBullet(x - 115, y + 30, speed, direction, this.damage, range, charged);
            }
        }
        if(charged) {
            sndCFire.play(true);
        } else {
            sndFire.play(true);
        }
        charged = false;
        cTimer = -1;
		this.bulletArray.add(newBullet);
        curAmmo--;
        fTimer = 0;
        return true;
    }
}