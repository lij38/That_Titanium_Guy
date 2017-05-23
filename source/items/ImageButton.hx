package items;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class ImageButton extends FlxButton {
	//private var text2:FlxText;
	
	public function new(X:Float = 0, Y:Float = 0, ?Text:String, ?OnClick:Void->Void) {
		super(X, Y, OnClick);
		//makeGraphic(200, 40, FlxColor.BLACK);
		//setSize(200, 40);
		onOver.callback = flash;
		onOut.callback = unflash;
		color = 0xdddddd;
		//text2 = new FlxText(x, y, 500, Text, 36);
		//text2.color = 0x999999;
		//text2.setFormat(AssetPaths.FONT, text2.size);
		//text = "New Game";
		//add(text);
	}

	private function flash():Void {
        color = 0xffffff;
        //text2.color = 0xffffff;
    }

    private function unflash():Void {
        color = 0xdddddd;
        //text2.color = 0x999999;
    }

    //override public function draw():Void
	//{
		//super.draw();
		//text2.draw();
	//}
	
}