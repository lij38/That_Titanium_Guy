// package;

// import flixel.FlxSprite;
// import flixel.FlxG;
// using flixel.util.FlxSpriteUtil;
// import flixel.util.FlxColor;
// import flixel.text.FlxText;

// class Instruction extends FlxText {
//     private var _text:StringBuf;
//     private var content:String;
//    // public var display:Bool;
//     private var index:Int;
//     private var lineStyle:LineStyle = { color: FlxColor.RED, thickness: 1 };
//     private var drawStyle:DrawStyle = { smoothing: true };

//     public function new(X:Float = 0, Y:Float = 0, embed:String) {
//         super(X, Y);
//         _text = new StringBuf();
//         content = new FlxSprite(X, Y, 250, embed, 20)
//         //var ad:FlxText = new FlxText(x, y, 250, "To Move", 19);
// 		content.setFormat(AssetPaths.FONT, 20);
//      //   display = false;
//         index = 0;
//         visible = true;
//         //black box
//         makeGraphic(300, 300, FlxColor.BLACK, true);
//         //red border
//         content.setBorderStyle(OUTLINE, FlxColor.TRANSPARENT, 1);
//        // drawRect(X, Y, 200, 200, FlxColor.WHITE, lineStyle, drawStyle);
//        add(content);
//     }

//     // override public function update(elapsed:Float):Void{
//     //     //display like a typer
//     //     if (display && index < _text.length()) {
//     //         _text.add(embed.charAt(index));
//     //         text = _text.toString();
//     //         index ++;       
//     //     }
//     // }
// }