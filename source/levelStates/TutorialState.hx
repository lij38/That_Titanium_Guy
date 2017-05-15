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
	private var shield:FlxSprite;
	//private var texts:FlxTypedGroup<FlxText>;

    override public function create():Void {
        //////////////////////////////////////////////////
        //LOAD MAP
        //////////////////////////////////////////////////
         _map = new TiledMap(AssetPaths.tutorial__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.tutorialBG__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2, 2, 1771);
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
		//texts = new FlxTypedGroup<FlxText>();

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
		super.create();
		//add(texts);
		add(shield);
		Main.LOGGER.logLevelStart(1);
    }

	override public function update(elapsed:Float):Void  {
		if (enemiesGroup.countLiving() == -1) {
			Main.SAVE.data.tutComplete = true;
		}
	 	super.update(elapsed);
		FlxG.overlap(shield, _player, onPickup);
		FlxG.collide(shield, _plat);
	}

	// //Place all the instructions
    // private function placeInstructions(entityName:String, entityData:Xml):Void 
    // {
	// 	var x:Int = Std.parseInt(entityData.get("x"));
	// 	var y:Int = Std.parseInt(entityData.get("y"));
    //     _locations.set(x, entityName); 
    //     _sorted.push(x);
	// 	switch entityName {
    //        case "A": texts.add(new FlxText(x + 40, y - 100, 300, "Press A to move to the left", 12));
    //        case "D": texts.add(new FlxText(x + 40, y - 100, 300, "Press D to move to the right", 12));
    //        case "W": texts.add(new FlxText(x + 40, y - 100, 300, "Press W to jump", 12));
    //        case "J": texts.add(new FlxText(x + 40, y - 100, 300, "Press J to attack",12));
    //        case "K": texts.add(new FlxText(x + 40, y - 100, 300, "Press and hold K to use the shield", 12));
    //        case "SPACE": texts.add(new FlxText(x + 40, y - 100, 300, "Press SPACE to roll to dodge the bullets", 12));
    //        case "SPACE1": texts.add(new FlxText(x + 40, y - 100, 300, "Press SPACE and try to roll through the enemy", 12));
    //    }
    // }



	private function onPickup(a:FlxSprite, b:FlxSprite):Void {
		shield.kill();
		_player.pickUpShield();
	}
}