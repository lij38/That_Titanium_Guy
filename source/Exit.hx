package;

import flixel.FlxSprite;

class Exit extends FlxSprite
{
    
    public function new(X:Float = 0, Y:Float = 0,)
    {
        loadGraphic(AssetPaths.door__png);
        super(X, Y);
    }
}