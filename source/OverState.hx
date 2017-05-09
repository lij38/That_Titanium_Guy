package;

import flixel.FlxState;
import flixel.text.FlxText;

class OverState extends FlxState
{
    override public function create():Void
    {
        var text = new flixel.text.FlxText(0, 0, 0, "GAME OVER", 64);
        text.screenCenter();
        add(text);
        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}