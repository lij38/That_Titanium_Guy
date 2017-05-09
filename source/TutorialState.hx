package;

import flixel.*;
import flixel.addons.editors.tiled.TiledMap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.group.FlxGroup.FlxTypedGroup;
import weapons.*;
import enemies.*;

class TutorialState extends FlxState {
    private var _player:Player;
    private var _map:TiledMap;

    private var _background:FlxTilemap;
    private var _plat:FlxTilemap;
    private var _bound:FlxTilemap;

    //private var _btnMenu:FlxButton;
    private var _instruct:Instruction;

    private var _locations:Map<Int, String>;
    private var _sorted:Array<Int>;
    private var _next:Int;
	
	private var playerBullets:FlxTypedGroup<Bullet>;
    private var _hud:HUD;
	private var enemiesGroup:FlxTypedGroup<Enemy>;
    private var enemiesBullets:FlxTypedGroup<Bullet>;
	private var GRAVITY:Float = 1000;
	private var shield:FlxSprite;

    override public function create():Void {
        //LOAD MAP BASICS
        _map = new TiledMap(AssetPaths.tutorialFormal__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();
        _bound = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.tutorialBG__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1023);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1021, 1, 1020);
        //load bounds
        _bound.loadMapFromArray(cast(_map.getLayer("bound"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1021, 1, 1020);

        _background.setTileProperties(2, FlxObject.NONE);
        _bound.setTileProperties(1, FlxObject.ANY);
        _plat.setTileProperties(1, FlxObject.ANY);
		_bound.follow();
		_plat.follow();

        enemiesBullets = new FlxTypedGroup<Bullet>();

        //LOAD PLAYER
        playerBullets = new FlxTypedGroup<Bullet>();
        _player = new Player(playerBullets, GRAVITY);
        //_btnMenu = new FlxButton(0, 0, "Menu", clickMenu);
		var tmpMap:TiledObjectLayer = cast _map.getLayer("player");
        for (e in tmpMap.objects) {
            placeEntities(e.name, e.xmlData.x);
        }

        //LOAD HUD
        _hud = new HUD(_player);


        //LOAD INSTRUCTIONS
        _locations = new Map<Int, String>();
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
        _instruct = new Instruction(_player.x - 40, _player.y - 40, 300, 12);
        trace(_sorted);
        _next = _sorted.shift();
        trace(_next);

		//LOAD ENEMIES
		enemiesGroup = new FlxTypedGroup<Enemy>();
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





        //ADD EVERY COMPONENT
        add(_background);
        add(_bound);
        add(enemiesBullets);
        add(enemiesGroup);
        add(playerBullets);
        add(_plat); 
        add(_player);
		add(shield);
        //add(_btnMenu);
        add(_instruct);
        add(_hud);
		 _hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
		 				_player.getWeaponName(0), _player.getWeaponName(1));
        FlxG.camera.follow(_player, TOPDOWN, 1);
        //Main.LOGGER.logLevelStart(1);
		super.create();
    }
	//Place player info
	private function placeEntities(entityName:String, entityData:Xml):Void  {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "START") {
			_player.x = x;
			_player.y = y;
		} else if (entityName == "END") {

        }

	}

	//Place all the instructions
    private function placeInstructions(entityName:String, entityData:Xml):Void 
    {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
        _locations.set(x, entityName); 
        _sorted.push(x);
    }


	private function placeEnemies(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "MELEE") {
			enemiesGroup.add(new MeleeEnemy(x, y, enemiesBullets, GRAVITY));
		} else {
			enemiesGroup.add(new RifleEnemy(x, y, enemiesBullets, GRAVITY));
		}
	}

    private function instructInit(elapsed:Float):Void {   
        //trace(_player.x + "     " +_next);
        //trace(_player.x == cast(_next, Float));
        //if (!(Std.int(_player.x) > _next && !(Std.int(_player.x) < _next)) {
		//trace(Std.int(_player.x) + "       " + Std.int(_next));
		trace(_sorted.length);
        if (Std.int(_player.x) == Std.int(_next)) {
		    trace("Reached!");
            _instruct.instruct(_locations.get(_next), _player.x - 40, _player.y - 40);
            
            _next = _sorted.shift();
        }        
    }

	override public function update(elapsed:Float):Void  {
	 	super.update(elapsed);
    //  if (enemiesGroup.countLiving() == -1) {
	// 		_map.loadEntities(placeEntities, "entities");
	// 	}
		instructInit(elapsed);
        FlxG.collide(_player, _bound);
        FlxG.collide(_player, _plat);
		FlxG.collide(shield, _bound);
		

		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
	 					_player.getWeaponName(0), _player.getWeaponName(1));
						
	 	FlxG.overlap(playerBullets, enemiesGroup, bulletsHitEnemies);
		FlxG.overlap(shield, _player, onPickup);
	 	if (!_player.isTumbling()) {
	 		FlxG.overlap(enemiesBullets, _player, bulletsHitPlayer);
	 	}
		FlxG.collide(_bound, playerBullets, bulletsHitWalls);
		enemiesGroup.forEach(enemiesUpdate);
		FlxG.collide(enemiesGroup, _bound);
		FlxG.collide(enemiesGroup, _plat);

		bulletsRangeUpdate();
        if (!_player.exists) {
			// Player died, so set our label to YOU LOST
			//Main.LOGGER.logLevelEnd({won: false});
			FlxG.switchState(new OverState());
		}
		
		if (enemiesGroup.countLiving() == -1) {
			FlxG.switchState(new FinishState());
		}
	}

	private function onPickup(a:FlxSprite, b:FlxSprite):Void {
		shield.kill();
		_player.pickUpShield();
	}

    private function bulletsHitPlayer(bullet:Bullet, player:Player):Void {
		if (player.alive) {
			var damage:Float = bullet.getDamage();
			if (player.isShielding()) {
				damage /= 10;
			}
			player.hurt(damage);
			enemiesBullets.remove(bullet);
			bullet.destroy();
		}
	}
	
	private function bulletsRangeUpdate():Void {
		for (pb in playerBullets) {
			//destroyed?
			if (pb.outOfRange(pb.x)){
				playerBullets.remove(pb);
				pb.destroy();
			}
		}
		for (eb in enemiesBullets) {
			if (eb.outOfRange(eb.x)) {
				playerBullets.remove(eb);
				eb.destroy();
			}
		}
	}
	
	private function enemiesUpdate(e:Enemy):Void {
		if (!e.alive && e.animation.finished) {
			enemiesGroup.remove(e);
			e.destroy();
		} else if (e.alive) {
			e.playerPos.copyFrom(_player.getMidpoint());
			if (!_player.isTumbling()) {
				FlxG.collide(_player, e, playerCollidesEnemies);
			}
			
		}
	}
	
	public function bulletsHitEnemies(bullet:Bullet, enemy:Enemy):Void {
		if (enemy.alive) {
			enemy.hurt(bullet.getDamage());
			playerBullets.remove(bullet);
			bullet.destroy();
		}
	}
	
	public function playerCollidesEnemies(player:Player, enemy:Enemy):Void {
		enemy.velocity.set(0, 0);
	}
	
	public function bulletsHitWalls(wall:FlxObject, pb:Bullet):Void {
		playerBullets.remove(pb);
		pb.destroy();
	}

    // private function clickMenu():Void {
	// 	FlxG.switchState(new MenuState());
	// }

}