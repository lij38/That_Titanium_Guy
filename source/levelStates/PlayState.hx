package levelStates;

import enemies.*;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
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

	private var enemiesGroup:FlxTypedGroup<Enemy>;
	private var _enemiesMap:Map<Enemy, EnemyHUD>;
	private var _enemiesHUD:FlxTypedGroup<EnemyHUD>;
	private var playerBullets:FlxTypedGroup<Bullet>;
	private var enemiesBullets:FlxTypedGroup<EnemyBullet>;
	
	private var GRAVITY:Float = 1000;
	
	override public function create():Void {
		//FlxG.debugger.drawDebug = true;
		//////////////////
        //LOAD PLAYER
		//////////////////
        playerBullets = new FlxTypedGroup<Bullet>();
        _player = new Player(playerBullets, GRAVITY);
		var tmpMap:TiledObjectLayer = cast _map.getLayer("player");
        for (e in tmpMap.objects) {
            placeEntities(e.name, e.xmlData.x);
        }

		////////////////////////
        //LOAD HUD
		///////////////////////
        _hud = new HUD(_player);

		/////////////////////////
		//LOAD ENEMIES
		////////////////////////
		enemiesBullets = new FlxTypedGroup<EnemyBullet>();
		
		enemiesGroup = new FlxTypedGroup<Enemy>();
		_enemiesMap = new Map<Enemy, EnemyHUD>();
		_enemiesHUD = new FlxTypedGroup<EnemyHUD>();
		var enemyLayer:TiledObjectLayer = cast _map.getLayer("enemies");
		for (e in enemyLayer.objects) {
			placeEnemies(e.name, e.xmlData.x);
		}
		
		/////////////////////////
		//ADD EVERY COMPONENT
		////////////////////////
        add(_background);
        add(_plat); 
		add(enemiesBullets);
        add(enemiesGroup);
        add(playerBullets);
        add(_player);
        add(_hud);
		add(_enemiesHUD);
		
		 _hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
		 				_player.getWeaponName(0), _player.getWeaponName(1));
        FlxG.camera.follow(_player, TOPDOWN, 1);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		enemiesGroup.forEach(enemiesUpdate);
		updateEnemyHud();
		_hud.updateXY();

        FlxG.collide(_player, _plat);
		
		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
	 					_player.getWeaponName(0), _player.getWeaponName(1));
						
	 	FlxG.overlap(playerBullets, enemiesGroup, bulletsHitEnemies);
		if (!_player.isTumbling()) {
	 		FlxG.overlap(enemiesBullets, _player, bulletsHitPlayer);
	 	}
		
		FlxG.collide(_plat, playerBullets, bulletsHitWalls);
		FlxG.collide(_plat, enemiesBullets, enemiesBulletsHitWalls);
		FlxG.collide(enemiesGroup, _plat);

		bulletsRangeUpdate();
        if (!_player.exists) {
			//Player died, so set our label to YOU LOST
			Main.LOGGER.logLevelEnd({won: false});
			FlxG.switchState(new OverState());
		}
		
		if (enemiesGroup.countLiving() == -1) {
			Main.LOGGER.logLevelEnd({won: true});
			FlxG.switchState(new FinishState());
		}
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

    //Place enemies individually
	private function placeEnemies(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		var en:Enemy;

		if (entityName == "MELEE") {
			en = new MeleeEnemy(x, y, enemiesBullets, GRAVITY);
		} else if (entityName == "RIFLE"){
			en = new RifleEnemy(x, y, enemiesBullets, GRAVITY);
		} else if (entityName == "SHIELD") {
			en = new ShieldEnemy(x, y, enemiesBullets, GRAVITY, 1);
		} else {
			en = new RifleEnemy(x, y-55, enemiesBullets, GRAVITY);
			en.hurt(en.health);
		}
		
		enemiesGroup.add(en);
		if (entityName != "RIFLEDEAD") {
			var eh:EnemyHUD;
			eh = new EnemyHUD(en);
			_enemiesMap.set(en, eh);
			_enemiesHUD.add(eh);
		}
	}


	private function bulletsHitPlayer(bullet:EnemyBullet, player:Player):Void {
		if (player.alive) {
			var damage:Float = bullet.getDamage();
			if (player.isShielding() && player.faced != bullet.facing) {
				damage /= 10;
			}
			player.hurt(damage);
			_hud.updateDamage(damage);
			bullet.kill();
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
			var dmg:Float = bullet.getDamage();
			if (enemy.type == SHIELD && bullet.facing != enemy.facing) {
				dmg *= 0.1;
			}
			_enemiesMap.get(enemy).updateDamage(dmg);
			enemy.hurt(dmg);
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
	
	public function enemiesBulletsHitWalls(wall:FlxObject, b:Bullet):Void {
		b.kill();
	}
}
