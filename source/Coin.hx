package;

/*
 * TODO: Generate coin when enemies die and pick up coins in PlayState 
 * 
 */

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Coin extends FlxSprite {
	private var value:Int;
	
	public function new(X:Float = 0, Y:Float = 0, lowerBound:Int = 0, upperBound:Int = 10) {
		value = Std.int(Math.random() * (upperBound - lowerBound) + lowerBound);
		super(X, Y);
	}
	
	public function value():Int {
		return value;
	}
	
}