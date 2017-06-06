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
	WEB;
	SKULL;
	NEEDLE;
	HEART;
	BOSSMELEE;
}

class EnemyBullet extends Bullet {
	private var meleeColor:FlxColor = FlxColor.BLACK;
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
		
		if (bulletType == Ranged) {
			loadGraphic(AssetPaths.enemybullet__png);
		} else if(bulletType == SHOTGUN) {
			loadGraphic(AssetPaths.shotgunBullet__png);
		} else if (bulletType == Melee) {
			this.type = "melee";
			makeGraphic(6, 70, meleeColor);
		} else if (bulletType == WEB) {
			loadGraphic(AssetPaths.spider_web__png, true, 30, 32);
			setFacingFlip(FlxObject.LEFT, false, false);
			setFacingFlip(FlxObject.RIGHT, true, false);
			animation.add("first", [0], 1);
			animation.play("first");
		} else if (bulletType == SKULL) {
			loadGraphic(AssetPaths.poisonSkull__png, true, 24, 45);
			animation.add("first", [0, 1, 2, 1, 0, 3, 4, 3], 6);
			animation.play("first");
		} else if (bulletType == NEEDLE) {
			this.type = "melee";
			makeGraphic(11, 11, meleeColor);
		} else if (bulletType == HEART) {
			loadGraphic(AssetPaths.nurse_heart__png, true, 18, 32);
			animation.add("first", [0, 1, 2, 1, 0, 3, 4, 3], 6);
			animation.play("first");
		} else if (bulletType == BOSSMELEE) {
			makeGraphic(20, 250, meleeColor);
		}
		
		if (bulletType == SHOTGUN || bulletType == SKULL) {
			velocity.set(speed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), direction);
			if (velocity.x < 0) {
				facing = FlxObject.LEFT;
			} else {
				facing = FlxObject.RIGHT;
			}
		} else {
			if (direction == FlxObject.LEFT) {
				velocity.set(-speed, 0);
			}
			if (direction == FlxObject.RIGHT) {
				velocity.set(speed, 0);
			}
		}
	}
}