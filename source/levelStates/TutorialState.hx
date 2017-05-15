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
        //LOAD INSTRUCTIONS
		_locations = new Map<Int, String>();
		texts = new FlxTypedGroup<FlxText>();
        _sorted = new Array<Int>();
        var tmpLayer:TiledObjectLayer = cast _map.getLayer("instructions");
        for (e in tmpLayer.objects) {
            placeInstructions(e.name, e.xmlData.x);
        }
        haxe.ds.ArraySort.sort(_sorted, function(a, b):Int {
            if (a < b) return -1;
            else if (a > b) return 1;
            return 0;
        });
        //_instruct = new Instruction(_player.x - 40, _player.y - 40, 300, 12);
        //trace(_sorted);
        _next = _sorted.shift();
        //trace(_next);

		//LOAD ENEMIES
        enemiesBullets = new FlxTypedGroup<Bullet>();
		enemiesGroup = new FlxTypedGroup<Enemy>();
		_enemiesMap = new Map<Enemy, EnemyHUD>();
		_enemiesHUD = new FlxTypedGroup<EnemyHUD>();
		var enemyLayer1:TiledObjectLayer = cast _map.getLayer("enemiesScene1");
		var enemyLayer4:TiledObjectLayer = cast _map.getLayer("enemiesScene4");
		var enemyLayer5:TiledObjectLayer = cast _map.getLayer("enemiesScene5");
		var enemyLayer6:TiledObjectLayer = cast _map.getLayer("enemiesScene6");
		for (e in enemyLayer1.objects) {
			placeEnemies(e.name, e.xmlData.x);
		}
		for (e in enemyLayer4.objects) {
			placeEnemies(e.name, e.xmlData.x);
		}
		for (e in enemyLayer5.objects) {
			placeEnemies(e.name, e.xmlData.x);
		}
		for (e in enemyLayer6.objects) {
			placeEnemies(e.name, e.xmlData.x);
		}

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
		Main.LOGGER.logLevelStart(1);
    }

	override public function update(elapsed:Float):Void  {
		if (enemiesGroup.countLiving() == -1) {
			Main.SAVE.data.tutComplete = true;
		}
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