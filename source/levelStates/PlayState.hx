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
import flixel.system.FlxSound;
import weapons.*;
import enemies.*;
import items.*;
import otherStates.*;
import flixel.util.FlxColor;

class PlayState extends FlxState {
	// update this when new level added
	private var LAST_LEVEL:Int = 6;
	
	private var _player:Player;
	private var _hud:HUD;
	private var _boss_hud:Boss1HUD;
	private var _is_boss:Bool = false;
	private var _is_boss2:Bool = false;
	private var _is_boss3:Bool = false;
	private var _exit:Exit;
	private var indicator:FlxText;

	private var _map:TiledMap;
    private var _background:FlxTilemap;
    private var _plat:FlxTilemap;

	private var enemiesGroup:FlxTypedGroup<Enemy>;
	private var _enemiesMap:Map<Enemy, EnemyHUD>;
	private var _enemiesHUD:FlxTypedGroup<EnemyHUD>;
	private var playerBullets:FlxTypedGroup<Bullet>;
	private var enemiesBullets:FlxTypedGroup<EnemyBullet>;
	private var coinsGroup:FlxTypedGroup<Coin>;
	
	private var GRAVITY:Float = 1500;
	private var logged:Bool = false;
	private var startTime:Float;
	private var numEnemies:Int;
	public var LEVELID:Int;
	private var levelMoney:Int = 0;

	// pause state and menu
	private var _pause:Bool;
	private var _menu_bg:FlxSprite;
	private var _menubutton:ImageButton;
	private var _resumebutton:ImageButton;
	private var _homebutton:ImageButton;
	private var _pausebutton:FlxText;
	private var _pausetxt:FlxText;

	private var _hand:Boss2Hand;
	private var boss3:FinalBoss;
	
	private var _sndFlesh:FlxSound;

	override public function create():Void {
		//FlxG.debugger.drawDebug = true;
		//////////////////
        //LOAD PLAYER
		//////////////////
        playerBullets = new FlxTypedGroup<Bullet>();
		
        _player = new Player(playerBullets, GRAVITY);
		_exit = new Exit();
		indicator = new FlxText(0, 0, 200, "W to Exit", 19);
        indicator.setFormat(AssetPaths.FONT, indicator.size, FlxColor.WHITE, CENTER);
		indicator.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);
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
		Main.SAVE.data.numEnemies = numEnemies;
		/////////////////////////
		//ADD EVERY COMPONENT
		////////////////////////
        add(_background);
        add(_plat);
		add(_exit);
		add(indicator);
		add(enemiesBullets);
        add(enemiesGroup);
		add(coinsGroup);
        add(playerBullets);
		add(_enemiesHUD);
		
		if (_is_boss2) {
			add(_hand);
		}

		if (_is_boss) {
			add(_boss_hud);
			_exit.visible = false;
			FlxG.sound.playMusic(AssetPaths.boss__mp3);
		} else {
			FlxG.sound.playMusic(AssetPaths.dramatic__mp3);
		}
		
