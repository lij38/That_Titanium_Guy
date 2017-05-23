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
import items.*;
import otherStates.*;
import flixel.util.FlxColor;

class PlayState extends FlxState {	
	private var _player:Player;
	private var _hud:HUD;
	private var _boss_hud:Boss1HUD;
	private var _is_boss:Bool = false;
	private var _exit:Exit;

	private var _map:TiledMap;
    private var _background:FlxTilemap;
    private var _plat:FlxTilemap;

	private var enemiesGroup:FlxTypedGroup<Enemy>;
	private var _enemiesMap:Map<Enemy, EnemyHUD>;
	private var _enemiesHUD:FlxTypedGroup<EnemyHUD>;
	private var playerBullets:FlxTypedGroup<Bullet>;
	private var enemiesBullets:FlxTypedGroup<EnemyBullet>;
	private var coinsGroup:FlxTypedGroup<Coin>;
	
	private var GRAVITY:Float = 1000;
	private var logged:Bool = false;
	private var startTime:Float;
	private var numEnemies:Int;
	public var LEVELID:Int;
	
	override public function create():Void {
		//FlxG.debugger.drawDebug = true;
		//////////////////
        //LOAD PLAYER
		//////////////////
        playerBullets = new FlxTypedGroup<Bullet>();
        _player = new Player(playerBullets, GRAVITY);
		_exit = new Exit();
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
		coinsGroup = new FlxTypedGroup<Coin>();
		_enemiesMap = new Map<Enemy, EnemyHUD>();
		_enemiesHUD = new FlxTypedGroup<EnemyHUD>();
		var enemyLayer:TiledObjectLayer = cast _map.getLayer("enemies");
		for (e in enemyLayer.objects) {
			placeEnemies(e.name, e.xmlData.x);
		}
		numEnemies = enemiesGroup.countLiving();
		trace(Std.string(numEnemies));
		Main.SAVE.data.numEnemies = numEnemies;
		/////////////////////////
		//ADD EVERY COMPONENT
		////////////////////////
        add(_background);
        add(_plat);
		add(_exit);
		add(enemiesBullets);
        add(enemiesGroup);
		add(coinsGroup);
        add(playerBullets);
		add(_enemiesHUD);
		add(_player);

		if (_is_boss) {
			add(_boss_hud);
			_exit.visible = false;
		}
		
		 _hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
		 				_player.getWeaponName(0), _player.getWeaponName(1));
        FlxG.camera.follow(_player, TOPDOWN, 1);
		FlxG.camera.fade(FlxColor.BLACK, .25, true);
		Main.SAVE.data.curLevel = LEVELID;
		Main.SAVE.flush();
		startTime = Date.now().getTime();
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (FlxG.keys.anyPressed([MINUS])) {
			// kill all enemies
			enemiesGroup.forEach(killAllEnemies);
		}
		enemiesGroup.forEach(enemiesUpdate);
		if (!_is_boss) {
			updateEnemyHud();
			_hud.updateXY();
		}

