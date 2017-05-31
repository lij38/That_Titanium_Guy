package weapons;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

//private var angle:Int;

class ShotgunBullet extends Bullet{
    private var pushBack:Float;
    override public function new(X:Float=0, Y:Float=0, Speed:Float, Direction:Int, Damage:Float, Range:Float, push:Float) {
        super(X, Y, Speed, Direction, Damage, Range);
        this.type = "shotgun";
        this.pushBack = push;
        loadGraphic(AssetPaths.shotgunBullet__png);
    }

    override public function update(elapsed:Float):Void {
		super.update(elapsed);
		velocity.set(speed, 0);
        velocity.rotate(FlxPoint.weak(0, 0), direction);
	}

    public function getPushBack():Float {
        return this.pushBack;
    }
}