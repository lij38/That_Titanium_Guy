package weapons;

import flixel.util.FlxColor;
import flixel.FlxObject;

class RevolverBullet extends Bullet {
    override public function new(X:Float=0, Y:Float=0, Speed:Float, Direction:Int, Damage:Float, Range:Float) {
        super(X, Y, Speed, Direction, Damage, Range);
        this.type = "ballistic";
        loadGraphic(AssetPaths.revolverbullet__png);
    }
}