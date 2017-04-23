package weapons;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class ShotgunBullet extends Bullet {
    override public function new(X:Float=0, Y:Float=0, Speed:Float, Direction:Int, Damage:Float, Range:Float) {
        super(X, Y, Speed, Direction, Damage, Range);
        makeGraphic(6, 40, FlxColor.RED);
    }
}