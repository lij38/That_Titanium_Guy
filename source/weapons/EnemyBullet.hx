package weapons;
import flixel.FlxObject;
import flixel.group.FlxGroup;

class EnemyBullet extends Bullet{
    override public function new(X:Float=0, Y:Float=0, Speed:Float, Direction:Int, Damage:Float, Range:Float) {
        super(X, Y, Speed, Direction, Damage, Range);
        this.type = "ballistic";
        loadGraphic(AssetPaths.enemybullet__png);
    }
	
	public function set(X:Float=0, Y:Float=0, Speed:Float, Direction:Int, Damage:Float, Range:Float):Void {
		speed = Speed;
		direction = Direction;
		damage = Damage;
		range = Range;
		xpos = X;
		ypos = Y;
		
		if (direction == FlxObject.LEFT) {
			velocity.x = -speed;
		}
		if (direction == FlxObject.RIGHT) {
			velocity.x = speed;
		}
        this.type = "ballistic";
        loadGraphic(AssetPaths.enemybullet__png);
	}
}