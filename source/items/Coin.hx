package items;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Coin extends FlxSprite {
	private var value:Int;
	
	public function new(X:Float = 0, Y:Float = 0, lowerBound:Int = 0, 
						upperBound:Int = 10, gravity:Float = 1000) {
		super(X, Y);
		loadGraphic(AssetPaths.coins__png, true, 45, 48);
		animation.add("spin", [0, 1, 2, 3, 4, 5, 6, 7], 9, true);
		animation.play("spin");
		scale.set(0.75, 0.75);
		
		value = Std.int(Math.random() * (upperBound - lowerBound) + lowerBound);
		acceleration.y = gravity;
		velocity.y = -650;
	}
	
	public function getValue():Int {
		return value;
	}
	
	override public function kill():Void {
		alive = false;
		FlxTween.tween(this, {alpha: 0, y: y - 50}, .75, {ease: FlxEase.circOut,
						onComplete: finishKill});
	}
	
	private function finishKill(_):Void {
		exists = false;
	}
	
}