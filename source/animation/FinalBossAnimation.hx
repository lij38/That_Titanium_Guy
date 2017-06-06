package animation;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.effects.FlxFlicker;
import weapons.*;
import items.Coin;
import flixel.FlxSprite;

class FinalBossAnimation extends FlxSprite {

	public function new(X:Float = 0, Y:Float = 0, gravity:Float) {
		super(X, Y);

		loadGraphic(AssetPaths.finalBoss__png, true, 399, 387);
		setSize(140, 297);
		offset.set(130, 78);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("stop", [0], 1, false);
		animation.add("lr", [1,2,3,4,5,6,7], 12, false);
        animation.add("charge", [1,2,3,4,5,6,7], 60, false);
		animation.add("attack1", [8,9,10,11], 16, false);
        animation.add("attack2", [12,13,13,12], 16, false);
		animation.add("die", [0, 0, 0, 0, 0], 1, false);
		animation.play("stop");
	}

    override public function update(elapsed:Float) {
        super.update(elapsed);
    }
   
}