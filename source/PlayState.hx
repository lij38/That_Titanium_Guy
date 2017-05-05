package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.ui.FlxButton;
import weapons.*;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;

class PlayState extends FlxState {
	private var _player:Player;
	private var _map:TiledMap;
	private var _mWalls:FlxTilemap;
	private var _btnMenu:FlxButton;
	private var _health:Int;
	private var _hud:HUD;
	private var _enemy:SmallBoss;
	//private var _coin:Coin;
	
	private var playerBullets:FlxTypedGroup<Bullet>;
	
	override public function create():Void {
		_map = new TiledMap(AssetPaths.level1__tmx);
		_mWalls = new FlxTilemap();
		_mWalls.loadMapFromArray(cast(_map.getLayer("map"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.tiles__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
		_mWalls.follow();
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.ANY);
		add(_mWalls);
		
		playerBullets = new FlxTypedGroup<Bullet>();
		add(playerBullets);
		
		_player = new Player(playerBullets);
		add(_player);

		_enemy = new SmallBoss(0, 0, 0);
		add(_enemy);

		var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
		 for (e in tmpMap.objects)
		 {
		     placeEntities(e.type, e.xmlData.x);
		 }
		
		 _btnMenu = new FlxButton(0, 0, "Menu", clickMenu);
		 add(_btnMenu);
		
		_health = 100;
		FlxG.camera.follow(_player, TOPDOWN, 1);

		_hud = new HUD(_player);
		add(_hud);
		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
						_player.getWeaponName(0), _player.getWeaponName(1));
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		_enemy.playerPos.copyFrom(_player.getMidpoint());

		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
						_player.getWeaponName(0), _player.getWeaponName(1));
		FlxG.collide(_player, _mWalls);
		FlxG.collide(_mWalls, playerBullets, bulletsHitWalls);
		FlxG.overlap(_enemy, playerBullets, hitEnemy);
		FlxG.overlap(_player, _enemy, hurtPlayer);
		
		for (pb in playerBullets){
			//destroyed?
			if (pb.outOfRange(pb.x)){
				playerBullets.remove(pb);
				pb.destroy();
			}
		}
	}
	
	public function bulletsHitWalls(wall:FlxObject, pb:Bullet):Void {
		playerBullets.remove(pb);
		pb.destroy();
	}

	public function hurtPlayer(player:FlxObject, enemy:SmallBoss):Void {
		if (enemy.inDash) {
			enemy.stuck = true;
		}
	}

	public function hitEnemy(enemy:FlxObject, pb:Bullet):Void {
		enemy.hurt(20);
		playerBullets.remove(pb);
		pb.destroy();
	}

	private function placeEntities(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player") {
			_player.x = x;
			_player.y = y;
		} else if (entityName == "enemy") {
			_enemy.x = x;
			_enemy.y = y;
		}
	}
	
	private function clickMenu():Void {
		FlxG.switchState(new MenuState());
	}
}