package weapons;
import flixel.group.FlxGroup;

class Shield extends Weapon {
    private var spike:Float;
    private var reflect:Float;
    private var daze:Float;
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.name = "shield";
        this.type = "shield";
        if(Main.SAVE.data.spike == null) {
            this.spike = 0;
        } else {
            this.spike = Main.SAVE.data.spike;
        }
        if(Main.SAVE.data.reflect == null) {
            this.reflect = 0;
        } else {
            this.reflect = Main.SAVE.data.reflect;
        }
        if(Main.SAVE.data.daze == null) {
            this.daze = 0;
        } else {
            this.daze = Main.SAVE.data.daze;
        }
    }

    public function getSpike():Float {
        return this.spike;
    }

    public function getReflect():Float {
        return this.reflect;
    }

    public function getDaze():Float {
        return this.daze;
    }
}