package weapons;

import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class MeleeBullet extends Bullet {
    public function new(X:Float, Y:Float, Speed:Float, Direction:Int, Damage:Float, Range:Float, Ki:Bool) {
        if(Direction == FlxObject.LEFT && Ki) {
			X -= 85;
		}
        super(X, Y, Speed, Direction, Damage, Range);
        this.type = "melee";
        if(!Ki) {
            makeGraphic(6, 70, FlxColor.TRANSPARENT);
        } else {
            if(this.facing == FlxObject.LEFT) {
                loadGraphic(AssetPaths.kiLeft__png);
            } else {
                loadGraphic(AssetPaths.kiRight__png);
            }
        }
    }
}