		 _hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
		 				_player.getWeaponName(0), _player.getWeaponName(1));
        FlxG.camera.follow(_player, TOPDOWN, 1);
		FlxG.camera.fade(FlxColor.BLACK, .25, true);
		Main.SAVE.data.curLevel = LEVELID;
		Main.SAVE.flush();
		startTime = Date.now().getTime();

		// pause part and whole pause menu
		_pause = false;

		_menu_bg = new FlxSprite(0, 0);
		_menu_bg.makeGraphic(800, 600, FlxColor.BLACK);
		_menu_bg.scrollFactor.set(0.0);

		_homebutton = new ImageButton(300, 200, clickHome);
		_homebutton.loadGraphic(AssetPaths.gohome__png, false, 200, 40);
		_homebutton.scrollFactor.set(0.0);
		_menubutton = new ImageButton(300, 310, clickMenu);
		_menubutton.loadGraphic(AssetPaths.menu__png, false, 200, 40);
		_menubutton.scrollFactor.set(0.0);
		_resumebutton = new ImageButton(300, 420, clickResume);
		_resumebutton.loadGraphic(AssetPaths.resume__png, false, 200, 40);
		_resumebutton.scrollFactor.set(0.0);
		
		_pausebutton = new FlxText(31, 100, 600, "Press ESC to PAUSE", 20);
		_pausebutton.setFormat(AssetPaths.FONT, _pausebutton.size);
		_pausebutton.scrollFactor.set(0.0);
		if (LEVELID > 1) {
			_pausebutton.visible = false;
		}

		_pausetxt = new FlxText(240, 85, 600, "Game Paused", 50);
		_pausetxt.setFormat(AssetPaths.FONT, _pausetxt.size);
		_pausetxt.scrollFactor.set(0.0);

		_sndFlesh = FlxG.sound.load(AssetPaths.fleshCut__wav);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		if (FlxG.keys.justPressed.ESCAPE) {
			_pause = !_pause;
		}
		if (_pause) {
			activeButtons();
			_homebutton.update(elapsed);
			_menubutton.update(elapsed);
			_resumebutton.update(elapsed);
			return;
		} else {
			disableButtons();
		}

		super.update(elapsed);
		// if (FlxG.keys.anyPressed([MINUS])) {
		// 	// kill all enemies
		// 	enemiesGroup.forEach(killAllEnemies);
		// }
		enemiesGroup.forEach(enemiesUpdate);
		if (!_is_boss) {
			updateEnemyHud();
		}
		_hud.updateXY();

		//use potion
		if(FlxG.keys.anyJustPressed([H])) {
			_player.usePotion();
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
		if (!_is_boss2) {
			FlxG.collide(enemiesGroup, _plat);
		}
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
			endLevel();
		}

		FlxG.overlap(_player, _exit, destination);
	}

	//////////////////////////////////////////////////////////
	///EXITING...
	//////////////////////////////////////////////////////////
	private function destination(o1:FlxSprite, o2:FlxSprite):Void {
		if (FlxG.keys.anyPressed([W]) && _exit.visible && !logged) {
			endLevel();
		}
	}
	
	private function endLevel():Void {
		if (Main.SAVE.data.levelCompleted != null) {
			var old:Int = Main.SAVE.data.levelCompleted;
			Main.SAVE.data.levelCompleted = Math.max(old, LEVELID);
		} else {
			Main.SAVE.data.levelCompleted = LEVELID;
		}
		if (LEVELID == LAST_LEVEL) {
			Main.SAVE.data.end = true;
		}
		Main.SAVE.data.money = _player.money;
		Main.SAVE.data.levelMoney = levelMoney;
		logged = true;
		Main.SAVE.data.dmgTaken = _player.getDamageTaken();
		Main.SAVE.data.timeTaken = (Date.now().getTime() - startTime) / 1000;
		Main.SAVE.data.enemiesKilled = numEnemies - enemiesGroup.countLiving();
		Main.LOGGER.logLevelEnd({won: true, dmgTaken: Main.SAVE.data.dmgTaken, timeTaken: Main.SAVE.data.timeTaken,
			enemiesKilled:Main.SAVE.data.enemiesKilled, money: _player.money});
		Main.SAVE.flush();
		trace("damage taken: " + Main.SAVE.data.dmgTaken);
		trace("time: " + Main.SAVE.data.timeTaken);
		trace("enemies: " + Main.SAVE.data.enemiesKilled);
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new FinishState());
		});
	}

	private function updateEnemyHud() {
		for(en in _enemiesMap.keys()) {
			if(en.exists){
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
			indicator.x = x - 45;
			indicator.y = y - 30;

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
		var boss2:Boss2;
		
		_hand = new Boss2Hand();
		
		if (entityName == "boss1") {
			if (LEVELID == 8) {
				boss = new Boss1(x, y, enId, enemiesBullets, coinsGroup, GRAVITY);
				enemiesGroup.add(boss);
			} else {
				boss = new Boss1(x, y, enId, enemiesBullets, coinsGroup, GRAVITY);
				enemiesGroup.add(boss);
				_boss_hud = new Boss1HUD(boss);
			}
			
		}  else if (entityName == "boss2"){
			boss2 = new Boss2(x, y, enId, enemiesBullets, coinsGroup, 0, _hand, _player);
			boss2.onPickUpItem = pickUpShotgun;
			enemiesGroup.add(boss2);
			_boss_hud = new Boss1HUD(boss2);
			
		} else if (entityName == "finalboss"){
			boss3 = new FinalBoss(x, y, enId, enemiesBullets, coinsGroup, GRAVITY, _map.width * _map.tileWidth, _hud, _player);
			enemiesGroup.add(boss3);
			_boss_hud = new Boss1HUD(boss3);
		} else if (entityName == "ENEMYG") {
			enemiesGroup.add(new EnemyGen(x, y, enId, enemiesBullets, coinsGroup, GRAVITY, enemiesGroup, lvl));
		} else {
			en = EnemyFactory.getEnemy(entityName, x, y, enId,
										enemiesBullets, coinsGroup,
										GRAVITY, lvl);
			if (en == null) {
				trace("Invalide entity name: " + entityName);
			}
			
			if (enId == 34 && lvl == 1) {
				en.onPickUpItem = pickUpRifle;
			}
			if (enId == 36 && lvl == 2) {
				en.onPickUpItem = pickUpRevolver;
			}
			enemiesGroup.add(en);
		}
	}


	private function bulletsHitPlayer(bullet:EnemyBullet, player:Player):Void {
		if (player.alive && bullet.alive) {
			var damage:Float = bullet.getDamage();
			if (!player.isShielding() || 
					(player.isShielding() && player.faced == bullet.facing)) {
				player.hurt(damage);
				_hud.updateDamage(damage);
				// stun player
				if (bullet.bulletType == WEB) {
					player.stun(1.0);
					_hud.startDaze(1.0);
				}
			} else {
				// player is shielding the right direction
				player.sndShield.play(true);
				var prt:Enemy = bullet.parent;
				if (prt.alive && !prt.isBoss) {
					if (bullet.bulletType == Melee && player.getSpike() != 0) {
						// return spike damage
						var returnDmg:Float = player.getSpike() * damage;
						enemyTakeDamgeHud(prt, returnDmg);
						prt.hurt(returnDmg);
					} else if ((bullet.bulletType == Ranged ||
								bullet.bulletType == SHOTGUN) &&
								player.getReflect() != 0) {
						// return reflect damage
						var returnDmg:Float = player.getReflect() * damage;
						enemyTakeDamgeHud(prt, returnDmg);
						prt.hurt(returnDmg);
					}
					if (player.getDaze()) {
						enemyTakeDamgeHud(prt, -1);
						prt.startDaze();
					}
				}
			}
			// shotgun knockback
			if (bullet.bulletType == SHOTGUN) {
				if (bullet.velocity.x < 0) {
					player.x -= 5;
					player.x = Math.max(player.x, 20);
				} else {
					player.x += 5;
					player.x = Math.min(player.x,
								_map.width * _map.tileWidth - player.width - 20);
				}
			}
			// poison: web, needle, skull
			if (bullet.bulletType == WEB || bullet.bulletType == NEEDLE ||
					bullet.bulletType == SKULL) {
				player.poison();
				_hud.startPoison();
			}
			bullet.kill();
		}
	}
	
	private function bulletsRangeUpdate():Void {
		for (pb in playerBullets) {
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
				if (_is_boss) {
					FlxG.overlap(_player, e, playerCollidesEnemies);
				} else {
					FlxG.collide(_player, e, playerCollidesEnemies);
				}
			}
		}
	}
	
	public function bulletsHitEnemies(bullet:Bullet, enemy:Enemy):Void {
		if (enemy.alive) {
			var dmg:Float = bullet.getDamage();
			if (bullet.getType() == "shotgun") {
				var len:Int = Std.int(cast(bullet, ShotgunBullet).getPushBack());
				if (enemy.isBoss) {
					len = Std.int(len / 10);
				}
				enemy.knockBack(len, bullet.facing);
			}
			if(bullet.getType() == "melee") {
				_sndFlesh.play(true);
			}
			playerBullets.remove(bullet);
			bullet.destroy();
			if (enemy.hasShield && bullet.facing != enemy.facing) {
				dmg = 0;
				_player.sndShield.play(true);
			}
			if (!_is_boss) {
				enemyTakeDamgeHud(enemy, dmg);
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
		if (coin.alive && coin.velocity.y >= 0) {
			coin.onPickUp(player, coin);
			if (coin.type == COIN) {
				levelMoney += coin.getValue();
			}
			coin.kill();
		}
	}
	
	public function pickUpRifle(player:Player, rifle:Coin):Void {
		player.pickUpRifle();
	}
	
	public function pickUpShotgun(player:Player, shotgun:Coin):Void {
		player.pickUpShotgun();
	}
	
	public function pickUpRevolver(player:Player, revolver:Coin):Void {
		player.pickUpRevolver();
	}
	
	public function killAllEnemies(e:Enemy) {
		if (e.alive/* && e.type != TRUCK*/) {
			e.hurt(e.health);
		}
	}
	
	public function enemyTakeDamgeHud(enemy:Enemy, dmg:Float) {
		if (!_enemiesMap.exists(enemy)) {
			var eh:EnemyHUD = new EnemyHUD(enemy);
			_enemiesMap.set(enemy, eh);
			_enemiesHUD.add(eh);
		}
		// update hud if dmg >= 0
		if (dmg >= 0) {
			_enemiesMap.get(enemy).updateDamage(dmg);
		} else {
			// daze if dmg < 0
			_enemiesMap.get(enemy).startDaze();
		}
	}

	public function addTopLayer():Void {
		add(_player);
		add(_pausebutton);
		add(_menu_bg);
		add(_homebutton);
		add(_menubutton);
		add(_resumebutton);
		add(_pausetxt);
	}

	private function activeButtons():Void {
		_menu_bg.visible = true;
		_menu_bg.alpha = 0.8;
		_menubutton.visible = true;
		_menubutton.active = true;
		_resumebutton.visible = true;
		_resumebutton.active = true;
		if (Main.SAVE.data.levelCompleted != null && Main.SAVE.data.levelCompleted >= 2) {
			_homebutton.visible = true;
			_homebutton.active = true;
		}
		_pausetxt.visible = true;
	}

	private function disableButtons():Void {
		_menu_bg.visible = false;
		_homebutton.visible = false;
		_homebutton.active = false;
		_menubutton.visible = false;
		_menubutton.active = false;
		_resumebutton.visible = false;
		_resumebutton.active = false;
		_pausetxt.visible = false;
	}

	private function clickHome():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.sound.music.destroy();
			FlxG.switchState(new HomeState());
		});
    }

    private function clickMenu():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.sound.music.destroy();
			FlxG.switchState(new MenuState());
		});
    }

    private function clickResume():Void {
    	_pause = false;
    }

    private function clickPause():Void {
    	_pause = true;
    }
}
