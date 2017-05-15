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
import flixel.FlxSprite;
import weapons.*;
import enemies.*;


class TutorialState extends PlayState {
	private var shield:FlxSprite;   //Shield in this map
	private var texts:FlxTypedGroup<FlxSprite>;    //Instructions present in them map

    override public function create():Void {
        //////////////////////////////////////////////////
        //LOAD MAP
        //////////////////////////////////////////////////
        _map = new TiledMap(AssetPaths.tutorial__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.tutorialBG__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2, 1, 1771);
        //load platform
         _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
             _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
        
         _background.setTileProperties(2, FlxObject.NONE);
         _plat.setTileProperties(1, FlxObject.ANY);
         _background.follow();
		 _plat.follow();

		/////////////////////////////////////////////
        //LOAD INSTRUCTIONS
		////////////////////////////////////////////
		texts = new FlxTypedGroup<FlxSprite>();
		// var instructLayer:TiledObjectLayer = cast _map.getLayer("instructions");
		// for (e in instructLayer.objects) {
		// 	placeInstructions(e.name, e.xmlData.x);
		// }
		// add(texts);


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
		add(shield);
		Main.LOGGER.logLevelStart(1);
		super.create();
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
    // private function placeInstructions(entityName:String, entityData:Xml):Void 
    // {
	// 	var x:Int = Std.parseInt(entityData.get("x"));
	// 	var y:Int = Std.parseInt(entityData.get("y"));
	// 	switch entityName {
    //        case "A": texts.add(new FlxSprite(x, y, AssetPaths.a__png));
    //        case "D": texts.add(new FlxSprite(x, y, AssetPaths.d__png));
    //        case "W": texts.add(new FlxSprite(x, y, AssetPaths.w__png));
    //        case "J": texts.add(new FlxSprite(x, y, AssetPaths.j__png));
    //        case "K": texts.add(new FlxSprite(x, y, AssetPaths.k__png));
    //        case "SPACE": texts.add(new FlxSprite(x, y, AssetPaths.space__jpg));
    //    }
    // }



	private function onPickup(a:FlxSprite, b:FlxSprite):Void {
		shield.kill();
		_player.pickUpShield();
	}
}