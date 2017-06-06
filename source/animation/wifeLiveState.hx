package animation;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.addons.editors.tiled.TiledMap;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import levelStates.*;
import otherStates.*;

class WifeLiveState extends FlxState
{
	private var _player:PlayerAnimation;
	private var _wife:WifeAnimation;
	private var count:Int = 0;
	private var _dialog:Dialog;
	private var _bg:FlxSprite;
	private var _text:FlxText;
	private var _helptext:FlxText;
	private var _skiptext:FlxText;
	// an array stores all conversations
	private var _text_array:Array<String>;
	// index of conversation (in text array)
	private var _conv_index:Int;
	// stage 1 is enemy entering the scene to the first sentence of enemy
	private var _stage1:Bool;
	// stage 2 is enemy talks
	private var _stage2:Bool;
	// stage 3 is hypin walks wife and children out of scene
	private var _stage3:Bool;
	// hypin and enemy run towards each others
	private var _stage4:Bool;

	private var begin_walk:Bool = false;

	override public function create():Void
	{
		_bg = new FlxSprite();
		_bg.loadGraphic(AssetPaths.finalBossBg__png);

		_stage1 = true;
		_stage2 = false;
		_stage3 = false;
		_stage4 = false;

		// initialize with all conversations
		_text_array = new Array<String>();
		_conv_index = 0;
		_text_array.push("Katy lived! You saved your wife!");
		_text_array.push("J. Hypin: ...!");
		_text_array.push("Katy Hypin: ...*groans* where... am I?");
		_text_array.push("J: Don't worry, you are safe now! It's ok... it's all over. Let's go home...");

		_player = new PlayerAnimation(200,305,0);
		_wife = new WifeAnimation(600, 300, 0);
		_wife.facing = FlxObject.LEFT;

		_dialog = new Dialog(39, 431);
		_dialog.width = 720;
		_dialog.height = 145;
		// _skiptext = new FlxText(FlxG.width / 2 - 120, 20, 250, "Press ESC to skip", 30);
		// _skiptext.setFormat(AssetPaths.FONT, _skiptext.size);

		_text = new FlxText(200, 450, 530, 23);
		_text.setFormat(AssetPaths.FONT, _text.size);
		_helptext = new FlxText(300, 540, 300, "Press ENTER to continue", 20);
		_helptext.setFormat(AssetPaths.FONT, _helptext.size);
		_helptext.visible = false;
		_text.width = 300;
		_text.height = 100;

		 add(_bg);
		 add(_player);
		 add(_wife);
		 add(_dialog);
		 add(_text);
		 add(_helptext);
		 //add(_skiptext);

		FlxG.camera.fade(FlxColor.BLACK, .25, true);

		FlxG.sound.playMusic(AssetPaths.dramatic__mp3);

		super.create();
		
	}

	override public function update(elapsed:Float):Void {
		
		if(FlxG.keys.anyJustPressed([ESCAPE])) {
			FlxG.switchState(new CreditState());
		}

		// narrator
		if(_stage1) {
			_dialog.dialog4();
			_text.text = _text_array[0];
			_text.visible = true;
			_helptext.visible = true;
			var space:Bool = FlxG.keys.anyJustPressed([ENTER]);
			if (space) {
				_dialog.dialog1();
				_conv_index += 1;
				_text.text = _text_array[_conv_index];
				_stage1 = false;
				_stage2 = true;
			}
		} else if(_stage2) {
			var space:Bool = FlxG.keys.anyJustPressed([ENTER]);
			if (space) {
				_conv_index += 1;
				_dialog.dialog3();
				_text.text = _text_array[_conv_index];
				_stage2 = false;
				_stage3 = true;
			} 
		} else if(_stage3) {
			count++;
			_helptext.visible = false;
			if (count < 200 && count % 3 == 0) {
				// hypin and enemy walks towards each other
				_player.animation.play("Run");
				_player.x += 4;
			} else if (count > 200) {
				begin_walk = false;
				_stage3 = false;
				_stage4 = true;
				_conv_index += 1;
			}
		} else if (_stage4) {
			_text.text = _text_array[_conv_index];
			_text.visible = true;
			_helptext.visible = true;
			_dialog.dialog1();
			_dialog.visible = true;
			var space:Bool = FlxG.keys.anyJustPressed([ENTER]);
			if (space) {
				FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
					FlxG.switchState(new CreditState());
				});
			} 
		}
		super.update(elapsed);
	}
}