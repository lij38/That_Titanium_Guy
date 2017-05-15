package levelStates;

import enemies.*;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.TiledMap;
import weapons.*;
import enemies.*;

class PlayState extends FlxState {
	private var _player:Player;
	private var _hud:HUD;

	private var _map:TiledMap;
    private var _background:FlxTilemap;
    private var _plat:FlxTilemap;
    private var _bound:FlxTilemap;

	private var enemiesGroup:FlxTypedGroup<Enemy>;
	private var _enemiesMap:Map<Enemy, EnemyHUD>;
	private var _enemiesHUD:FlxTypedGroup<EnemyHUD>;
	private var playerBullets:FlxTypedGroup<Bullet>;
	private var enemiesBullets:FlxTypedGroup<Bullet>;
	
	private var GRAVITY:Float = 1000;
	
	override public function create():Void {
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

        //LOAD PLAYER
        playerBullets = new FlxTypedGroup<Bullet>();
        _player = new Player(playerBullets, GRAVITY);
		var tmpMap:TiledObjectLayer = cast _map.getLayer("player");
        for (e in tmpMap.objects) {
            placeEntities(e.name, e.xmlData.x);
        }

        //LOAD HUD
        _hud = new HUD(_player);
		
		//ADD EVERY COMPONENT
        add(_background);
        add(_bound);
        add(_plat); 
		add(enemiesBullets);
        add(enemiesGroup);
        add(playerBullets);
        add(_player);
        //add(_instruct);
        add(_hud);
		add(_enemiesHUD);
		
		 _hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
		 				_player.getWeaponName(0), _player.getWeaponName(1));
        FlxG.camera.follow(_player, TOPDOWN, 1);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		_hud.updateXY();
		updateEnemyHud();

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
		FlxG.collide(enemiesGroup, _plat);
		FlxG.collide(enemiesBullets, _plat, enemyBulletsPlats);

		bulletsRangeUpdate();
        if (!_player.exists) {
			// Player died, so set our label to YOU LOST
			Main.LOGGER.logLevelEnd({won: false});
			FlxG.switchState(new OverState());
		}
		
		if (enemiesGroup.countLiving() == -1) {
			Main.LOGGER.logLevelEnd({won: true});
			FlxG.switchState(new FinishState());
		}
	}
	
	private function enemyBulletsPlats(bullet:Bullet, plat:FlxObject) {
		enemiesBullets.remove(bullet);
		bullet.destroy();
	}

	private function updateEnemyHud() {
		for(en in _enemiesMap.keys()) {
			if(en.health > 0){
				_enemiesMap.get(en).updateXY();
			} else {
				_enemiesMap.get(en).destroy();
				_enemiesMap.remove(en);
			}
		}
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

	private function bulletsHitPlayer(bullet:Bullet, player:Player):Void {
		if (player.alive) {
			var damage:Float = bullet.getDamage();
			if (player.isShielding()) {
				damage /= 10;
			}
			player.hurt(damage);
			_hud.updateDamage(damage);
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
			_enemiesMap.get(enemy).updateDamage(bullet.getDamage());
		}
	}
	
	public function playerCollidesEnemies(player:Player, enemy:Enemy):Void {
		enemy.velocity.set(0, 0);
	}
	
	public function bulletsHitWalls(wall:FlxObject, pb:Bullet):Void {
		playerBullets.remove(pb);
		pb.destroy();
	}
}
