package;

import enemies.*;
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
	private var _hud:HUD;
	private var _enemy:SmallBoss;
	
	//private var enemiesGroup:FlxTypedGroup<Enemy>;
	private var playerBullets:FlxTypedGroup<Bullet>;
	private var enemiesBullets:FlxTypedGroup<Bullet>;
	
	private var GRAVITY:Float = 1000;
	
	override public function create():Void {
		//add(new FlxText(10, 10, 100, "Hello, World!"));
		//trace("Hello world!");
		//FlxG.debugger.drawDebug = true;
		
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
		enemiesBullets = new FlxTypedGroup<Bullet>();
		add(enemiesBullets);

		_enemy = new SmallBoss(0,0,enemiesBullets, 0);
		
		//enemiesGroup = new FlxTypedGroup<Enemy>();
		//add(enemiesGroup);
		 
		_player = new Player(playerBullets, GRAVITY);

		var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
		 for (e in tmpMap.objects)
		 {
		     placeEntities(e.type, e.xmlData.x);
		 }

		add(_player);
		add(_enemy);
		
		 _btnMenu = new FlxButton(0, 0, "Menu", clickMenu);
		 add(_btnMenu);
		
		//FlxG.camera.follow(_player, TOPDOWN, 1);

		_hud = new HUD(_player);
		add(_hud);
		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
						_player.getWeaponName(0), _player.getWeaponName(1));
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		//if (enemiesGroup.countLiving() == -1) {
		//	_map.loadEntities(placeEntities, "entities");
		//}

		_enemy.playerPos.copyFrom(_player.getMidpoint());

		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
						_player.getWeaponName(0), _player.getWeaponName(1));
						
		//FlxG.overlap(playerBullets, enemiesGroup, bulletsHitEnemies);
		if (!_player.isTumbling()) {
			FlxG.overlap(enemiesBullets, _player, bulletsHitPlayer);
		}
		FlxG.collide(_mWalls, playerBullets, bulletsHitWalls);
		//enemiesGroup.forEach(enemiesUpdate);
		FlxG.collide(_player, _mWalls);
		//FLxG.collide(_player, _enemy);
		//FlxG.collide(enemiesGroup, _mWalls);
		FlxG.overlap(_player, _enemy, hurtPlayer);
		
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

	public function hurtPlayer(player:FlxObject, enemy:SmallBoss):Void {
		//if (facing = FlxObject.LEFT) {
			// facing left
		//	if (getMidpoint().x - playerPos.x <= 100) {

		//	}
		//}
		//if (Math.abs(playerPos.x - getMidpoint().x) <= damage_dist) {
		//	brain.activeState = attack;
		//}
		//if (enemy.inDash) {
		//	enemy.stuck = true;
		//}
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
	
	/*
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
	*/
	
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

	private function placeEntities(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player") {
			_player.x = x;
			_player.y = y;
		} else if (entityName == "enemy") {
			_enemy.x = x;
			_enemy.y = y;
			//enemiesGroup.add(new RifleEnemy(x, y, enemiesBullets, GRAVITY));
		}
	}
	
	private function clickMenu():Void {
		FlxG.switchState(new PlayState());
	}
}
