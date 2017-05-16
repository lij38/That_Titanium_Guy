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
import weapons.*;
import enemies.*;


class TutorialState extends PlayState {
	private var shield:FlxSprite;   //Shield in this map
	private var texts:FlxTypedGroup<FlxText>;    //Instructions present in them map
	private var _keys:FlxTilemap;   //

    override public function create():Void {
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
             _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7209, 7208, 7209);
		//load keys
         _keys.loadMapFromArray(cast(_map.getLayer("keys"), TiledTileLayer).tileArray, _map.width,
             _map.height, AssetPaths.keys__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7210, 7209, 8085);
        
         _background.setTileProperties(1, FlxObject.NONE);
         _plat.setTileProperties(7209, FlxObject.ANY);
		 _keys.setTileProperties(7210, FlxObject.ANY);
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
		add(shield);
		add(texts);
    }

	override public function update(elapsed:Float):Void  {
		if (enemiesGroup.countLiving() == -1) {
			Main.SAVE.data.tutComplete = true;
		}
	 	super.update(elapsed);
		FlxG.overlap(shield, _player, onPickup);
		FlxG.collide(shield, _plat);
	}

	//Place all the instructions
    private function placeInstructions(entityName:String, entityData:Xml):Void 
    {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		var k:FlxText = new FlxText(x, y, 100, "Hold to Shield", 19);
		k.setFormat(AssetPaths.FONT, k.size);
		var space:FlxText = new FlxText(x, y, 250, "Space to Roll through enemies", 19);
		space.setFormat(AssetPaths.FONT, k.size);
		var rb:FlxText = new FlxText(x, y, 250, "Roll to dodge bullets", 19);
		rb.setFormat(AssetPaths.FONT, k.size);
		switch entityName {
           case "K": texts.add(k);
           case "SPACE": texts.add(space);
		   case "RB": texts.add(rb);
       }
    }



	private function onPickup(a:FlxSprite, b:FlxSprite):Void {
		shield.kill();
		_player.pickUpShield();
	}
}