package levelStates;

import flixel.*;
import flixel.addons.editors.tiled.TiledMap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import weapons.*;
import enemies.*;


class TutorialState extends PlayState {
	private var shield:FlxSprite;   //Shield in this map
	private var texts:FlxTypedGroup<FlxText>;    //Instructions present in them map
	private var _keys:FlxTilemap;   //

    override public function create():Void {
		LEVELID = 1;
        //////////////////////////////////////////////////
        //LOAD MAP
        //////////////////////////////////////////////////
        _map = new TiledMap(AssetPaths.tutorialState__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();
		_keys = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.tutorialBG__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 7209);
        //load platform
         _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
             _map.height, AssetPaths.city__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7209, 7208, 7209);
		//load keys
         _keys.loadMapFromArray(cast(_map.getLayer("keys"), TiledTileLayer).tileArray, _map.width,
             _map.height, AssetPaths.keyboard__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7245, 7244, 10052);
        
         _background.setTileProperties(1, FlxObject.NONE);
         _plat.setTileProperties(7209, FlxObject.ANY);
		 _keys.setTileProperties(7245, FlxObject.NONE);
         _background.follow();
		 _plat.follow();
		 _keys.follow();

		/////////////////////////////////////////////
        //LOAD INSTRUCTIONS
		////////////////////////////////////////////
		texts = new FlxTypedGroup<FlxText>();
		var instructLayer:TiledObjectLayer = cast _map.getLayer("instruction");
		for (e in instructLayer.objects) {
			placeInstructions(e.name, e.xmlData.x);
		}


		////////////////////////////////////////////
		//LOAD SHIELD
		/////////////////////////////////////////////
		shield = new FlxSprite();
		shield.loadGraphic(AssetPaths.shield__png);
		var shieldLayer:TiledObjectLayer = cast _map.getLayer("shield");
		for (e in shieldLayer.objects) {
			var x:Int = Std.parseInt(e.xmlData.x.get("x"));
			var y:Int = Std.parseInt(e.xmlData.x.get("y"));
			if (e.name == "SHIELD") {
				shield.x = x;
				shield.y = y;
			}
		}

		Main.LOGGER.logLevelStart(1);

		super.create();
		add(_keys);
		if(Main.SAVE.data.levelCompleted == null || Main.SAVE.data.levelCompleted < 1) {
			add(shield);
		}
		add(texts);
		add(_player);
        add(_hud);

        addTopLayer();
		if (Main.SAVE.data.stararr == null) {
			Main.SAVE.data.stararr = [null, null, null, null, null, null, null];
		}
    }

	override public function update(elapsed:Float):Void  {
	 	super.update(elapsed);
		FlxG.overlap(shield, _player, onPickup);
		FlxG.collide(shield, _plat);
	}

	//Place all the instructions
    private function placeInstructions(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		var k:FlxText = new FlxText(x, y, 250, "Hold to Shield", 19);
		k.setFormat(AssetPaths.FONT, k.size);
		var s:FlxText = new FlxText(x, y, 250, "S to Roll through enemies", 19);
		s.setFormat(AssetPaths.FONT, s.size);
		var rb:FlxText = new FlxText(x, y, 250, "Roll to dodge bullets", 19);
		rb.setFormat(AssetPaths.FONT, rb.size);
		var ad:FlxText = new FlxText(x, y, 250, "To Move", 19);
		ad.setFormat(AssetPaths.FONT, ad.size);
		var space:FlxText = new FlxText(x, y, 250, "Jump", 19);
		space.setFormat(AssetPaths.FONT, space.size);
		var j:FlxText = new FlxText(x, y, 250, "Attack", 19);
		j.setFormat(AssetPaths.FONT, j.size);
		var w:FlxText = new FlxText(x, y, 250, "Exit", 19);
		w.setFormat(AssetPaths.FONT, w.size);
		switch entityName {
           case "K": texts.add(k);
           case "S": texts.add(s);
		   case "RB": texts.add(rb);
		   case "AD": texts.add(ad);
		   case "SPACE": texts.add(space);
		   case "J": texts.add(j);
		   case "W": texts.add(w);
       }
    }



	private function onPickup(a:FlxSprite, b:FlxSprite):Void {
		shield.kill();
		_player.pickUpShield();
	}
}