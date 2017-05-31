package;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Exit extends FlxSprite
{
    public var indicator:FlxText;
    public function new(X:Float = 0, Y:Float = 0)
    {        
        super(X, Y);
        loadGraphic(AssetPaths.door__png);
    }
}