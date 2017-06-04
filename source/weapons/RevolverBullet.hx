package weapons;

import flixel.util.FlxColor;
import flixel.FlxObject;

class RevolverBullet extends Bullet {
    override public function new(X:Float=0, Y:Float=0, Speed:Float, Direction:Int, Damage:Float, Range:Float, Charged:Bool) {
        super(X, Y, Speed, Direction, Damage, Range);
        this.type = "ballistic";
        if(this.facing == FlxObject.LEFT) {
            if(Charged) {
                loadGraphic(AssetPaths.chargedRevolverBullet__png);
            } else {
                loadGraphic(AssetPaths.revolverBullet__png);
            }
        } else {
            if(Charged) {
                loadGraphic(AssetPaths.chargedRevolverBulletRight__png);
            } else {
                loadGraphic(AssetPaths.revolverBulletRight__png);
            }
        }
    }
}