package enemies;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxSprite;

class Explosion extends FlxSprite {
    public function new(?X:Float = 0, ?Y:Float = 0) {
        super(X, Y);
        loadGraphic(AssetPaths.explosion__png, true, 128, 128);
		scale.set(4, 4);
        animation.add("exp", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15], 4, false);
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);
    }

    public function explode(X:Float, Y:Float) {
        this.x = X;
        this.y = Y;
        animation.play("exp");
    }
}
