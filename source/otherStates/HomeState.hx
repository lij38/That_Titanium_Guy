package otherStates;

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
import weapons.*;
import flixel.ui.FlxButton;
import items.*;

class HomeState extends FlxState {
	
	private var _wife:Wife;
	
	private var _map:TiledMap;
	private var _bg:FlxTilemap;
	private var _fg:FlxTilemap;
	private var _player:Player;
	private var playerBullets:FlxTypedGroup<Bullet>;
	private var tutorial_map:Bool;
	private var _mapbutton:ImageButton;
	private var _arrow:Arrow;
	private var _text:FlxText;
	private var tutState:Bool;
	private var _workshop:FlxSprite;
	private var _maptext:FlxText;
	private var _workshoptext:FlxText;
	private var _stage1:Bool;
	private var _stage2:Bool;
	//private var _stage3:Bool;
	
	// pause state and menu
	private var _pause:Bool;
	private var _menu_bg:FlxSprite;
	private var _menubutton:ImageButton;
	private var _resumebutton:ImageButton;
	private var _homebutton:ImageButton;
	private var _pausebutton:FlxText;
	private var _pausetxt:FlxText;
	private var _blackmarket:ImageButton;
	private var _bmtxt:FlxText;

	override public function create():Void {
		//FlxG.debugger.drawDebug = true;
		// load map and set a platform that player can stand on (row 17th)
		_map = new TiledMap(AssetPaths.home__tmx);
		_bg = new FlxTilemap();
		_bg.loadMapFromArray(cast(_map.getLayer("map1"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.home__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 391);
		add(_bg);
		_bg.follow();

		_fg = new FlxTilemap();
		_fg.loadMapFromArray(cast(_map.getLayer("foreground"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.home__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
		add(_fg);
		_fg.follow();

		playerBullets = new FlxTypedGroup<Bullet>();
		_player = new Player(playerBullets, 1500);

		_workshop = new ImageButton(0, 0, switchWorkshopState);
		_workshop.loadGraphic(AssetPaths.workshop__png, false, 350, 290);
		_workshop.scrollFactor.set(1);
		add(_workshop);
		_workshop.color = 0xdddddd;

		_maptext = new FlxText(0, 0, 200, 20);
        _maptext.text = "CLICK or PRESS M to open map";
        _maptext.setFormat(AssetPaths.FONT, 20);
        _maptext.scrollFactor.set(0.0);
        _maptext.visible = false;
        add(_maptext);

        _workshoptext = new FlxText(0, 0, 500, 24);
        _workshoptext.text = "PRESS W to enter workshop";
        _workshoptext.setFormat(AssetPaths.FONT, 24);
        _workshoptext.visible = false;
        add(_workshoptext);

        _blackmarket = new ImageButton(0, 0, switchBlackMarketState);
        _blackmarket.loadGraphic(AssetPaths.blackmarket__png, false, 470, 372);
		_blackmarket.scrollFactor.set(1);
        add(_blackmarket);
        _blackmarket.visible = false;
        _blackmarket.active = false;
        _blackmarket.color = 0xdddddd;

        _bmtxt = new FlxText(0, 0, 500, 24);
        _bmtxt.text = "PRESS W to enter blackmarket";
        _bmtxt.setFormat(AssetPaths.FONT, 24);
        _bmtxt.visible = false;
        add(_bmtxt);
        

		var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
		 for (e in tmpMap.objects) {
		     placeEntities(e.type, e.xmlData.x);
		 }
		 add(playerBullets);
		 
		_wife = new Wife(500, 200);
		add(_wife);
		add(_player);
		 

		 _mapbutton = new ImageButton(31, 26, switchMapState);
		 _mapbutton.scrollFactor.set(0.0);
		 _mapbutton.loadGraphic(AssetPaths.map_icon__png, false, 70, 70);
		 add(_mapbutton);

		 if(Main.SAVE.data.homeTut == null ||Main.SAVE.data.homeTut == false) {
			 tutorial_map = true;
			 tutState = true;
			 _stage1 = true;
			 _stage2 = false;
			 //_stage3 = false;
			 _mapbutton.active = false;
			 _workshop.active = false;
			 Main.SAVE.data.homeTut = true;
			 Main.SAVE.flush();
		 } else {
			 tutorial_map = false;
			 tutState = false;
		 }

		 if (tutorial_map) {
		 	_fg.color = 0x777777;
		 	_bg.color = 0x777777;
		 	_player.color = 0x777777;
		 	_workshop.color = 0x777777;
			_blackmarket.color = 0x777777;
		 	_arrow = new Arrow();
			 _arrow.x = 120;
			 _arrow.y = 50;
			 add(_arrow);
			 _arrow.visible = false;
			 _text = new FlxText(0, 0, 330, 20);
			 _text.x = 450;
			 _text.y = 36;
        	_text.text = "This is your home! You can move and try your weapons. (Click Anywhere to continue)";
        	_text.setFormat(AssetPaths.FONT, 20);
        	add(_text);
		 }

		 FlxG.camera.follow(_player, LOCKON, 1);
		 
		 //trace(FlxG.sound.music);
		 if(FlxG.sound.music.playing == false) {
		 	FlxG.sound.playMusic(AssetPaths.theme__mp3);
		 }

		 //Main.SAVE.data.levelCompleted = 4;
		 if (Main.SAVE.data.levelCompleted != null && Main.SAVE.data.levelCompleted > 3) {
		 	_blackmarket.visible = true;
        	_blackmarket.active = true;
		 }
		 
		


		 // pause part and whole pause menu
		_pause = false;

		_menu_bg = new FlxSprite(0, 0);
		_menu_bg.makeGraphic(800, 600, FlxColor.BLACK);
		_menu_bg.scrollFactor.set(0.0);


		_homebutton = new ImageButton(300, 200, clickHome);
		_homebutton.loadGraphic(AssetPaths.gohome__png, false, 200, 40);
		_homebutton.scrollFactor.set(0.0);
		_menubutton = new ImageButton(300, 310, clickMenu);
		_menubutton.loadGraphic(AssetPaths.menu__png, false, 200, 40);
		_menubutton.scrollFactor.set(0.0);
		_resumebutton = new ImageButton(300, 420, clickResume);
		_resumebutton.loadGraphic(AssetPaths.resume__png, false, 200, 40);
		_resumebutton.scrollFactor.set(0.0);

		
		
		_pausebutton = new FlxText(31, 100, 600, "Press ESC to PAUSE", 20);
		_pausebutton.setFormat(AssetPaths.FONT, _pausebutton.size);
		_pausebutton.scrollFactor.set(0.0);
		_pausebutton.visible = false;

		_pausetxt = new FlxText(240, 85, 600, "Game Paused", 50);
		_pausetxt.setFormat(AssetPaths.FONT, _pausetxt.size);
		_pausetxt.scrollFactor.set(0.0);
		addTopLayer();
		
		
		 //Main.SAVE.data.levelCompleted = 4;
		 if (Main.SAVE.data.levelCompleted >= 3) {
		 	_blackmarket.visible = true;
        	_blackmarket.active = true;
		 }
		 super.create();
	}

	override public function update(elapsed:Float):Void {
		
		if (FlxG.keys.justPressed.ESCAPE) {
			_pause = !_pause;
		}
		if (_pause) {
			activeButtons();
			_homebutton.update(elapsed);
			_menubutton.update(elapsed);
			_resumebutton.update(elapsed);
			return;
		} else {
			disableButtons();
		}
		
		
		if (!tutorial_map) {
			if (FlxG.keys.anyPressed([M])) {
				switchMapState();
			}
			checkEnter(_player, _workshop, _workshoptext, switchWorkshopState);
		}
		if (_blackmarket.active) {
			checkEnter(_player, _blackmarket, _bmtxt, switchBlackMarketState);
		}
		FlxG.collide(_player, _fg);
		// wife
		if (!_player.isTumbling()) {
			FlxG.collide(_wife, _player);
		}
		FlxG.collide(_wife, _fg);
		FlxG.overlap(playerBullets, _wife, bulletHitsWife);
		
		if (tutorial_map) {
			var click:Bool = false;
	        if (FlxG.mouse.justPressed) {
	            click = true;
	        }
			
			if (_stage1) {
				if (click) {
					_stage1 = false;
					_stage2 = true;
					_arrow.visible = true;
					_text.x = 175;
		 			_text.y = 35;
    				_text.text = "This is the map, you can click here to go back to the map and challenge new levels. (Click Anywhere to continue)";
				}
			} else if (_stage2) {
				if (click) {
					// _stage2 = false;
					// _stage3 = true;
					// _arrow.x = 295;
					// _arrow.y = 350;
					// _arrow.loadGraphic(AssetPaths.arrow2__png, false, 25, 40);
					// _text.x = 177;
					// _text.y = 415;
					// _text.text = "This is the workshop, you can equip and change your weapon configurations here!";
					tutorial_map = false;
		        	_arrow.visible = false;
		        	_text.visible = false;
		        	_bg.color = 0xffffff;
		        	_player.color = 0xffffff;
		        	_fg.color = 0xffffff;
		        	_workshop.color = 0xdddddd;
					_blackmarket.color = 0xdddddd;
		        	_mapbutton.active = true;
					_workshop.active = true;
					_maptext.visible = true;
				}
			} //else if (_stage3) {
			// 	if (click) {
			// 		_stage3 = false;
			// 		tutorial_map = false;
		    //     	_arrow.visible = false;
		    //     	_text.visible = false;
		    //     	_bg.color = 0xffffff;
		    //     	_player.color = 0xffffff;
		    //     	_fg.color = 0xffffff;
		    //     	_workshop.color = 0xdddddd;
		    //     	_mapbutton.active = true;
			// 		_workshop.active = true;
			// 		_maptext.visible = true;
	        // 	}
			// }
        	
		} else {
			_maptext.visible = true;
		}
		
		FlxG.collide(_player, _bg);
		super.update(elapsed);
	}

	private function checkEnter(player:Player, object:FlxSprite, text:FlxText, fn:Void->Void) {
		if (player.x + player.width >= object.x && player.x <= object.x + object.width) {
			object.color = 0xffffff;
			text.visible = true;
			if (FlxG.keys.anyJustPressed([W])) {
				fn();
			}
		} else {
			object.color = 0xdddddd;
			text.visible = false;
		}
	}

	private function placeEntities(entityName:String, entityData:Xml):Void {
	    var x:Int = Std.parseInt(entityData.get("x"));
	    var y:Int = Std.parseInt(entityData.get("y"));

	    if (entityName == "player") {
	        _player.x = x;
	        _player.y = y;
		} else if (entityName == "workshop") {
			_workshop.x = x;
			_workshop.y = y;
		} else if (entityName == "maptxt") {
			_maptext.x = x;
			_maptext.y = y;
		} else if (entityName == "workshoptxt") {
			_workshoptext.x = x;
			_workshoptext.y = y;
		} else if (entityName == "blackmarket") {
			_blackmarket.x = x;
			_blackmarket.y = y;
		} else if (entityName == "bmtxt") {
			_bmtxt.x = x;
			_bmtxt.y = y;
		}
	}
	
	private function bulletHitsWife(bullet:Bullet, wife:Wife) {
		if (bullet.getType() == "shotgun") {
			var len:Int = Std.int(cast(bullet, ShotgunBullet).getPushBack());
			wife.knockBack(len, bullet.facing);
		}
		playerBullets.remove(bullet);
		bullet.destroy();
		wife.hurt(0);
	}
	
	private function switchWorkshopState():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new WorkshopState());
		});
    }

    private function switchBlackMarketState():Void {
    	FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new MarketState());
		});
    }

	private function switchMapState():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			if(tutState) {
				FlxG.switchState(new MapTutorialState());
			} else {
        		FlxG.switchState(new MapState());	
			}
		});
    }
	
	public function addTopLayer():Void {
		add(_pausebutton);
		add(_menu_bg);
		add(_homebutton);
		add(_menubutton);
		add(_resumebutton);
		add(_pausetxt);
	}
	
	private function activeButtons():Void {
		_menu_bg.visible = true;
		_menu_bg.alpha = 0.8;
		_menubutton.visible = true;
		_menubutton.active = true;
		_resumebutton.visible = true;
		_resumebutton.active = true;
		if (Main.SAVE.data.levelCompleted != null && Main.SAVE.data.levelCompleted >= 2) {
			_homebutton.visible = true;
			_homebutton.active = true;
		}
		_pausetxt.visible = true;
	}

	private function disableButtons():Void {
		_menu_bg.visible = false;
		_homebutton.visible = false;
		_homebutton.active = false;
		_menubutton.visible = false;
		_menubutton.active = false;
		_resumebutton.visible = false;
		_resumebutton.active = false;
		_pausetxt.visible = false;
	}

	private function clickHome():Void {
        _pause = false;
    }

    private function clickMenu():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.sound.music.destroy();
			FlxG.switchState(new MenuState());
		});
    }

    private function clickResume():Void {
    	_pause = false;
    }

    private function clickPause():Void {
    	_pause = true;
    }
}