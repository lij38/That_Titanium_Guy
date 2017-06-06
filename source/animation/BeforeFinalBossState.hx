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

class BeforeFinalBossState extends FlxState
{
	private var _player:PlayerAnimation;
	private var _wife:WifeAnimation;
	private var count:Int = 0;
	private var _dialog:Dialog;
	private var _text:FlxText;
	private var _bg:FlxSprite;

	private var _enemy:FinalBossAnimation;

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

	private var begin_walk:Bool;

	override public function create():Void
	{
		// animation stage parameters
		_stage1 = true;
		_stage2 = false;
		_stage3 = false;
		_stage4 = false;
		begin_walk = false;

		_bg = new FlxSprite();
		_bg.loadGraphic(AssetPaths.fbabg__png, false, 1178, 600);

		add(_bg);

		// initialize with all conversations
		_text_array = new Array<String>();
		_conv_index = 0;
		_text_array.push("J. Hypin: Katy  !  !  !");
		_text_array.push("J. Hypin: What the hell did you do to my wife?");
		_text_array.push("Don Clint: HAHAHAHAHAHAHAHA. She will soon be absorbed by me. And the next is you !");
		_text_array.push("J. Hypin: I will kill you!");
		_text_array.push("Rules: You have to kill Don Clint in 120 secs to save Katy");

		_player = new PlayerAnimation(120,330,0);
		_enemy = new FinalBossAnimation(500, 130, 0);

		_dialog = new Dialog(39, 431);
		_dialog.width = 720;
		_dialog.height = 145;
		_skiptext = new FlxText(FlxG.width / 2 - 120, 20, 250, "Press ESC to skip", 30);
		_skiptext.setFormat(AssetPaths.FONT, _skiptext.size);

		_text = new FlxText(200, 450, 530, 23);
		_text.setFormat(AssetPaths.FONT, _text.size);
		_helptext = new FlxText(300, 540, 300, "Press ENTER to continue", 20);
		_helptext.setFormat(AssetPaths.FONT, _helptext.size);
		_helptext.visible = false;
		_text.width = 300;
		_text.height = 100;

		 add(_player);
		 add(_enemy);

		 add(_dialog);
		 add(_text);
		 add(_helptext);
		 add(_skiptext);

		FlxG.camera.fade(FlxColor.BLACK, .25, true);

		FlxG.sound.playMusic(AssetPaths.dramatic__mp3);

		super.create();
		
	}

	override public function update(elapsed:Float):Void {
		
		if(FlxG.keys.anyJustPressed([ESCAPE])) {
			//FlxG.switchState(new TutorialState());
		}

		// hypin talks to the boss 
		if (_stage1) {
			count++;
			if (count == 10) {
				_dialog.dialog1();
		     	_text.text = _text_array[0];
		     	_text.visible = true;
		     	_helptext.visible = true;
		     } else if (count > 10) {
		     	var space:Bool = FlxG.keys.anyJustPressed([ENTER]);
		 		if (space) {	
	 				if (_conv_index == 4) {
		 				_dialog.visible = false;
	 					_text.visible = false;
	 					_helptext.visible = false;
		 				_stage1 = false;
		 				_stage2 = true;
		 				count = 0;
		 			} else {
			 			_conv_index += 1;
			 			if (_conv_index == 4) {
			 				_dialog.dialog4();
			 			} else if (_conv_index == 2) {
			 				_dialog.dialog5();
			 			} else {
			 				_dialog.dialog1();
			 			}
			 			_text.text = _text_array[_conv_index];
		 			}
		 		}
		     }

		 // stage2: katy and boss run towards each other
	 	} else if (_stage2) {
	 		count++;
	 		if (count > 10 && count < 100 && count % 3 ==0) {
	 			// hypin and enemy walks towards each other
	 			_player.animation.play("Run");
		     	_player.x += 4;
		     	_enemy.animation.play("lr");
		     	_enemy.x -= 4;
		    } else if (count > 115) {
		    	// switch state
		    }
		}
	 	

		super.update(elapsed);
	}
}