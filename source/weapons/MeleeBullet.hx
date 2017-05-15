package weapons;

import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class MeleeBullet extends Bullet {
    override public function new(X:Float=0, Y:Float=0, Speed:Float, Direction:Int, Damage:Float, Range:Float) {
        super(X, Y, Speed, Direction, Damage, Range);
        this.type = "melee";
        makeGraphic(6, 70, FlxColor.BLACK);
    }
}