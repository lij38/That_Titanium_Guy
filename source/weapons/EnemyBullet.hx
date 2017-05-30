package weapons;
import enemies.Enemy;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

enum BulletType {
	Melee;
	Ranged;
	SHOTGUN;
}

class EnemyBullet extends Bullet {
	private var meleeColor:FlxColor = FlxColor.TRANSPARENT;
	public var bulletType:BulletType;
	public var parent:Enemy;

    public function new(X:Float = 0, Y:Float = 0, Speed:Float, 
						Direction:Int, Damage:Float, Range:Float,
						bulletType:BulletType, Parent:Enemy) {
        super(X, Y, Speed, Direction, Damage, Range);
		if (bulletType == Ranged) {
			loadGraphic(AssetPaths.enemybullet__png);
		} else if (bulletType == Melee) {
			this.type = "melee";
			makeGraphic(6, 70, meleeColor);
		}
		this.bulletType = bulletType;
		parent = Parent;
	}
	
	public function setBullet(X:Float = 0, Y:Float = 0, Speed:Float, 
						Direction:Int, Damage:Float, Range:Float,
						bulletType:BulletType, Parent:Enemy):Void {
		speed = Speed;
		direction = Direction;
		damage = Damage;
		range = Range;
		xpos = X;
		ypos = Y;
		reset(X, Y);
		facing = direction;
		this.bulletType = bulletType;
		parent = Parent;
		
		if (bulletType == Ranged || bulletType == SHOTGUN) {
			loadGraphic(AssetPaths.enemybullet__png);
		} else if (bulletType == Melee) {
			this.type = "melee";
			makeGraphic(6, 70, meleeColor);
		}
		
		if (bulletType == SHOTGUN) {
			velocity.set(speed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), direction);
		} else {
			if (direction == FlxObject.LEFT) {
				velocity.set(-speed, 0);
			}
			if (direction == FlxObject.RIGHT) {
				velocity.set(speed, 0);
			}
		}
	}

	//override public function update(elapsed:Float):Void {
		//super.update(elapsed);
		//velocity.set(speed, 0);
        //velocity.rotate(FlxPoint.weak(0, 0), direction);
	//}
}