package levelStates;

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

class Boss1State extends FlxState {
	private var _player:Player;
	private var _map:TiledMap;
	private var _foreground:FlxTilemap;
	private var _background:FlxTilemap;
	private var _hud:HUD;
	private var _enemy:Boss1;
	private var _boss_hud:Boss1HUD;
	private var _hurt_count:Int;
	
	//private var enemiesGroup:FlxTypedGroup<Enemy>;
	private var playerBullets:FlxTypedGroup<Bullet>;
	private var enemiesBullets:FlxTypedGroup<EnemyBullet>;
	
	private var GRAVITY:Float = 1000;
	
	override public function create():Void {
		
		_map = new TiledMap(AssetPaths.boss1__tmx);
		_foreground = new FlxTilemap();
		_foreground.loadMapFromArray(cast(_map.getLayer("foreground"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.boss1tile__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2721, 1, 1);

		_background = new FlxTilemap();
		_background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.boss1background__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 2722);

		_foreground.follow();
		_background.follow();
		add(_background);
		add(_foreground);
		
		playerBullets = new FlxTypedGroup<Bullet>();
		add(playerBullets);
		enemiesBullets = new FlxTypedGroup<EnemyBullet>();
		add(enemiesBullets);

		_enemy = new Boss1(0,0,enemiesBullets, 0);
		 
		_player = new Player(playerBullets, GRAVITY);

		var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
		 for (e in tmpMap.objects)
		 {
		     placeEntities(e.type, e.xmlData.x);
		 }

		add(_player);
		add(_enemy);
		
		FlxG.camera.follow(_player, LOCKON, 1);

		_hud = new HUD(_player);
		add(_hud);
		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
						_player.getWeaponName(0), _player.getWeaponName(1));

		_boss_hud = new Boss1HUD(_enemy);
		add(_boss_hud);

		_hurt_count = 0;

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
		
		
		FlxG.collide(_foreground, playerBullets, bulletsHitWalls);
		FlxG.collide(_foreground, enemiesBullets, enemiesBulletsHitWalls);
		//enemiesGroup.forEach(enemiesUpdate);
		FlxG.collide(_player, _foreground);
		//FLxG.collide(_player, _enemy);
		//FlxG.collide(enemiesGroup, _mWalls);
		if (_enemy.alive) {
			if (FlxG.overlap(playerBullets, _enemy, bulletsHitEnemy)){
			_enemy.color = 0xff0000;
			} else {
				_enemy.color = 0xffffff;
			}
			if (!_player.isTumbling()) {
			FlxG.overlap(enemiesBullets, _player, bulletsHitPlayer);
			}
			FlxG.overlap(_player, _enemy, stopPlayer);
		} else {
			_enemy.color = 0xffffff;
		}
		
		bulletsRangeUpdate();

		if (!_player.exists) {
			//Player died, so set our label to YOU LOST
			FlxG.switchState(new OverState());
		}

		if (!_enemy.alive) {
			FlxG.switchState(new FinishState());
		}
	}

	private function bulletsHitEnemy(bullet:Bullet, small_boss:Boss1):Void {
		if (small_boss.alive) {
			var damage:Float = bullet.getDamage();
			//trace(damage);
			small_boss.hurt(damage);
			playerBullets.remove(bullet);
			bullet.destroy();
		}
	}
	
	private function bulletsHitPlayer(bullet:EnemyBullet, player:Player):Void {
		if (player.alive) {
			var damage:Float = bullet.getDamage();
			if (player.isShielding()) {
				damage /= 10;
			}
			player.hurt(damage);
			bullet.kill();
		}
	}

	public function stopPlayer(player:Player, enemy:Boss1):Void {
		if(!player.isTumbling()) {
			if (player.facing == FlxObject.LEFT) {
				player.x += 2;
			} else {
				player.x -= 2;	
			}
		}
	}

	
	private function bulletsRangeUpdate():Void {
		for (pb in playerBullets) {
			//destroyed?
			if (pb.outOfRange()){
				playerBullets.remove(pb);
				pb.destroy();
			}
		}
		for (eb in enemiesBullets) {
			if (eb.outOfRange()) {
				eb.kill();
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

	public function enemiesBulletsHitWalls(wall:FlxObject, b:EnemyBullet):Void {
		b.kill();
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
}
