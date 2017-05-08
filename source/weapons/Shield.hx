package weapons;
import flixel.group.FlxGroup;

class Shield extends Weapon {
    override public function new(playerBulletArray:FlxTypedGroup<Bullet>) {
        super(playerBulletArray);
        this.name = "shield";
        this.type = "shield";
    }
}