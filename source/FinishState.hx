package;

import flixel.FlxState;
import flixel.text.FlxText;

class FinishState extends FlxState
{
    override public function create():Void
    {
        var text = new flixel.text.FlxText(140, 50, 0, "Stage Cleared!", 35);
        add(text);
        var rating = new flixel.text.FlxText(140, 150, 0, "Rating: Gold", 25);
        add(rating);
        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
}