#if !macro


@:access(lime.app.Application)
@:access(lime.Assets)
@:access(openfl.display.Stage)


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	
	public static function create ():Void {
		
		var app = new openfl.display.Application ();
		app.create (config);
		
		var display = new flixel.system.FlxPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		app.setPreloader (preloader);
		preloader.onComplete.add (init);
		preloader.create (config);
		
		#if (js && html5)
		var urls = [];
		var types = [];
		
		
		urls.push ("assets/data/bg.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/boss1.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/boss2.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/data-goes-here.txt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/day_roman/dayrom.eot");
		types.push (lime.Assets.AssetType.BINARY);
		
		
		urls.push ("assets/data/day_roman/dayrom.svg");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("Day Roman");
		types.push (lime.Assets.AssetType.FONT);
		
		
		urls.push ("assets/data/day_roman/dayrom.woff");
		types.push (lime.Assets.AssetType.BINARY);
		
		
		urls.push ("assets/data/finalBoss.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/home.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/levelmap.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/levelmap_tutorial.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/lvl1.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/lvl2.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/lvl3.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/lvl4.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/lvl5.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/tutorialState.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/images/arrow.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/arrow2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/ball.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/blackmarket.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/boss1bg/boss1background.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/boss1bg/boss1tile.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/boss2bg/boss2bg.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/boss2bg/boss2tile.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/buttons/control1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/buttons/control2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/buttons/controlsettings.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/buttons/nextlevel.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/cancel.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/city.jpg");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/cityBurn.jpg");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/coinIcon.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/coins.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/confirm.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/continue.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/credits.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/creditsbtn.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/daze_sprite.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/dialog1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/dialog2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/dialog3.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/dialog4.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/dialog5.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/door.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/emptyslot.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/boss1/boss1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/boss2/boss2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/boss2/hand.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/jp_melee/jp_enemy_melee.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/jp_rifle/jp_enemy_rifle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/jp_shield/jp_enemy_shield.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/melee/enemy_melee.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/nurse/nurse.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/nurse/nurse_heart.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/rifle/enemy_rifle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/shield/enemy_shield.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/spider/spider.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/spider/spider_web.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/truck/enemy_truck.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/finalBoss/explosion.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/finalBoss/fbabg.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/finalBoss/finalBoss.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/finalBoss/finalBossBg.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/finalBoss/finalbossbg.tsx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/images/finalBoss/finalTile.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/finalBoss/tile.tsx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/images/gen.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/gohome.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/head.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/health.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/healthPotion.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/home.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/iceblock.jpg");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/IceBox.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/iceburg.jpg");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/keyboard.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/lab.jpg");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/level1BG.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/levelmap.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/map_icon.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/menu.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/menuBG.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/metal.jpg");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/newgame.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/next.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/oneStar.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/oneStar2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/player.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/resume.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/sky1.jpg");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/star_red.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/star_red_lock.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/star_yellow.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/star_yellow_lock.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/threeStar.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/threeStar2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/tile.jpg");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/tryagain.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/tutorialBG.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/twoStar.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/twoStar2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/chargingcolt.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/damage.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/daze.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/dualproficiency.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/fuelefficiency.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/juggernaut.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/kimaster.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/lifesaver.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/magazineSize.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/rateoffire.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/reflectiveshield.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/reloadspeed.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/spikedshield.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/tiarmor.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/upgrade/whirlwind.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/ballbullet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/chargedRevolverBullet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/chargedRevolverBulletRight.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/enemybullet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/kiLeft.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/kiRight.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/poisonSkull.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/revolver.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/revolverbm.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/revolverBullet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/revolverBulletRight.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/revolverButton.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/rifle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/riflebm.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/rifleButton.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/shield.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/shield_imageicon.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/shieldbm.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/shieldButton.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/shotgun.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/shotgunbm.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/shotgunBullet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/shotgunButton.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/sword.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/swordbm.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/weapons/swordButton.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/wife.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/workshop.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/music/boss.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("assets/music/dramatic.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("assets/music/introspection.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("assets/music/theme.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("assets/music/victory.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/coin_pickup.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/explosion_01.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/explosion_02.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/explosion_03.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Hit/hit_human1.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Hit/hit_human2.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Hit/hit_human3.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Hit/hit_monster1.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Hit/hit_monster2.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Hit/hit_monster3.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Jetpack/jetpack.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/jump.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/land.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Laser/laser_charge1.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Laser/laser_charge2.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Laser/laser_charge3.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Laser/laser_fire1.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Laser/laser_fire2.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Laser/laser_fire3.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Laser/laser_reload.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Laser/pulse_laser.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/potion.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Rifle/rifle_fire1.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Rifle/rifle_fire2.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Rifle/rifle_reload.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/roar.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/roll.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Shield/shield.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Shotgun/shotgun_fire1.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Shotgun/shotgun_fire2.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Shotgun/shotgun_reload.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/sounds-go-here.txt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/sounds/Sword/fleshCut.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Sword/sword_slash0.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Sword/sword_slash1.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/Sword/sword_slash2.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("assets/sounds/thud.wav");
		types.push (lime.Assets.AssetType.SOUND);
		
		
		urls.push ("flixel/sounds/beep.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("flixel/sounds/flixel.mp3");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		urls.push ("Nokia Cellphone FC Small");
		types.push (lime.Assets.AssetType.FONT);
		
		
		urls.push ("Monsterrat");
		types.push (lime.Assets.AssetType.FONT);
		
		
		urls.push ("flixel/images/ui/button.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("flixel/images/logo/default.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		
		if (config.assetsPrefix != null) {
			
			for (i in 0...urls.length) {
				
				if (types[i] != lime.Assets.AssetType.FONT) {
					
					urls[i] = config.assetsPrefix + urls[i];
					
				}
				
			}
			
		}
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if (sys && !nodejs && !emscripten)
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		
		if (total == 0) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			build: "9",
			company: "HaxeFlixel",
			file: "FlixelTut",
			fps: 60,
			name: "FlixelTut",
			orientation: "",
			packageName: "com.example.myapp",
			version: "0.0.1",
			windows: [
				
				{
					antialiasing: 0,
					background: 0,
					borderless: false,
					depthBuffer: false,
					display: 0,
					fullscreen: false,
					hardware: true,
					height: 480,
					parameters: "{}",
					resizable: true,
					stencilBuffer: true,
					title: "FlixelTut",
					vsync: true,
					width: 640,
					x: null,
					y: null
				},
			]
			
		};
		
		#if hxtelemetry
		var telemetry = new hxtelemetry.HxTelemetry.Config ();
		telemetry.allocations = true;
		telemetry.host = "localhost";
		telemetry.app_name = config.name;
		Reflect.setField (config, "telemetry", telemetry);
		#end
		
		#if (js && html5)
		#if (munit || utest)
		openfl.Lib.embed (null, 640, 480, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		var hasMain = false;
		var entryPoint = Type.resolveClass ("Main");
		
		for (methodName in Type.getClassFields (entryPoint)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		lime.Assets.initialize ();
		
		if (hasMain) {
			
			Reflect.callMethod (entryPoint, Reflect.field (entryPoint, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			/*if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}*/
			
		}
		
		#if !flash
		if (openfl.Lib.current.stage.window.fullscreen) {
			
			openfl.Lib.current.stage.dispatchEvent (new openfl.events.FullScreenEvent (openfl.events.FullScreenEvent.FULL_SCREEN, false, false, true, true));
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		#end
		
	}
	
	
	#if neko
	@:noCompletion @:dox(hide) public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					openfl.Lib.current.addChild (this);
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