        FlxG.collide(_player, _plat);
		
		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
	 					_player.getWeaponName(0), _player.getWeaponName(1));
						
	 	FlxG.overlap(playerBullets, enemiesGroup, bulletsHitEnemies);
		if (!_player.isTumbling()) {
	 		FlxG.overlap(enemiesBullets, _player, bulletsHitPlayer);
	 	}
		
		// Bullets collide walls
		FlxG.collide(_plat, playerBullets, bulletsHitWalls);
		FlxG.collide(_plat, enemiesBullets, enemiesBulletsHitWalls);
		FlxG.collide(enemiesGroup, _plat);
		
		// Coins
		FlxG.collide(coinsGroup, _plat);
		FlxG.overlap(_player, coinsGroup, pickUpCoin);

		bulletsRangeUpdate();
        if (!_player.exists && !logged) {
			//Player died, so set our label to YOU LOST
			Main.LOGGER.logLevelEnd({won: false});
			logged = true;
			FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
				FlxG.switchState(new OverState());
			});
		}
		
		if (enemiesGroup.countLiving() == -1 && !logged) {
			if(Main.SAVE.data.levelCompleted != null) {
				var old:Int = Main.SAVE.data.levelCompleted;
				Main.SAVE.data.levelCompleted = Math.max(old, LEVELID);
			} else {
				Main.SAVE.data.levelCompleted = LEVELID;
			}
			if(LEVELID == 3) {
				Main.SAVE.data.end = true;
			}
			Main.LOGGER.logLevelEnd({won: true});
			logged = true;
			Main.SAVE.data.dmgTaken = _player.getDamageTaken();
			Main.SAVE.data.timeTaken = (Date.now().getTime() - startTime) / 1000;
			Main.SAVE.data.enemiesKilled = numEnemies - enemiesGroup.countLiving();
			Main.SAVE.flush();
			trace("damage taken: " + Main.SAVE.data.dmgTaken);
			trace("time: " + Main.SAVE.data.timeTaken);
			trace("enemies: " + Main.SAVE.data.enemiesKilled);
			FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
				FlxG.switchState(new FinishState());
			});
		}


		FlxG.overlap(_player, _exit, destination);
	}

	//////////////////////////////////////////////////////////
	///EXITING...
	//////////////////////////////////////////////////////////
	private function destination(o1:FlxSprite, o2:FlxSprite):Void {
		if (FlxG.keys.anyPressed([W]) && _exit.visible && !logged) {
			if(Main.SAVE.data.levelCompleted != null) {
				var old:Int = Main.SAVE.data.levelCompleted;
				Main.SAVE.data.levelCompleted = Math.max(old, LEVELID);
			} else {
				Main.SAVE.data.levelCompleted = LEVELID;
			}
			if(LEVELID == 3) {
				Main.SAVE.data.end = true;
			}
			Main.LOGGER.logLevelEnd({won: true});
			logged = true;
			Main.SAVE.data.dmgTaken = _player.getDamageTaken();
			Main.SAVE.data.timeTaken = (Date.now().getTime() - startTime) / 1000;
			Main.SAVE.data.enemiesKilled = numEnemies - enemiesGroup.countLiving();
			Main.SAVE.flush();
			trace("damage taken: " + Main.SAVE.data.dmgTaken);
			trace("time: " + Main.SAVE.data.timeTaken);
			trace("enemies: " + Main.SAVE.data.enemiesKilled);
			FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
				FlxG.switchState(new FinishState());
			});
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
			_exit.x = x;
			_exit.y = y;
        }

	}

    //Place enemies individually
	private function placeEnemies(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		var lvl:Int = Std.parseInt(entityData.get("type"));
		var enId:Int = Std.parseInt(entityData.get("id"));
		
		var en:Enemy;
		var boss:Boss1;
		
		if (entityName == "boss1") {
			boss = new Boss1(x, y, enId, enemiesBullets, coinsGroup, 0);
			enemiesGroup.add(boss);
			if (boss.health > 0) {
				_boss_hud = new Boss1HUD(boss);
			} else {
				boss.hurt(boss.health);
			}
		} else {
			en = EnemyFactory.getEnemy(entityName, x, y, enId,
										enemiesBullets, coinsGroup,
										GRAVITY, lvl);
			if (en == null) {
				trace("Invalide entity name: " + entityName);
			}
			
			if (enId == 34) {
				en.onPickUpItem = pickUpRifle;
			}
			enemiesGroup.add(en);
			if (en.health > 0) {
				var eh:EnemyHUD;
				eh = new EnemyHUD(en);
				_enemiesMap.set(en, eh);
				_enemiesHUD.add(eh);
			} else {
				en.hurt(en.health);
			}
		}
	}


	private function bulletsHitPlayer(bullet:EnemyBullet, player:Player):Void {
		if (player.alive && bullet.alive) {
			var damage:Float = bullet.getDamage();
			if (!player.isShielding() || (player.isShielding() && player.faced == bullet.facing)) {
				player.hurt(damage);
				_hud.updateDamage(damage);
			}
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
			playerBullets.remove(bullet);
			bullet.destroy();
			if (enemy.type == SHIELD && bullet.facing != enemy.facing) {
				dmg = 0;
			}
			if (!_is_boss) {
				_enemiesMap.get(enemy).updateDamage(dmg);
			}
			enemy.hurt(dmg);
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
	
	public function pickUpCoin(player:Player, coin:Coin):Void {
		if (coin.alive) {
			coin.onPickUp(player, coin);
			coin.kill();
		}
	}
	
	public function pickUpRifle(player:Player, rifle:Coin):Void {
		player.pickUpRifle();
	}
	
	public function killAllEnemies(e:Enemy) {
		if (e.alive/* && e.type != TRUCK*/) {
			e.hurt(e.health);
		}
	}
}
