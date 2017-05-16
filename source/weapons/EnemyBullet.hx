package weapons;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

enum BulletType {
	Melee;
	Ranged;
}

class EnemyBullet extends Bullet{

    public function new(X:Float = 0, Y:Float = 0, Speed:Float, 
						Direction:Int, Damage:Float, Range:Float,
						bulletType:BulletType) {
        super(X, Y, Speed, Direction, Damage, Range);
		if (bulletType == Ranged) {
			this.type = "ballistic";
			loadGraphic(AssetPaths.enemybullet__png);
		} else if (bulletType == Melee) {
			this.type = "melee";
			makeGraphic(6, 70, FlxColor.TRANSPARENT);
		}
	}
	
	public function setBullet(X:Float = 0, Y:Float = 0, Speed:Float, 
						Direction:Int, Damage:Float, Range:Float,
						bulletType:BulletType):Void {
		speed = Speed;
		direction = Direction;
		damage = Damage;
		range = Range;
		xpos = X;
		ypos = Y;
		x = X;
		y = Y;
		facing = direction;
		exists = true;
		
		if (direction == FlxObject.LEFT) {
			velocity.set(-speed, 0);
		}
		if (direction == FlxObject.RIGHT) {
			velocity.set(speed, 0);
		}
		if (bulletType == Ranged) {
			this.type = "ballistic";
			loadGraphic(AssetPaths.enemybullet__png);
		} else if (bulletType == Melee) {
			this.type = "melee";
			makeGraphic(6, 70, FlxColor.BLACK);
		}
	}
}