package weapons;
import flixel.group.FlxGroup;

class EnemyBullet extends Bullet{
    override public function new(X:Float=0, Y:Float=0, Speed:Float, Direction:Int, Damage:Float, Range:Float) {
        super(X, Y, Speed, Direction, Damage, Range);
        this.type = "ballistic";
        loadGraphic(AssetPaths.enemybullet__png);
    }
}