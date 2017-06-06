package enemies;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxSprite;

class Explosion extends FlxSprite {

    public function new(?X:Float = 0, ?Y:Float = 0) {
        super(X, Y);
        loadGraphic(AssetPaths.explosion__png);
        
    }
}
