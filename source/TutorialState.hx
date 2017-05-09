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
<<<<<<< HEAD
=======
import weapons.*;
import enemies.*;
>>>>>>> 7e0e469e55d37f2ac00c417e40519e5afc352b07

class TutorialState extends FlxState {
    private var _player:Player;
    private var _map:TiledMap;

    private var _background:FlxTilemap;
    private var _plat:FlxTilemap;
    private var _bound:FlxTilemap;

    private var _btnMenu:FlxButton;
    private var _instruct:Instruction;

    private var _locations:Map<Int, String>;
    private var _sorted:Array<Int>;
    private var _next:Int;
	
	private var playerBullets:FlxTypedGroup<Bullet>;
    private var _hud:HUD;
	private var enemiesGroup:FlxTypedGroup<Enemy>;
    private var enemiesBullets:FlxTypedGroup<Bullet>;
	
	private var GRAVITY:Float = 1000;

    private var playerBullets:FlxTypedGroup<Bullet>;
	private var GRAVITY:Float = 1000;


    override public function create():Void {
        //LOAD MAP BASICS
        _map = new TiledMap(AssetPaths.tutorial__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();
        _bound = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.tutorialBG__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1023);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2041, 1, 2040);
        //load bounds
        _bound.loadMapFromArray(cast(_map.getLayer("bound"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2041, 1, 2040);

        _background.setTileProperties(2, FlxObject.NONE);
        _bound.setTileProperties(1, FlxObject.ANY);
        _plat.setTileProperties(1, FlxObject.ANY);

        enemiesBullets = new FlxTypedGroup<Bullet>();
		add(enemiesBullets);
		
		enemiesGroup = new FlxTypedGroup<Enemy>();
		add(enemiesGroup);

        //LOAD PLAYER
<<<<<<< HEAD
        playerBullets = new FlxTypedGroup<Bullet>();
=======
>>>>>>> 7e0e469e55d37f2ac00c417e40519e5afc352b07
        _player = new Player(playerBullets, GRAVITY);
        _btnMenu = new FlxButton(0, 0, "Menu", clickMenu);

        //load hud
        _hud = new HUD(_player);

        var tmpMap:TiledObjectLayer = cast _map.getLayer("player");
        for (e in tmpMap.objects) {
            placeEntities(e.name, e.xmlData.x);
        }

        //LOAD INSTRUCTIONS
        _locations = new Map<Int, String>();
        _sorted = new Array<Int>();
        var tmpLayer:TiledObjectLayer = cast _map.getLayer("instruction");
        for (e in tmpLayer.objects) {
            placeEntities(e.name, e.xmlData.x);
        }
        haxe.ds.ArraySort.sort(_sorted, function(a, b):Int {
            if (a < b) return -1;
            else if (a > b) return 1;
            return 0;
        });
        _instruct = new Instruction(0, 0, 300, 12);
        trace(_sorted.length);
        _next = _sorted.shift();
        trace(_next);



        //ADD EVERY COMPONENT
        add(_background);
        add(_bound);
        add(_plat); 
        add(_player);
        add(_btnMenu);
        add(_instruct);

=======
        add(_hud);
		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
						_player.getWeaponName(0), _player.getWeaponName(1));
>>>>>>> 7e0e469e55d37f2ac00c417e40519e5afc352b07
        FlxG.camera.follow(_player, TOPDOWN, 1);
		super.create();


    }

	private function placeEntities(entityName:String, entityData:Xml):Void  {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player") {
			_player.x = x;
			_player.y = y;
		} else {
            _locations.set(x, entityName);
            _sorted.push(x);
        }

	}

    private function instructInit(elapsed:Float):Void {   
        //trace(_player.x + "     " +_next);
<<<<<<< HEAD
=======
        //trace(_player.x == cast(_next, Float));
        if (Std.int(_player.x) == _next) {
>>>>>>> 7e0e469e55d37f2ac00c417e40519e5afc352b07
            trace("Reached!");
            _instruct.instruct(_locations.get(_next), _player.x + 100, _player.y - 20);
            
            _next = _sorted.shift();
        }        
    }

	override public function update(elapsed:Float):Void  {
		super.update(elapsed);
        // if (enemiesGroup.countLiving() == -1) {
		// 	_map.loadEntities(placeEntities, "entities");
		// }
        instructInit(elapsed);
        FlxG.collide(_player, _bound);
        FlxG.collide(_player, _plat);
		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
						_player.getWeaponName(0), _player.getWeaponName(1));
						
		FlxG.overlap(playerBullets, enemiesGroup, bulletsHitEnemies);
		if (!_player.isTumbling()) {
			FlxG.overlap(enemiesBullets, _player, bulletsHitPlayer);
		}
		FlxG.collide(_bound, playerBullets, bulletsHitWalls);
		enemiesGroup.forEach(enemiesUpdate);
		FlxG.collide(enemiesGroup, _bound);
		bulletsRangeUpdate();
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

    private function clickMenu():Void {
		FlxG.switchState(new MenuState());
	}

}