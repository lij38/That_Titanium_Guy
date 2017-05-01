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
	
	public function new(X:Float=0, Y:Float=0, Speed:Float, Direction:Int, Damage:Float, Range:Float) {
		super(X, Y);
		speed = Speed;
		direction = Direction;
		damage = Damage;
		range = Range;
		xpos = X;
		ypos = Y;
		//makeGraphic(6, 6, FlxColor.BLUE);
		//loadGraphic(AssetPaths.player__png, true, 6, 6, true, "bullet");
	}
	
	public function outOfRange(pbx:Float):Bool {
		if((pbx > xpos + range) || (pbx < xpos - range)) {
			return true;
		}
		return false;
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (direction == FlxObject.LEFT) {
			velocity.x = -speed;
		}
		if (direction == FlxObject.RIGHT) {
			velocity.x = speed;
		}
	}
	
	override public function destroy():Void {
		super.destroy();
	}
	
	public function getDamage():Float {
		return damage;
	}
}