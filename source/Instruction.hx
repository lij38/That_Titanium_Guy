package;
import flixel.*;
import flixel.text.FlxText;


class Instruction extends FlxText {
    private static inline var D:String = "Press D to move to the right";
    private static inline var A:String = "Press A to move to the left";
    private static inline var W:String = "Press W to jump";
    private static inline var J:String = "Press J to attack";
    private static inline var K:String = "Press K to use the shied";
    private static inline var SPACE:String = "Press SPACE to tumble";
    private var _current:String;
    
    override public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8) {
        _current = "";
        text = "";
        visible = false;
        super(X, Y, FieldWidth, Size);
    }

    public function instruct(option:String, X:Float, Y:Float):Void {
       switch option {
           case "A": text = A;
           case "D": text = D;
           case "W": text = W;
           case "J": text = J;
           case "K": text = K;
           case "SPACE": text = SPACE;
       }

       _current = option;
       x = X;
       y = Y;
       trace(text);
       visible = true;
    }

    override public function update(elapsed:Float):Void {
        if (visible) {
            complete(elapsed);
        }
        super.update(elapsed);
    }

    private function complete(elapsed:Float):Void { 

        var jump:Bool = false;
		//var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		//var doubleJump:Bool = false;
		//var leftP:Bool = false;
		//var rightP:Bool = false;
		//var jetpack:Bool = false;
		var roll:Bool = false;
        var attack:Bool = false;
        var shield:Bool = false;

        jump = FlxG.keys.anyPressed([W]);
        left = FlxG.keys.anyPressed([LEFT, "A"]);
        right = FlxG.keys.anyPressed([D]);
        roll = FlxG.keys.anyPressed([SPACE]);
        attack = FlxG.keys.anyPressed([J]);
        shield = FlxG.keys.anyPressed([K]);
        trace(left + "          " + _current);
		FlxG.watch.addQuick("A pressed", FlxG.keys.anyPressed(["A"]));
        if ((left && _current == "A") || 
            (right && _current == "D") ||
            (jump && _current == "W") ||
            (roll && _current == "SPACE") ||
            (attack && _current == "J") ||
            (shield && _current == "K")) {
                trace("Damn");
                visible = false;
            }
    
    }

}

