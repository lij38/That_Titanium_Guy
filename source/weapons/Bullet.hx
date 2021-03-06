package weapons;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Bullet extends FlxSprite {
	private var speed:Float;
	private var direction:Int;
	private var damage:Float;
	private var range:Float;
	private var xpos:Float;
	private var ypos:Float;
	private var type:String;
	
	override public function new(X:Float=0, Y:Float=0, Speed:Float, Direction:Int, Damage:Float, Range:Float) {
		super(X, Y);
		speed = Speed;
		direction = Direction;
		damage = Damage;
		range = Range;
		xpos = X;
		ypos = Y;
		facing = direction;
		
		if (facing == FlxObject.LEFT) {
			velocity.x = -speed;
		} else if (facing == FlxObject.RIGHT) {
			velocity.x = speed;
		}
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}

	public function outOfRange():Bool {
		if((x > xpos + range) || (x < xpos - range)) {
			return true;
		}
		return false;
	}
	
	public function getDamage():Float {
		return this.damage;
	}

	public function getType():String {
		return this.type;
	}
	
	override public function destroy():Void {
		super.destroy();
	}
}