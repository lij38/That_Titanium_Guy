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
    private var _instruct:Instruction;

    private var _locations:Map<Int, String>;
    private var _sorted:Array<Int>;
    private var _next:Int;
	
	private var shield:FlxSprite;
	private var texts:FlxTypedGroup<FlxText>;

    override public function create():Void {
        //LOAD MAP BASICS
        _map = new TiledMap(AssetPaths.tutorialFormal__tmx);

		//LOAD SHIELD
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
		add(texts);
		add(shield);
    }

	override public function update(elapsed:Float):Void  {
	 	super.update(elapsed);
		//instructInit(elapsed);
		FlxG.collide(shield, _bound);
		FlxG.overlap(shield, _player, onPickup);
	}

	//Place all the instructions
    private function placeInstructions(entityName:String, entityData:Xml):Void 
    {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
        _locations.set(x, entityName); 
        _sorted.push(x);
		switch entityName {
           case "A": texts.add(new FlxText(x + 40, y - 100, 300, "Press A to move to the left", 12));
           case "D": texts.add(new FlxText(x + 40, y - 100, 300, "Press D to move to the right", 12));
           case "W": texts.add(new FlxText(x + 40, y - 100, 300, "Press W to jump", 12));
           case "J": texts.add(new FlxText(x + 40, y - 100, 300, "Press J to attack",12));
           case "K": texts.add(new FlxText(x + 40, y - 100, 300, "Press and hold K to use the shield", 12));
           case "SPACE": texts.add(new FlxText(x + 40, y - 100, 300, "Press SPACE to roll to dodge the bullets", 12));
           case "SPACE1": texts.add(new FlxText(x + 40, y - 100, 300, "Press SPACE and try to roll through the enemy", 12));
       }
    }


	// private function placeEnemies(entityName:String, entityData:Xml):Void
	// {
	// 	var x:Int = Std.parseInt(entityData.get("x"));
	// 	var y:Int = Std.parseInt(entityData.get("y"));
	// 	var eh:EnemyHUD;
	// 	var en:Enemy;
	// 	if (entityName == "MELEE") {
	// 		en = new MeleeEnemy(x, y, enemiesBullets, GRAVITY);
	// 	} else {
	// 		en = new RifleEnemy(x, y, enemiesBullets, GRAVITY);
	// 	}
	// 	eh = new EnemyHUD(en);
	// 	enemiesGroup.add(en);
	// 	_enemiesMap.set(en, eh);
	// 	_enemiesHUD.add(eh);
	// }

    private function instructInit(elapsed:Float):Void {   
        //trace(_player.x + "     " +_next);
        //trace(_player.x == cast(_next, Float));
        //if (!(Std.int(_player.x) > _next && !(Std.int(_player.x) < _next)) {
		//trace(Std.int(_player.x) + "       " + Std.int(_next));
		//trace(_sorted.length);
        if (Std.int(_player.x) == Std.int(_next)) {
		    //trace("Reached!");
            _instruct.instruct(_locations.get(_next), _player.x - 40, _player.y - 40);
            
            _next = _sorted.shift();
        }        
    }

	private function onPickup(a:FlxSprite, b:FlxSprite):Void {
		shield.kill();
		_player.pickUpShield();
	}
}