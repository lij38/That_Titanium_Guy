package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Future;
import lime.app.Preloader;
import lime.app.Promise;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.net.HTTPRequest;
import lime.system.CFFI;
import lime.text.Font;
import lime.utils.Bytes;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if (openfl && !flash)
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_data_day_roman_dayrom_ttf);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		
		
		#end
		
		#if flash
		
		className.set ("assets/data/bg.tmx", __ASSET__assets_data_bg_tmx);
		type.set ("assets/data/bg.tmx", AssetType.TEXT);
		className.set ("assets/data/boss1.tmx", __ASSET__assets_data_boss1_tmx);
		type.set ("assets/data/boss1.tmx", AssetType.TEXT);
		className.set ("assets/data/boss2.tmx", __ASSET__assets_data_boss2_tmx);
		type.set ("assets/data/boss2.tmx", AssetType.TEXT);
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/data/day_roman/dayrom.ttf", __ASSET__assets_data_day_roman_dayrom_ttf);
		type.set ("assets/data/day_roman/dayrom.ttf", AssetType.FONT);
		className.set ("assets/data/home.tmx", __ASSET__assets_data_home_tmx);
		type.set ("assets/data/home.tmx", AssetType.TEXT);
		className.set ("assets/data/levelmap.tmx", __ASSET__assets_data_levelmap_tmx);
		type.set ("assets/data/levelmap.tmx", AssetType.TEXT);
		className.set ("assets/data/levelmap_tutorial.tmx", __ASSET__assets_data_levelmap_tutorial_tmx);
		type.set ("assets/data/levelmap_tutorial.tmx", AssetType.TEXT);
		className.set ("assets/data/lvl1.tmx", __ASSET__assets_data_lvl1_tmx);
		type.set ("assets/data/lvl1.tmx", AssetType.TEXT);
		className.set ("assets/data/lvl2-A.tmx", __ASSET__assets_data_lvl2_a_tmx);
		type.set ("assets/data/lvl2-A.tmx", AssetType.TEXT);
		className.set ("assets/data/lvl2.tmx", __ASSET__assets_data_lvl2_tmx);
		type.set ("assets/data/lvl2.tmx", AssetType.TEXT);
		className.set ("assets/data/lvl3.tmx", __ASSET__assets_data_lvl3_tmx);
		type.set ("assets/data/lvl3.tmx", AssetType.TEXT);
		className.set ("assets/data/lvl3A.tmx", __ASSET__assets_data_lvl3a_tmx);
		type.set ("assets/data/lvl3A.tmx", AssetType.TEXT);
		className.set ("assets/data/tutorialState.tmx", __ASSET__assets_data_tutorialstate_tmx);
		type.set ("assets/data/tutorialState.tmx", AssetType.TEXT);
		className.set ("assets/images/arrow.png", __ASSET__assets_images_arrow_png);
		type.set ("assets/images/arrow.png", AssetType.IMAGE);
		className.set ("assets/images/arrow2.png", __ASSET__assets_images_arrow2_png);
		type.set ("assets/images/arrow2.png", AssetType.IMAGE);
		className.set ("assets/images/ball.png", __ASSET__assets_images_ball_png);
		type.set ("assets/images/ball.png", AssetType.IMAGE);
		className.set ("assets/images/ballbullet.png", __ASSET__assets_images_ballbullet_png);
		type.set ("assets/images/ballbullet.png", AssetType.IMAGE);
		className.set ("assets/images/blackmarket.png", __ASSET__assets_images_blackmarket_png);
		type.set ("assets/images/blackmarket.png", AssetType.IMAGE);
		className.set ("assets/images/boss1bg/boss1background.png", __ASSET__assets_images_boss1bg_boss1background_png);
		type.set ("assets/images/boss1bg/boss1background.png", AssetType.IMAGE);
		className.set ("assets/images/boss1bg/boss1tile.png", __ASSET__assets_images_boss1bg_boss1tile_png);
		type.set ("assets/images/boss1bg/boss1tile.png", AssetType.IMAGE);
		className.set ("assets/images/boss2bg/boss2bg.png", __ASSET__assets_images_boss2bg_boss2bg_png);
		type.set ("assets/images/boss2bg/boss2bg.png", AssetType.IMAGE);
		className.set ("assets/images/boss2bg/boss2tile.png", __ASSET__assets_images_boss2bg_boss2tile_png);
		type.set ("assets/images/boss2bg/boss2tile.png", AssetType.IMAGE);
		className.set ("assets/images/cancel.png", __ASSET__assets_images_cancel_png);
		type.set ("assets/images/cancel.png", AssetType.IMAGE);
		className.set ("assets/images/chargedRevolverBullet.png", __ASSET__assets_images_chargedrevolverbullet_png);
		type.set ("assets/images/chargedRevolverBullet.png", AssetType.IMAGE);
		className.set ("assets/images/city.jpg", __ASSET__assets_images_city_jpg);
		type.set ("assets/images/city.jpg", AssetType.IMAGE);
		className.set ("assets/images/coinIcon.png", __ASSET__assets_images_coinicon_png);
		type.set ("assets/images/coinIcon.png", AssetType.IMAGE);
		className.set ("assets/images/coins.png", __ASSET__assets_images_coins_png);
		type.set ("assets/images/coins.png", AssetType.IMAGE);
		className.set ("assets/images/confirm.png", __ASSET__assets_images_confirm_png);
		type.set ("assets/images/confirm.png", AssetType.IMAGE);
		className.set ("assets/images/continue.png", __ASSET__assets_images_continue_png);
		type.set ("assets/images/continue.png", AssetType.IMAGE);
		className.set ("assets/images/credits.png", __ASSET__assets_images_credits_png);
		type.set ("assets/images/credits.png", AssetType.IMAGE);
		className.set ("assets/images/creditsbtn.png", __ASSET__assets_images_creditsbtn_png);
		type.set ("assets/images/creditsbtn.png", AssetType.IMAGE);
		className.set ("assets/images/dialog1.png", __ASSET__assets_images_dialog1_png);
		type.set ("assets/images/dialog1.png", AssetType.IMAGE);
		className.set ("assets/images/dialog2.png", __ASSET__assets_images_dialog2_png);
		type.set ("assets/images/dialog2.png", AssetType.IMAGE);
		className.set ("assets/images/door.png", __ASSET__assets_images_door_png);
		type.set ("assets/images/door.png", AssetType.IMAGE);
		className.set ("assets/images/emptyslot.png", __ASSET__assets_images_emptyslot_png);
		type.set ("assets/images/emptyslot.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/boss2/boss2.png", __ASSET__assets_images_enemies_boss2_boss2_png);
		type.set ("assets/images/Enemies/boss2/boss2.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/boss2/hand.png", __ASSET__assets_images_enemies_boss2_hand_png);
		type.set ("assets/images/Enemies/boss2/hand.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/jp_melee/jp_enemy_melee.png", __ASSET__assets_images_enemies_jp_melee_jp_enemy_melee_png);
		type.set ("assets/images/Enemies/jp_melee/jp_enemy_melee.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/jp_rifle/jp_enemy_rifle.png", __ASSET__assets_images_enemies_jp_rifle_jp_enemy_rifle_png);
		type.set ("assets/images/Enemies/jp_rifle/jp_enemy_rifle.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/jp_shield/jp_enemy_shield.png", __ASSET__assets_images_enemies_jp_shield_jp_enemy_shield_png);
		type.set ("assets/images/Enemies/jp_shield/jp_enemy_shield.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/melee/enemy_melee.png", __ASSET__assets_images_enemies_melee_enemy_melee_png);
		type.set ("assets/images/Enemies/melee/enemy_melee.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/minotarous/abc.png", __ASSET__assets_images_enemies_minotarous_abc_png);
		type.set ("assets/images/Enemies/minotarous/abc.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/rifle/enemy_rifle.png", __ASSET__assets_images_enemies_rifle_enemy_rifle_png);
		type.set ("assets/images/Enemies/rifle/enemy_rifle.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/shield/enemy_shield.png", __ASSET__assets_images_enemies_shield_enemy_shield_png);
		type.set ("assets/images/Enemies/shield/enemy_shield.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/truck/enemy_truck.png", __ASSET__assets_images_enemies_truck_enemy_truck_png);
		type.set ("assets/images/Enemies/truck/enemy_truck.png", AssetType.IMAGE);
		className.set ("assets/images/enemybullet.png", __ASSET__assets_images_enemybullet_png);
		type.set ("assets/images/enemybullet.png", AssetType.IMAGE);
		className.set ("assets/images/gohome.png", __ASSET__assets_images_gohome_png);
		type.set ("assets/images/gohome.png", AssetType.IMAGE);
		className.set ("assets/images/head.png", __ASSET__assets_images_head_png);
		type.set ("assets/images/head.png", AssetType.IMAGE);
		className.set ("assets/images/health.png", __ASSET__assets_images_health_png);
		type.set ("assets/images/health.png", AssetType.IMAGE);
		className.set ("assets/images/healthPotion.png", __ASSET__assets_images_healthpotion_png);
		type.set ("assets/images/healthPotion.png", AssetType.IMAGE);
		className.set ("assets/images/home.png", __ASSET__assets_images_home_png);
		type.set ("assets/images/home.png", AssetType.IMAGE);
		className.set ("assets/images/iceblock.jpg", __ASSET__assets_images_iceblock_jpg);
		type.set ("assets/images/iceblock.jpg", AssetType.IMAGE);
		className.set ("assets/images/IceBox.png", __ASSET__assets_images_icebox_png);
		type.set ("assets/images/IceBox.png", AssetType.IMAGE);
		className.set ("assets/images/iceburg.jpg", __ASSET__assets_images_iceburg_jpg);
		type.set ("assets/images/iceburg.jpg", AssetType.IMAGE);
		className.set ("assets/images/keyboard.png", __ASSET__assets_images_keyboard_png);
		type.set ("assets/images/keyboard.png", AssetType.IMAGE);
		className.set ("assets/images/kiLeft.png", __ASSET__assets_images_kileft_png);
		type.set ("assets/images/kiLeft.png", AssetType.IMAGE);
		className.set ("assets/images/kiRight.png", __ASSET__assets_images_kiright_png);
		type.set ("assets/images/kiRight.png", AssetType.IMAGE);
		className.set ("assets/images/level1BG.png", __ASSET__assets_images_level1bg_png);
		type.set ("assets/images/level1BG.png", AssetType.IMAGE);
		className.set ("assets/images/levelmap.png", __ASSET__assets_images_levelmap_png);
		type.set ("assets/images/levelmap.png", AssetType.IMAGE);
		className.set ("assets/images/map_icon.png", __ASSET__assets_images_map_icon_png);
		type.set ("assets/images/map_icon.png", AssetType.IMAGE);
		className.set ("assets/images/menu.png", __ASSET__assets_images_menu_png);
		type.set ("assets/images/menu.png", AssetType.IMAGE);
		className.set ("assets/images/menuBG.png", __ASSET__assets_images_menubg_png);
		type.set ("assets/images/menuBG.png", AssetType.IMAGE);
		className.set ("assets/images/newgame.png", __ASSET__assets_images_newgame_png);
		type.set ("assets/images/newgame.png", AssetType.IMAGE);
		className.set ("assets/images/next.png", __ASSET__assets_images_next_png);
		type.set ("assets/images/next.png", AssetType.IMAGE);
		className.set ("assets/images/oneStar.png", __ASSET__assets_images_onestar_png);
		type.set ("assets/images/oneStar.png", AssetType.IMAGE);
		className.set ("assets/images/oneStar2.png", __ASSET__assets_images_onestar2_png);
		type.set ("assets/images/oneStar2.png", AssetType.IMAGE);
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		className.set ("assets/images/resume.png", __ASSET__assets_images_resume_png);
		type.set ("assets/images/resume.png", AssetType.IMAGE);
		className.set ("assets/images/revolver.png", __ASSET__assets_images_revolver_png);
		type.set ("assets/images/revolver.png", AssetType.IMAGE);
		className.set ("assets/images/revolverbm.png", __ASSET__assets_images_revolverbm_png);
		type.set ("assets/images/revolverbm.png", AssetType.IMAGE);
		className.set ("assets/images/revolverBullet.png", __ASSET__assets_images_revolverbullet_png);
		type.set ("assets/images/revolverBullet.png", AssetType.IMAGE);
		className.set ("assets/images/revolverButton.png", __ASSET__assets_images_revolverbutton_png);
		type.set ("assets/images/revolverButton.png", AssetType.IMAGE);
		className.set ("assets/images/rifle.png", __ASSET__assets_images_rifle_png);
		type.set ("assets/images/rifle.png", AssetType.IMAGE);
		className.set ("assets/images/riflebm.png", __ASSET__assets_images_riflebm_png);
		type.set ("assets/images/riflebm.png", AssetType.IMAGE);
		className.set ("assets/images/rifleButton.png", __ASSET__assets_images_riflebutton_png);
		type.set ("assets/images/rifleButton.png", AssetType.IMAGE);
		className.set ("assets/images/shield.png", __ASSET__assets_images_shield_png);
		type.set ("assets/images/shield.png", AssetType.IMAGE);
		className.set ("assets/images/shield_imageicon.png", __ASSET__assets_images_shield_imageicon_png);
		type.set ("assets/images/shield_imageicon.png", AssetType.IMAGE);
		className.set ("assets/images/shieldbm.png", __ASSET__assets_images_shieldbm_png);
		type.set ("assets/images/shieldbm.png", AssetType.IMAGE);
		className.set ("assets/images/shieldButton.png", __ASSET__assets_images_shieldbutton_png);
		type.set ("assets/images/shieldButton.png", AssetType.IMAGE);
		className.set ("assets/images/shotgun.png", __ASSET__assets_images_shotgun_png);
		type.set ("assets/images/shotgun.png", AssetType.IMAGE);
		className.set ("assets/images/shotgunbm.png", __ASSET__assets_images_shotgunbm_png);
		type.set ("assets/images/shotgunbm.png", AssetType.IMAGE);
		className.set ("assets/images/shotgunBullet.png", __ASSET__assets_images_shotgunbullet_png);
		type.set ("assets/images/shotgunBullet.png", AssetType.IMAGE);
		className.set ("assets/images/shotgunButton.png", __ASSET__assets_images_shotgunbutton_png);
		type.set ("assets/images/shotgunButton.png", AssetType.IMAGE);
		className.set ("assets/images/sky1.jpg", __ASSET__assets_images_sky1_jpg);
		type.set ("assets/images/sky1.jpg", AssetType.IMAGE);
		className.set ("assets/images/star_red.png", __ASSET__assets_images_star_red_png);
		type.set ("assets/images/star_red.png", AssetType.IMAGE);
		className.set ("assets/images/star_red_lock.png", __ASSET__assets_images_star_red_lock_png);
		type.set ("assets/images/star_red_lock.png", AssetType.IMAGE);
		className.set ("assets/images/star_yellow.png", __ASSET__assets_images_star_yellow_png);
		type.set ("assets/images/star_yellow.png", AssetType.IMAGE);
		className.set ("assets/images/star_yellow_lock.png", __ASSET__assets_images_star_yellow_lock_png);
		type.set ("assets/images/star_yellow_lock.png", AssetType.IMAGE);
		className.set ("assets/images/sword.png", __ASSET__assets_images_sword_png);
		type.set ("assets/images/sword.png", AssetType.IMAGE);
		className.set ("assets/images/swordbm.png", __ASSET__assets_images_swordbm_png);
		type.set ("assets/images/swordbm.png", AssetType.IMAGE);
		className.set ("assets/images/swordButton.png", __ASSET__assets_images_swordbutton_png);
		type.set ("assets/images/swordButton.png", AssetType.IMAGE);
		className.set ("assets/images/threeStar.png", __ASSET__assets_images_threestar_png);
		type.set ("assets/images/threeStar.png", AssetType.IMAGE);
		className.set ("assets/images/threeStar2.png", __ASSET__assets_images_threestar2_png);
		type.set ("assets/images/threeStar2.png", AssetType.IMAGE);
		className.set ("assets/images/tryagain.png", __ASSET__assets_images_tryagain_png);
		type.set ("assets/images/tryagain.png", AssetType.IMAGE);
		className.set ("assets/images/tutorialBG.png", __ASSET__assets_images_tutorialbg_png);
		type.set ("assets/images/tutorialBG.png", AssetType.IMAGE);
		className.set ("assets/images/twoStar.png", __ASSET__assets_images_twostar_png);
		type.set ("assets/images/twoStar.png", AssetType.IMAGE);
		className.set ("assets/images/twoStar2.png", __ASSET__assets_images_twostar2_png);
		type.set ("assets/images/twoStar2.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/chargingcolt.png", __ASSET__assets_images_upgrade_chargingcolt_png);
		type.set ("assets/images/upgrade/chargingcolt.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/damage.png", __ASSET__assets_images_upgrade_damage_png);
		type.set ("assets/images/upgrade/damage.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/daze.png", __ASSET__assets_images_upgrade_daze_png);
		type.set ("assets/images/upgrade/daze.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/dualproficiency.png", __ASSET__assets_images_upgrade_dualproficiency_png);
		type.set ("assets/images/upgrade/dualproficiency.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/fuelefficiency.png", __ASSET__assets_images_upgrade_fuelefficiency_png);
		type.set ("assets/images/upgrade/fuelefficiency.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/juggernaut.png", __ASSET__assets_images_upgrade_juggernaut_png);
		type.set ("assets/images/upgrade/juggernaut.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/kimaster.png", __ASSET__assets_images_upgrade_kimaster_png);
		type.set ("assets/images/upgrade/kimaster.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/lifesaver.png", __ASSET__assets_images_upgrade_lifesaver_png);
		type.set ("assets/images/upgrade/lifesaver.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/magazineSize.png", __ASSET__assets_images_upgrade_magazinesize_png);
		type.set ("assets/images/upgrade/magazineSize.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/rateoffire.png", __ASSET__assets_images_upgrade_rateoffire_png);
		type.set ("assets/images/upgrade/rateoffire.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/reflectiveshield.png", __ASSET__assets_images_upgrade_reflectiveshield_png);
		type.set ("assets/images/upgrade/reflectiveshield.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/reloadspeed.png", __ASSET__assets_images_upgrade_reloadspeed_png);
		type.set ("assets/images/upgrade/reloadspeed.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/spikedshield.png", __ASSET__assets_images_upgrade_spikedshield_png);
		type.set ("assets/images/upgrade/spikedshield.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/tiarmor.png", __ASSET__assets_images_upgrade_tiarmor_png);
		type.set ("assets/images/upgrade/tiarmor.png", AssetType.IMAGE);
		className.set ("assets/images/upgrade/whirlwind.png", __ASSET__assets_images_upgrade_whirlwind_png);
		type.set ("assets/images/upgrade/whirlwind.png", AssetType.IMAGE);
		className.set ("assets/images/workshop.png", __ASSET__assets_images_workshop_png);
		type.set ("assets/images/workshop.png", AssetType.IMAGE);
		className.set ("assets/music/boss.mp3", __ASSET__assets_music_boss_mp3);
		type.set ("assets/music/boss.mp3", AssetType.MUSIC);
		className.set ("assets/music/dramatic.mp3", __ASSET__assets_music_dramatic_mp3);
		type.set ("assets/music/dramatic.mp3", AssetType.MUSIC);
		className.set ("assets/music/fighting.mp3", __ASSET__assets_music_fighting_mp3);
		type.set ("assets/music/fighting.mp3", AssetType.MUSIC);
		className.set ("assets/music/introspection.mp3", __ASSET__assets_music_introspection_mp3);
		type.set ("assets/music/introspection.mp3", AssetType.MUSIC);
		className.set ("assets/music/theme.mp3", __ASSET__assets_music_theme_mp3);
		type.set ("assets/music/theme.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/coin_pickup.wav", __ASSET__assets_sounds_coin_pickup_wav);
		type.set ("assets/sounds/coin_pickup.wav", AssetType.SOUND);
		className.set ("assets/sounds/Hit/hit_human1.wav", __ASSET__assets_sounds_hit_hit_human1_wav);
		type.set ("assets/sounds/Hit/hit_human1.wav", AssetType.SOUND);
		className.set ("assets/sounds/Hit/hit_human2.wav", __ASSET__assets_sounds_hit_hit_human2_wav);
		type.set ("assets/sounds/Hit/hit_human2.wav", AssetType.SOUND);
		className.set ("assets/sounds/Hit/hit_human3.wav", __ASSET__assets_sounds_hit_hit_human3_wav);
		type.set ("assets/sounds/Hit/hit_human3.wav", AssetType.SOUND);
		className.set ("assets/sounds/Hit/hit_monster1.wav", __ASSET__assets_sounds_hit_hit_monster1_wav);
		type.set ("assets/sounds/Hit/hit_monster1.wav", AssetType.SOUND);
		className.set ("assets/sounds/Hit/hit_monster2.wav", __ASSET__assets_sounds_hit_hit_monster2_wav);
		type.set ("assets/sounds/Hit/hit_monster2.wav", AssetType.SOUND);
		className.set ("assets/sounds/Hit/hit_monster3.wav", __ASSET__assets_sounds_hit_hit_monster3_wav);
		type.set ("assets/sounds/Hit/hit_monster3.wav", AssetType.SOUND);
		className.set ("assets/sounds/Jetpack/jetpack.wav", __ASSET__assets_sounds_jetpack_jetpack_wav);
		type.set ("assets/sounds/Jetpack/jetpack.wav", AssetType.SOUND);
		className.set ("assets/sounds/Laser/laser_charge1.wav", __ASSET__assets_sounds_laser_laser_charge1_wav);
		type.set ("assets/sounds/Laser/laser_charge1.wav", AssetType.SOUND);
		className.set ("assets/sounds/Laser/laser_charge2.wav", __ASSET__assets_sounds_laser_laser_charge2_wav);
		type.set ("assets/sounds/Laser/laser_charge2.wav", AssetType.SOUND);
		className.set ("assets/sounds/Laser/laser_charge3.wav", __ASSET__assets_sounds_laser_laser_charge3_wav);
		type.set ("assets/sounds/Laser/laser_charge3.wav", AssetType.SOUND);
		className.set ("assets/sounds/Laser/laser_fire1.wav", __ASSET__assets_sounds_laser_laser_fire1_wav);
		type.set ("assets/sounds/Laser/laser_fire1.wav", AssetType.SOUND);
		className.set ("assets/sounds/Laser/laser_fire2.wav", __ASSET__assets_sounds_laser_laser_fire2_wav);
		type.set ("assets/sounds/Laser/laser_fire2.wav", AssetType.SOUND);
		className.set ("assets/sounds/Laser/laser_fire3.wav", __ASSET__assets_sounds_laser_laser_fire3_wav);
		type.set ("assets/sounds/Laser/laser_fire3.wav", AssetType.SOUND);
		className.set ("assets/sounds/potion.wav", __ASSET__assets_sounds_potion_wav);
		type.set ("assets/sounds/potion.wav", AssetType.SOUND);
		className.set ("assets/sounds/Rifle/rifle_fire1.wav", __ASSET__assets_sounds_rifle_rifle_fire1_wav);
		type.set ("assets/sounds/Rifle/rifle_fire1.wav", AssetType.SOUND);
		className.set ("assets/sounds/Rifle/rifle_fire2.wav", __ASSET__assets_sounds_rifle_rifle_fire2_wav);
		type.set ("assets/sounds/Rifle/rifle_fire2.wav", AssetType.SOUND);
		className.set ("assets/sounds/Rifle/rifle_reload.wav", __ASSET__assets_sounds_rifle_rifle_reload_wav);
		type.set ("assets/sounds/Rifle/rifle_reload.wav", AssetType.SOUND);
		className.set ("assets/sounds/Shield/shield.wav", __ASSET__assets_sounds_shield_shield_wav);
		type.set ("assets/sounds/Shield/shield.wav", AssetType.SOUND);
		className.set ("assets/sounds/Shotgun/shotgun_fire1.wav", __ASSET__assets_sounds_shotgun_shotgun_fire1_wav);
		type.set ("assets/sounds/Shotgun/shotgun_fire1.wav", AssetType.SOUND);
		className.set ("assets/sounds/Shotgun/shotgun_fire2.wav", __ASSET__assets_sounds_shotgun_shotgun_fire2_wav);
		type.set ("assets/sounds/Shotgun/shotgun_fire2.wav", AssetType.SOUND);
		className.set ("assets/sounds/Shotgun/shotgun_reload.wav", __ASSET__assets_sounds_shotgun_shotgun_reload_wav);
		type.set ("assets/sounds/Shotgun/shotgun_reload.wav", AssetType.SOUND);
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/Sword/sword_slash0.wav", __ASSET__assets_sounds_sword_sword_slash0_wav);
		type.set ("assets/sounds/Sword/sword_slash0.wav", AssetType.SOUND);
		className.set ("assets/sounds/Sword/sword_slash1.wav", __ASSET__assets_sounds_sword_sword_slash1_wav);
		type.set ("assets/sounds/Sword/sword_slash1.wav", AssetType.SOUND);
		className.set ("assets/sounds/Sword/sword_slash2.wav", __ASSET__assets_sounds_sword_sword_slash2_wav);
		type.set ("assets/sounds/Sword/sword_slash2.wav", AssetType.SOUND);
		className.set ("assets/sounds/Sword/sword_slash3.wav", __ASSET__assets_sounds_sword_sword_slash3_wav);
		type.set ("assets/sounds/Sword/sword_slash3.wav", AssetType.SOUND);
		className.set ("flixel/sounds/beep.mp3", __ASSET__flixel_sounds_beep_mp3);
		type.set ("flixel/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("flixel/sounds/flixel.mp3", __ASSET__flixel_sounds_flixel_mp3);
		type.set ("flixel/sounds/flixel.mp3", AssetType.MUSIC);
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/bg.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/boss1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/boss2.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/day_roman/dayrom.ttf";
		className.set (id, __ASSET__assets_data_day_roman_dayrom_ttf);
		
		type.set (id, AssetType.FONT);
		id = "assets/data/home.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/levelmap.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/levelmap_tutorial.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/lvl1.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/lvl2-A.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/lvl2.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/lvl3.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/lvl3A.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tutorialState.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/arrow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/arrow2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/ball.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/ballbullet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/blackmarket.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/boss1bg/boss1background.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/boss1bg/boss1tile.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/boss2bg/boss2bg.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/boss2bg/boss2tile.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/cancel.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/chargedRevolverBullet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/city.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/coinIcon.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/coins.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/confirm.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/continue.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/credits.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/creditsbtn.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/dialog1.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/dialog2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/door.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/emptyslot.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/boss2/boss2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/boss2/hand.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/jp_melee/jp_enemy_melee.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/jp_rifle/jp_enemy_rifle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/jp_shield/jp_enemy_shield.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/melee/enemy_melee.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/minotarous/abc.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/rifle/enemy_rifle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/shield/enemy_shield.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/truck/enemy_truck.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/enemybullet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/gohome.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/head.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/health.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/healthPotion.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/home.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/iceblock.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/IceBox.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/iceburg.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/keyboard.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/kiLeft.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/kiRight.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/level1BG.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/levelmap.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/map_icon.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/menu.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/menuBG.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/newgame.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/next.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/oneStar.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/oneStar2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/player.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/resume.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/revolver.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/revolverbm.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/revolverBullet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/revolverButton.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/rifle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/riflebm.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/rifleButton.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shield.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shield_imageicon.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shieldbm.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shieldButton.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shotgun.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shotgunbm.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shotgunBullet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shotgunButton.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/sky1.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/star_red.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/star_red_lock.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/star_yellow.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/star_yellow_lock.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/sword.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/swordbm.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/swordButton.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/threeStar.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/threeStar2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tryagain.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tutorialBG.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/twoStar.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/twoStar2.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/chargingcolt.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/damage.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/daze.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/dualproficiency.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/fuelefficiency.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/juggernaut.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/kimaster.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/lifesaver.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/magazineSize.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/rateoffire.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/reflectiveshield.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/reloadspeed.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/spikedshield.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/tiarmor.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/upgrade/whirlwind.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/workshop.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/music/boss.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/music/dramatic.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/music/fighting.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/music/introspection.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/music/theme.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/coin_pickup.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Hit/hit_human1.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Hit/hit_human2.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Hit/hit_human3.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Hit/hit_monster1.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Hit/hit_monster2.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Hit/hit_monster3.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Jetpack/jetpack.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Laser/laser_charge1.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Laser/laser_charge2.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Laser/laser_charge3.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Laser/laser_fire1.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Laser/laser_fire2.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Laser/laser_fire3.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/potion.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Rifle/rifle_fire1.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Rifle/rifle_fire2.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Rifle/rifle_reload.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Shield/shield.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Shotgun/shotgun_fire1.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Shotgun/shotgun_fire2.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Shotgun/shotgun_reload.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/sounds-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/Sword/sword_slash0.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Sword/sword_slash1.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Sword/sword_slash2.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "assets/sounds/Sword/sword_slash3.wav";
		path.set (id, id);
		
		type.set (id, AssetType.SOUND);
		id = "flixel/sounds/beep.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "flixel/sounds/flixel.mp3";
		path.set (id, id);
		
		type.set (id, AssetType.MUSIC);
		id = "flixel/fonts/nokiafc22.ttf";
		className.set (id, __ASSET__flixel_fonts_nokiafc22_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/fonts/monsterrat.ttf";
		className.set (id, __ASSET__flixel_fonts_monsterrat_ttf);
		
		type.set (id, AssetType.FONT);
		id = "flixel/images/ui/button.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "flixel/images/logo/default.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		
		
		var assetsPrefix = null;
		if (ApplicationMain.config != null && Reflect.hasField (ApplicationMain.config, "assetsPrefix")) {
			assetsPrefix = ApplicationMain.config.assetsPrefix;
		}
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/data/bg.tmx", __ASSET__assets_data_bg_tmx);
		type.set ("assets/data/bg.tmx", AssetType.TEXT);
		
		className.set ("assets/data/boss1.tmx", __ASSET__assets_data_boss1_tmx);
		type.set ("assets/data/boss1.tmx", AssetType.TEXT);
		
		className.set ("assets/data/boss2.tmx", __ASSET__assets_data_boss2_tmx);
		type.set ("assets/data/boss2.tmx", AssetType.TEXT);
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/data/day_roman/dayrom.ttf", __ASSET__assets_data_day_roman_dayrom_ttf);
		type.set ("assets/data/day_roman/dayrom.ttf", AssetType.FONT);
		
		className.set ("assets/data/home.tmx", __ASSET__assets_data_home_tmx);
		type.set ("assets/data/home.tmx", AssetType.TEXT);
		
		className.set ("assets/data/levelmap.tmx", __ASSET__assets_data_levelmap_tmx);
		type.set ("assets/data/levelmap.tmx", AssetType.TEXT);
		
		className.set ("assets/data/levelmap_tutorial.tmx", __ASSET__assets_data_levelmap_tutorial_tmx);
		type.set ("assets/data/levelmap_tutorial.tmx", AssetType.TEXT);
		
		className.set ("assets/data/lvl1.tmx", __ASSET__assets_data_lvl1_tmx);
		type.set ("assets/data/lvl1.tmx", AssetType.TEXT);
		
		className.set ("assets/data/lvl2-A.tmx", __ASSET__assets_data_lvl2_a_tmx);
		type.set ("assets/data/lvl2-A.tmx", AssetType.TEXT);
		
		className.set ("assets/data/lvl2.tmx", __ASSET__assets_data_lvl2_tmx);
		type.set ("assets/data/lvl2.tmx", AssetType.TEXT);
		
		className.set ("assets/data/lvl3.tmx", __ASSET__assets_data_lvl3_tmx);
		type.set ("assets/data/lvl3.tmx", AssetType.TEXT);
		
		className.set ("assets/data/lvl3A.tmx", __ASSET__assets_data_lvl3a_tmx);
		type.set ("assets/data/lvl3A.tmx", AssetType.TEXT);
		
		className.set ("assets/data/tutorialState.tmx", __ASSET__assets_data_tutorialstate_tmx);
		type.set ("assets/data/tutorialState.tmx", AssetType.TEXT);
		
		className.set ("assets/images/arrow.png", __ASSET__assets_images_arrow_png);
		type.set ("assets/images/arrow.png", AssetType.IMAGE);
		
		className.set ("assets/images/arrow2.png", __ASSET__assets_images_arrow2_png);
		type.set ("assets/images/arrow2.png", AssetType.IMAGE);
		
		className.set ("assets/images/ball.png", __ASSET__assets_images_ball_png);
		type.set ("assets/images/ball.png", AssetType.IMAGE);
		
		className.set ("assets/images/ballbullet.png", __ASSET__assets_images_ballbullet_png);
		type.set ("assets/images/ballbullet.png", AssetType.IMAGE);
		
		className.set ("assets/images/blackmarket.png", __ASSET__assets_images_blackmarket_png);
		type.set ("assets/images/blackmarket.png", AssetType.IMAGE);
		
		className.set ("assets/images/boss1bg/boss1background.png", __ASSET__assets_images_boss1bg_boss1background_png);
		type.set ("assets/images/boss1bg/boss1background.png", AssetType.IMAGE);
		
		className.set ("assets/images/boss1bg/boss1tile.png", __ASSET__assets_images_boss1bg_boss1tile_png);
		type.set ("assets/images/boss1bg/boss1tile.png", AssetType.IMAGE);
		
		className.set ("assets/images/boss2bg/boss2bg.png", __ASSET__assets_images_boss2bg_boss2bg_png);
		type.set ("assets/images/boss2bg/boss2bg.png", AssetType.IMAGE);
		
		className.set ("assets/images/boss2bg/boss2tile.png", __ASSET__assets_images_boss2bg_boss2tile_png);
		type.set ("assets/images/boss2bg/boss2tile.png", AssetType.IMAGE);
		
		className.set ("assets/images/cancel.png", __ASSET__assets_images_cancel_png);
		type.set ("assets/images/cancel.png", AssetType.IMAGE);
		
		className.set ("assets/images/chargedRevolverBullet.png", __ASSET__assets_images_chargedrevolverbullet_png);
		type.set ("assets/images/chargedRevolverBullet.png", AssetType.IMAGE);
		
		className.set ("assets/images/city.jpg", __ASSET__assets_images_city_jpg);
		type.set ("assets/images/city.jpg", AssetType.IMAGE);
		
		className.set ("assets/images/coinIcon.png", __ASSET__assets_images_coinicon_png);
		type.set ("assets/images/coinIcon.png", AssetType.IMAGE);
		
		className.set ("assets/images/coins.png", __ASSET__assets_images_coins_png);
		type.set ("assets/images/coins.png", AssetType.IMAGE);
		
		className.set ("assets/images/confirm.png", __ASSET__assets_images_confirm_png);
		type.set ("assets/images/confirm.png", AssetType.IMAGE);
		
		className.set ("assets/images/continue.png", __ASSET__assets_images_continue_png);
		type.set ("assets/images/continue.png", AssetType.IMAGE);
		
		className.set ("assets/images/credits.png", __ASSET__assets_images_credits_png);
		type.set ("assets/images/credits.png", AssetType.IMAGE);
		
		className.set ("assets/images/creditsbtn.png", __ASSET__assets_images_creditsbtn_png);
		type.set ("assets/images/creditsbtn.png", AssetType.IMAGE);
		
		className.set ("assets/images/dialog1.png", __ASSET__assets_images_dialog1_png);
		type.set ("assets/images/dialog1.png", AssetType.IMAGE);
		
		className.set ("assets/images/dialog2.png", __ASSET__assets_images_dialog2_png);
		type.set ("assets/images/dialog2.png", AssetType.IMAGE);
		
		className.set ("assets/images/door.png", __ASSET__assets_images_door_png);
		type.set ("assets/images/door.png", AssetType.IMAGE);
		
		className.set ("assets/images/emptyslot.png", __ASSET__assets_images_emptyslot_png);
		type.set ("assets/images/emptyslot.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/boss2/boss2.png", __ASSET__assets_images_enemies_boss2_boss2_png);
		type.set ("assets/images/Enemies/boss2/boss2.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/boss2/hand.png", __ASSET__assets_images_enemies_boss2_hand_png);
		type.set ("assets/images/Enemies/boss2/hand.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/jp_melee/jp_enemy_melee.png", __ASSET__assets_images_enemies_jp_melee_jp_enemy_melee_png);
		type.set ("assets/images/Enemies/jp_melee/jp_enemy_melee.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/jp_rifle/jp_enemy_rifle.png", __ASSET__assets_images_enemies_jp_rifle_jp_enemy_rifle_png);
		type.set ("assets/images/Enemies/jp_rifle/jp_enemy_rifle.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/jp_shield/jp_enemy_shield.png", __ASSET__assets_images_enemies_jp_shield_jp_enemy_shield_png);
		type.set ("assets/images/Enemies/jp_shield/jp_enemy_shield.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/melee/enemy_melee.png", __ASSET__assets_images_enemies_melee_enemy_melee_png);
		type.set ("assets/images/Enemies/melee/enemy_melee.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/minotarous/abc.png", __ASSET__assets_images_enemies_minotarous_abc_png);
		type.set ("assets/images/Enemies/minotarous/abc.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/rifle/enemy_rifle.png", __ASSET__assets_images_enemies_rifle_enemy_rifle_png);
		type.set ("assets/images/Enemies/rifle/enemy_rifle.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/shield/enemy_shield.png", __ASSET__assets_images_enemies_shield_enemy_shield_png);
		type.set ("assets/images/Enemies/shield/enemy_shield.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/truck/enemy_truck.png", __ASSET__assets_images_enemies_truck_enemy_truck_png);
		type.set ("assets/images/Enemies/truck/enemy_truck.png", AssetType.IMAGE);
		
		className.set ("assets/images/enemybullet.png", __ASSET__assets_images_enemybullet_png);
		type.set ("assets/images/enemybullet.png", AssetType.IMAGE);
		
		className.set ("assets/images/gohome.png", __ASSET__assets_images_gohome_png);
		type.set ("assets/images/gohome.png", AssetType.IMAGE);
		
		className.set ("assets/images/head.png", __ASSET__assets_images_head_png);
		type.set ("assets/images/head.png", AssetType.IMAGE);
		
		className.set ("assets/images/health.png", __ASSET__assets_images_health_png);
		type.set ("assets/images/health.png", AssetType.IMAGE);
		
		className.set ("assets/images/healthPotion.png", __ASSET__assets_images_healthpotion_png);
		type.set ("assets/images/healthPotion.png", AssetType.IMAGE);
		
		className.set ("assets/images/home.png", __ASSET__assets_images_home_png);
		type.set ("assets/images/home.png", AssetType.IMAGE);
		
		className.set ("assets/images/iceblock.jpg", __ASSET__assets_images_iceblock_jpg);
		type.set ("assets/images/iceblock.jpg", AssetType.IMAGE);
		
		className.set ("assets/images/IceBox.png", __ASSET__assets_images_icebox_png);
		type.set ("assets/images/IceBox.png", AssetType.IMAGE);
		
		className.set ("assets/images/iceburg.jpg", __ASSET__assets_images_iceburg_jpg);
		type.set ("assets/images/iceburg.jpg", AssetType.IMAGE);
		
		className.set ("assets/images/keyboard.png", __ASSET__assets_images_keyboard_png);
		type.set ("assets/images/keyboard.png", AssetType.IMAGE);
		
		className.set ("assets/images/kiLeft.png", __ASSET__assets_images_kileft_png);
		type.set ("assets/images/kiLeft.png", AssetType.IMAGE);
		
		className.set ("assets/images/kiRight.png", __ASSET__assets_images_kiright_png);
		type.set ("assets/images/kiRight.png", AssetType.IMAGE);
		
		className.set ("assets/images/level1BG.png", __ASSET__assets_images_level1bg_png);
		type.set ("assets/images/level1BG.png", AssetType.IMAGE);
		
		className.set ("assets/images/levelmap.png", __ASSET__assets_images_levelmap_png);
		type.set ("assets/images/levelmap.png", AssetType.IMAGE);
		
		className.set ("assets/images/map_icon.png", __ASSET__assets_images_map_icon_png);
		type.set ("assets/images/map_icon.png", AssetType.IMAGE);
		
		className.set ("assets/images/menu.png", __ASSET__assets_images_menu_png);
		type.set ("assets/images/menu.png", AssetType.IMAGE);
		
		className.set ("assets/images/menuBG.png", __ASSET__assets_images_menubg_png);
		type.set ("assets/images/menuBG.png", AssetType.IMAGE);
		
		className.set ("assets/images/newgame.png", __ASSET__assets_images_newgame_png);
		type.set ("assets/images/newgame.png", AssetType.IMAGE);
		
		className.set ("assets/images/next.png", __ASSET__assets_images_next_png);
		type.set ("assets/images/next.png", AssetType.IMAGE);
		
		className.set ("assets/images/oneStar.png", __ASSET__assets_images_onestar_png);
		type.set ("assets/images/oneStar.png", AssetType.IMAGE);
		
		className.set ("assets/images/oneStar2.png", __ASSET__assets_images_onestar2_png);
		type.set ("assets/images/oneStar2.png", AssetType.IMAGE);
		
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		
		className.set ("assets/images/resume.png", __ASSET__assets_images_resume_png);
		type.set ("assets/images/resume.png", AssetType.IMAGE);
		
		className.set ("assets/images/revolver.png", __ASSET__assets_images_revolver_png);
		type.set ("assets/images/revolver.png", AssetType.IMAGE);
		
		className.set ("assets/images/revolverbm.png", __ASSET__assets_images_revolverbm_png);
		type.set ("assets/images/revolverbm.png", AssetType.IMAGE);
		
		className.set ("assets/images/revolverBullet.png", __ASSET__assets_images_revolverbullet_png);
		type.set ("assets/images/revolverBullet.png", AssetType.IMAGE);
		
		className.set ("assets/images/revolverButton.png", __ASSET__assets_images_revolverbutton_png);
		type.set ("assets/images/revolverButton.png", AssetType.IMAGE);
		
		className.set ("assets/images/rifle.png", __ASSET__assets_images_rifle_png);
		type.set ("assets/images/rifle.png", AssetType.IMAGE);
		
		className.set ("assets/images/riflebm.png", __ASSET__assets_images_riflebm_png);
		type.set ("assets/images/riflebm.png", AssetType.IMAGE);
		
		className.set ("assets/images/rifleButton.png", __ASSET__assets_images_riflebutton_png);
		type.set ("assets/images/rifleButton.png", AssetType.IMAGE);
		
		className.set ("assets/images/shield.png", __ASSET__assets_images_shield_png);
		type.set ("assets/images/shield.png", AssetType.IMAGE);
		
		className.set ("assets/images/shield_imageicon.png", __ASSET__assets_images_shield_imageicon_png);
		type.set ("assets/images/shield_imageicon.png", AssetType.IMAGE);
		
		className.set ("assets/images/shieldbm.png", __ASSET__assets_images_shieldbm_png);
		type.set ("assets/images/shieldbm.png", AssetType.IMAGE);
		
		className.set ("assets/images/shieldButton.png", __ASSET__assets_images_shieldbutton_png);
		type.set ("assets/images/shieldButton.png", AssetType.IMAGE);
		
		className.set ("assets/images/shotgun.png", __ASSET__assets_images_shotgun_png);
		type.set ("assets/images/shotgun.png", AssetType.IMAGE);
		
		className.set ("assets/images/shotgunbm.png", __ASSET__assets_images_shotgunbm_png);
		type.set ("assets/images/shotgunbm.png", AssetType.IMAGE);
		
		className.set ("assets/images/shotgunBullet.png", __ASSET__assets_images_shotgunbullet_png);
		type.set ("assets/images/shotgunBullet.png", AssetType.IMAGE);
		
		className.set ("assets/images/shotgunButton.png", __ASSET__assets_images_shotgunbutton_png);
		type.set ("assets/images/shotgunButton.png", AssetType.IMAGE);
		
		className.set ("assets/images/sky1.jpg", __ASSET__assets_images_sky1_jpg);
		type.set ("assets/images/sky1.jpg", AssetType.IMAGE);
		
		className.set ("assets/images/star_red.png", __ASSET__assets_images_star_red_png);
		type.set ("assets/images/star_red.png", AssetType.IMAGE);
		
		className.set ("assets/images/star_red_lock.png", __ASSET__assets_images_star_red_lock_png);
		type.set ("assets/images/star_red_lock.png", AssetType.IMAGE);
		
		className.set ("assets/images/star_yellow.png", __ASSET__assets_images_star_yellow_png);
		type.set ("assets/images/star_yellow.png", AssetType.IMAGE);
		
		className.set ("assets/images/star_yellow_lock.png", __ASSET__assets_images_star_yellow_lock_png);
		type.set ("assets/images/star_yellow_lock.png", AssetType.IMAGE);
		
		className.set ("assets/images/sword.png", __ASSET__assets_images_sword_png);
		type.set ("assets/images/sword.png", AssetType.IMAGE);
		
		className.set ("assets/images/swordbm.png", __ASSET__assets_images_swordbm_png);
		type.set ("assets/images/swordbm.png", AssetType.IMAGE);
		
		className.set ("assets/images/swordButton.png", __ASSET__assets_images_swordbutton_png);
		type.set ("assets/images/swordButton.png", AssetType.IMAGE);
		
		className.set ("assets/images/threeStar.png", __ASSET__assets_images_threestar_png);
		type.set ("assets/images/threeStar.png", AssetType.IMAGE);
		
		className.set ("assets/images/threeStar2.png", __ASSET__assets_images_threestar2_png);
		type.set ("assets/images/threeStar2.png", AssetType.IMAGE);
		
		className.set ("assets/images/tryagain.png", __ASSET__assets_images_tryagain_png);
		type.set ("assets/images/tryagain.png", AssetType.IMAGE);
		
		className.set ("assets/images/tutorialBG.png", __ASSET__assets_images_tutorialbg_png);
		type.set ("assets/images/tutorialBG.png", AssetType.IMAGE);
		
		className.set ("assets/images/twoStar.png", __ASSET__assets_images_twostar_png);
		type.set ("assets/images/twoStar.png", AssetType.IMAGE);
		
		className.set ("assets/images/twoStar2.png", __ASSET__assets_images_twostar2_png);
		type.set ("assets/images/twoStar2.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/chargingcolt.png", __ASSET__assets_images_upgrade_chargingcolt_png);
		type.set ("assets/images/upgrade/chargingcolt.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/damage.png", __ASSET__assets_images_upgrade_damage_png);
		type.set ("assets/images/upgrade/damage.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/daze.png", __ASSET__assets_images_upgrade_daze_png);
		type.set ("assets/images/upgrade/daze.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/dualproficiency.png", __ASSET__assets_images_upgrade_dualproficiency_png);
		type.set ("assets/images/upgrade/dualproficiency.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/fuelefficiency.png", __ASSET__assets_images_upgrade_fuelefficiency_png);
		type.set ("assets/images/upgrade/fuelefficiency.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/juggernaut.png", __ASSET__assets_images_upgrade_juggernaut_png);
		type.set ("assets/images/upgrade/juggernaut.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/kimaster.png", __ASSET__assets_images_upgrade_kimaster_png);
		type.set ("assets/images/upgrade/kimaster.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/lifesaver.png", __ASSET__assets_images_upgrade_lifesaver_png);
		type.set ("assets/images/upgrade/lifesaver.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/magazineSize.png", __ASSET__assets_images_upgrade_magazinesize_png);
		type.set ("assets/images/upgrade/magazineSize.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/rateoffire.png", __ASSET__assets_images_upgrade_rateoffire_png);
		type.set ("assets/images/upgrade/rateoffire.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/reflectiveshield.png", __ASSET__assets_images_upgrade_reflectiveshield_png);
		type.set ("assets/images/upgrade/reflectiveshield.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/reloadspeed.png", __ASSET__assets_images_upgrade_reloadspeed_png);
		type.set ("assets/images/upgrade/reloadspeed.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/spikedshield.png", __ASSET__assets_images_upgrade_spikedshield_png);
		type.set ("assets/images/upgrade/spikedshield.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/tiarmor.png", __ASSET__assets_images_upgrade_tiarmor_png);
		type.set ("assets/images/upgrade/tiarmor.png", AssetType.IMAGE);
		
		className.set ("assets/images/upgrade/whirlwind.png", __ASSET__assets_images_upgrade_whirlwind_png);
		type.set ("assets/images/upgrade/whirlwind.png", AssetType.IMAGE);
		
		className.set ("assets/images/workshop.png", __ASSET__assets_images_workshop_png);
		type.set ("assets/images/workshop.png", AssetType.IMAGE);
		
		className.set ("assets/music/boss.mp3", __ASSET__assets_music_boss_mp3);
		type.set ("assets/music/boss.mp3", AssetType.MUSIC);
		
		className.set ("assets/music/dramatic.mp3", __ASSET__assets_music_dramatic_mp3);
		type.set ("assets/music/dramatic.mp3", AssetType.MUSIC);
		
		className.set ("assets/music/fighting.mp3", __ASSET__assets_music_fighting_mp3);
		type.set ("assets/music/fighting.mp3", AssetType.MUSIC);
		
		className.set ("assets/music/introspection.mp3", __ASSET__assets_music_introspection_mp3);
		type.set ("assets/music/introspection.mp3", AssetType.MUSIC);
		
		className.set ("assets/music/theme.mp3", __ASSET__assets_music_theme_mp3);
		type.set ("assets/music/theme.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/coin_pickup.wav", __ASSET__assets_sounds_coin_pickup_wav);
		type.set ("assets/sounds/coin_pickup.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Hit/hit_human1.wav", __ASSET__assets_sounds_hit_hit_human1_wav);
		type.set ("assets/sounds/Hit/hit_human1.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Hit/hit_human2.wav", __ASSET__assets_sounds_hit_hit_human2_wav);
		type.set ("assets/sounds/Hit/hit_human2.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Hit/hit_human3.wav", __ASSET__assets_sounds_hit_hit_human3_wav);
		type.set ("assets/sounds/Hit/hit_human3.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Hit/hit_monster1.wav", __ASSET__assets_sounds_hit_hit_monster1_wav);
		type.set ("assets/sounds/Hit/hit_monster1.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Hit/hit_monster2.wav", __ASSET__assets_sounds_hit_hit_monster2_wav);
		type.set ("assets/sounds/Hit/hit_monster2.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Hit/hit_monster3.wav", __ASSET__assets_sounds_hit_hit_monster3_wav);
		type.set ("assets/sounds/Hit/hit_monster3.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Jetpack/jetpack.wav", __ASSET__assets_sounds_jetpack_jetpack_wav);
		type.set ("assets/sounds/Jetpack/jetpack.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Laser/laser_charge1.wav", __ASSET__assets_sounds_laser_laser_charge1_wav);
		type.set ("assets/sounds/Laser/laser_charge1.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Laser/laser_charge2.wav", __ASSET__assets_sounds_laser_laser_charge2_wav);
		type.set ("assets/sounds/Laser/laser_charge2.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Laser/laser_charge3.wav", __ASSET__assets_sounds_laser_laser_charge3_wav);
		type.set ("assets/sounds/Laser/laser_charge3.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Laser/laser_fire1.wav", __ASSET__assets_sounds_laser_laser_fire1_wav);
		type.set ("assets/sounds/Laser/laser_fire1.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Laser/laser_fire2.wav", __ASSET__assets_sounds_laser_laser_fire2_wav);
		type.set ("assets/sounds/Laser/laser_fire2.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Laser/laser_fire3.wav", __ASSET__assets_sounds_laser_laser_fire3_wav);
		type.set ("assets/sounds/Laser/laser_fire3.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/potion.wav", __ASSET__assets_sounds_potion_wav);
		type.set ("assets/sounds/potion.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Rifle/rifle_fire1.wav", __ASSET__assets_sounds_rifle_rifle_fire1_wav);
		type.set ("assets/sounds/Rifle/rifle_fire1.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Rifle/rifle_fire2.wav", __ASSET__assets_sounds_rifle_rifle_fire2_wav);
		type.set ("assets/sounds/Rifle/rifle_fire2.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Rifle/rifle_reload.wav", __ASSET__assets_sounds_rifle_rifle_reload_wav);
		type.set ("assets/sounds/Rifle/rifle_reload.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Shield/shield.wav", __ASSET__assets_sounds_shield_shield_wav);
		type.set ("assets/sounds/Shield/shield.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Shotgun/shotgun_fire1.wav", __ASSET__assets_sounds_shotgun_shotgun_fire1_wav);
		type.set ("assets/sounds/Shotgun/shotgun_fire1.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Shotgun/shotgun_fire2.wav", __ASSET__assets_sounds_shotgun_shotgun_fire2_wav);
		type.set ("assets/sounds/Shotgun/shotgun_fire2.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Shotgun/shotgun_reload.wav", __ASSET__assets_sounds_shotgun_shotgun_reload_wav);
		type.set ("assets/sounds/Shotgun/shotgun_reload.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/Sword/sword_slash0.wav", __ASSET__assets_sounds_sword_sword_slash0_wav);
		type.set ("assets/sounds/Sword/sword_slash0.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Sword/sword_slash1.wav", __ASSET__assets_sounds_sword_sword_slash1_wav);
		type.set ("assets/sounds/Sword/sword_slash1.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Sword/sword_slash2.wav", __ASSET__assets_sounds_sword_sword_slash2_wav);
		type.set ("assets/sounds/Sword/sword_slash2.wav", AssetType.SOUND);
		
		className.set ("assets/sounds/Sword/sword_slash3.wav", __ASSET__assets_sounds_sword_sword_slash3_wav);
		type.set ("assets/sounds/Sword/sword_slash3.wav", AssetType.SOUND);
		
		className.set ("flixel/sounds/beep.mp3", __ASSET__flixel_sounds_beep_mp3);
		type.set ("flixel/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("flixel/sounds/flixel.mp3", __ASSET__flixel_sounds_flixel_mp3);
		type.set ("flixel/sounds/flixel.mp3", AssetType.MUSIC);
		
		className.set ("flixel/fonts/nokiafc22.ttf", __ASSET__flixel_fonts_nokiafc22_ttf);
		type.set ("flixel/fonts/nokiafc22.ttf", AssetType.FONT);
		
		className.set ("flixel/fonts/monsterrat.ttf", __ASSET__flixel_fonts_monsterrat_ttf);
		type.set ("flixel/fonts/monsterrat.ttf", AssetType.FONT);
		
		className.set ("flixel/images/ui/button.png", __ASSET__flixel_images_ui_button_png);
		type.set ("flixel/images/ui/button.png", AssetType.IMAGE);
		
		className.set ("flixel/images/logo/default.png", __ASSET__flixel_images_logo_default_png);
		type.set ("flixel/images/logo/default.png", AssetType.IMAGE);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						onChange.dispatch ();
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == TEXT && assetType == BINARY) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), Bytes));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):Bytes {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return Bytes.ofData (cast (Type.createInstance (className.get (id), []), flash.utils.ByteArray));
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return Bytes.ofData (bitmapData.getPixels (bitmapData.rect));
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), Bytes);
		
		#elseif html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Bytes);
		else return Bytes.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var loader = Preloader.loaders.get (path.get (id));
		
		if (loader == null) {
			
			return null;
			
		}
		
		var bytes = loader.bytes;
		
		if (bytes != null) {
			
			return bytes.getString (0, bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.getString (0, bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String):Future<AudioBuffer> {
		
		var promise = new Promise<AudioBuffer> ();
		
		#if (flash)
		
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				promise.complete (audioBuffer);
				
			});
			soundLoader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			soundLoader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getAudioBuffer (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<AudioBuffer> (function () return getAudioBuffer (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadBytes (id:String):Future<Bytes> {
		
		var promise = new Promise<Bytes> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.dataFormat = flash.net.URLLoaderDataFormat.BINARY;
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = Bytes.ofData (event.currentTarget.data);
				promise.complete (bytes);
				
			});
			loader.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			promise.completeWith (request.load (path.get (id) + "?" + Assets.cache.version));
			
		} else {
			
			promise.complete (getBytes (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Bytes> (function () return getBytes (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	public override function loadImage (id:String):Future<Image> {
		
		var promise = new Promise<Image> ();
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				promise.complete (Image.fromBitmapData (bitmapData));
				
			});
			loader.contentLoaderInfo.addEventListener (ProgressEvent.PROGRESS, function (event) {
				
				if (event.bytesTotal == 0) {
					
					promise.progress (0);
					
				} else {
					
					promise.progress (event.bytesLoaded / event.bytesTotal);
					
				}
				
			});
			loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR, promise.error);
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#elseif html5
		
		if (path.exists (id)) {
			
			var image = new js.html.Image ();
			image.onload = function (_):Void {
				
				promise.complete (Image.fromImageElement (image));
				
			}
			image.onerror = promise.error;
			image.src = path.get (id) + "?" + Assets.cache.version;
			
		} else {
			
			promise.complete (getImage (id));
			
		}
		
		#else
		
		promise.completeWith (new Future<Image> (function () return getImage (id)));
		
		#end
		
		return promise.future;
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = Bytes.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = Bytes.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = Bytes.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = Bytes.readFile ("../Resources/manifest");
			#elseif (ios || tvos)
			var bytes = Bytes.readFile ("assets/manifest");
			#else
			var bytes = Bytes.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				if (bytes.length > 0) {
					
					var data = bytes.getString (0, bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if (ios || tvos)
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadText (id:String):Future<String> {
		
		var promise = new Promise<String> ();
		
		#if html5
		
		if (path.exists (id)) {
			
			var request = new HTTPRequest ();
			var future = request.load (path.get (id) + "?" + Assets.cache.version);
			future.onProgress (function (progress) promise.progress (progress));
			future.onError (function (msg) promise.error (msg));
			future.onComplete (function (bytes) promise.complete (bytes.getString (0, bytes.length)));
			
		} else {
			
			promise.complete (getText (id));
			
		}
		
		#else
		
		promise.completeWith (loadBytes (id).then (function (bytes) {
			
			return new Future<String> (function () {
				
				if (bytes == null) {
					
					return null;
					
				} else {
					
					return bytes.getString (0, bytes.length);
					
				}
				
			});
			
		}));
		
		#end
		
		return promise.future;
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_bg_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_boss1_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_boss2_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_day_roman_dayrom_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_data_home_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levelmap_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_levelmap_tutorial_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_lvl1_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_lvl2_a_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_lvl2_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_lvl3_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_lvl3a_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tutorialstate_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_arrow2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_ball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_ballbullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_blackmarket_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_boss1bg_boss1background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_boss1bg_boss1tile_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_boss2bg_boss2bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_boss2bg_boss2tile_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_cancel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_chargedrevolverbullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_city_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_coinicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_coins_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_confirm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_continue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_credits_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_creditsbtn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_dialog1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_dialog2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_door_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_emptyslot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_boss2_boss2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_boss2_hand_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_jp_melee_jp_enemy_melee_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_jp_rifle_jp_enemy_rifle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_jp_shield_jp_enemy_shield_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_melee_enemy_melee_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_minotarous_abc_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_rifle_enemy_rifle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_shield_enemy_shield_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_truck_enemy_truck_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemybullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_gohome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_head_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_health_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_healthpotion_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_home_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_iceblock_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_icebox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_iceburg_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_keyboard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_kileft_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_kiright_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_level1bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_levelmap_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_map_icon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menu_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_menubg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_newgame_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_next_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_onestar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_onestar2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_resume_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_revolver_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_revolverbm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_revolverbullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_revolverbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rifle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_riflebm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_riflebutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shield_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shield_imageicon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shieldbm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shieldbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shotgun_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shotgunbm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shotgunbullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shotgunbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sky1_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_star_red_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_star_red_lock_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_star_yellow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_star_yellow_lock_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sword_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_swordbm_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_swordbutton_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_threestar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_threestar2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tryagain_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tutorialbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_twostar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_twostar2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_chargingcolt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_damage_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_daze_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_dualproficiency_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_fuelefficiency_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_juggernaut_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_kimaster_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_lifesaver_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_magazinesize_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_rateoffire_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_reflectiveshield_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_reloadspeed_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_spikedshield_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_tiarmor_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_upgrade_whirlwind_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_workshop_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_boss_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_music_dramatic_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_music_fighting_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_music_introspection_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_music_theme_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_coin_pickup_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hit_hit_human1_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hit_hit_human2_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hit_hit_human3_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hit_hit_monster1_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hit_hit_monster2_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_hit_hit_monster3_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_jetpack_jetpack_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_laser_laser_charge1_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_laser_laser_charge2_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_laser_laser_charge3_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_laser_laser_fire1_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_laser_laser_fire2_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_laser_laser_fire3_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_potion_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_rifle_rifle_fire1_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_rifle_rifle_fire2_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_rifle_rifle_reload_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_shield_shield_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_shotgun_shotgun_fire1_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_shotgun_shotgun_fire2_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_shotgun_shotgun_reload_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sword_sword_slash0_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sword_sword_slash1_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sword_sword_slash2_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sword_sword_slash3_wav extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif html5





@:keep #if display private #end class __ASSET__assets_data_day_roman_dayrom_ttf extends lime.text.Font { public function new () { super (); name = "Day Roman"; } } 















































































































































@:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { super (); name = "Monsterrat"; } } 




#else



#if (windows || mac || linux || cpp)


@:file("assets/data/bg.tmx") #if display private #end class __ASSET__assets_data_bg_tmx extends lime.utils.Bytes {}
@:file("assets/data/boss1.tmx") #if display private #end class __ASSET__assets_data_boss1_tmx extends lime.utils.Bytes {}
@:file("assets/data/boss2.tmx") #if display private #end class __ASSET__assets_data_boss2_tmx extends lime.utils.Bytes {}
@:file("assets/data/data-goes-here.txt") #if display private #end class __ASSET__assets_data_data_goes_here_txt extends lime.utils.Bytes {}
@:font("assets/data/day_roman/dayrom.ttf") #if display private #end class __ASSET__assets_data_day_roman_dayrom_ttf extends lime.text.Font {}
@:file("assets/data/home.tmx") #if display private #end class __ASSET__assets_data_home_tmx extends lime.utils.Bytes {}
@:file("assets/data/levelmap.tmx") #if display private #end class __ASSET__assets_data_levelmap_tmx extends lime.utils.Bytes {}
@:file("assets/data/levelmap_tutorial.tmx") #if display private #end class __ASSET__assets_data_levelmap_tutorial_tmx extends lime.utils.Bytes {}
@:file("assets/data/lvl1.tmx") #if display private #end class __ASSET__assets_data_lvl1_tmx extends lime.utils.Bytes {}
@:file("assets/data/lvl2-A.tmx") #if display private #end class __ASSET__assets_data_lvl2_a_tmx extends lime.utils.Bytes {}
@:file("assets/data/lvl2.tmx") #if display private #end class __ASSET__assets_data_lvl2_tmx extends lime.utils.Bytes {}
@:file("assets/data/lvl3.tmx") #if display private #end class __ASSET__assets_data_lvl3_tmx extends lime.utils.Bytes {}
@:file("assets/data/lvl3A.tmx") #if display private #end class __ASSET__assets_data_lvl3a_tmx extends lime.utils.Bytes {}
@:file("assets/data/tutorialState.tmx") #if display private #end class __ASSET__assets_data_tutorialstate_tmx extends lime.utils.Bytes {}
@:image("assets/images/arrow.png") #if display private #end class __ASSET__assets_images_arrow_png extends lime.graphics.Image {}
@:image("assets/images/arrow2.png") #if display private #end class __ASSET__assets_images_arrow2_png extends lime.graphics.Image {}
@:image("assets/images/ball.png") #if display private #end class __ASSET__assets_images_ball_png extends lime.graphics.Image {}
@:image("assets/images/ballbullet.png") #if display private #end class __ASSET__assets_images_ballbullet_png extends lime.graphics.Image {}
@:image("assets/images/blackmarket.png") #if display private #end class __ASSET__assets_images_blackmarket_png extends lime.graphics.Image {}
@:image("assets/images/boss1bg/boss1background.png") #if display private #end class __ASSET__assets_images_boss1bg_boss1background_png extends lime.graphics.Image {}
@:image("assets/images/boss1bg/boss1tile.png") #if display private #end class __ASSET__assets_images_boss1bg_boss1tile_png extends lime.graphics.Image {}
@:image("assets/images/boss2bg/boss2bg.png") #if display private #end class __ASSET__assets_images_boss2bg_boss2bg_png extends lime.graphics.Image {}
@:image("assets/images/boss2bg/boss2tile.png") #if display private #end class __ASSET__assets_images_boss2bg_boss2tile_png extends lime.graphics.Image {}
@:image("assets/images/cancel.png") #if display private #end class __ASSET__assets_images_cancel_png extends lime.graphics.Image {}
@:image("assets/images/chargedRevolverBullet.png") #if display private #end class __ASSET__assets_images_chargedrevolverbullet_png extends lime.graphics.Image {}
@:image("assets/images/city.jpg") #if display private #end class __ASSET__assets_images_city_jpg extends lime.graphics.Image {}
@:image("assets/images/coinIcon.png") #if display private #end class __ASSET__assets_images_coinicon_png extends lime.graphics.Image {}
@:image("assets/images/coins.png") #if display private #end class __ASSET__assets_images_coins_png extends lime.graphics.Image {}
@:image("assets/images/confirm.png") #if display private #end class __ASSET__assets_images_confirm_png extends lime.graphics.Image {}
@:image("assets/images/continue.png") #if display private #end class __ASSET__assets_images_continue_png extends lime.graphics.Image {}
@:image("assets/images/credits.png") #if display private #end class __ASSET__assets_images_credits_png extends lime.graphics.Image {}
@:image("assets/images/creditsbtn.png") #if display private #end class __ASSET__assets_images_creditsbtn_png extends lime.graphics.Image {}
@:image("assets/images/dialog1.png") #if display private #end class __ASSET__assets_images_dialog1_png extends lime.graphics.Image {}
@:image("assets/images/dialog2.png") #if display private #end class __ASSET__assets_images_dialog2_png extends lime.graphics.Image {}
@:image("assets/images/door.png") #if display private #end class __ASSET__assets_images_door_png extends lime.graphics.Image {}
@:image("assets/images/emptyslot.png") #if display private #end class __ASSET__assets_images_emptyslot_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/boss2/boss2.png") #if display private #end class __ASSET__assets_images_enemies_boss2_boss2_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/boss2/hand.png") #if display private #end class __ASSET__assets_images_enemies_boss2_hand_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/jp_melee/jp_enemy_melee.png") #if display private #end class __ASSET__assets_images_enemies_jp_melee_jp_enemy_melee_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/jp_rifle/jp_enemy_rifle.png") #if display private #end class __ASSET__assets_images_enemies_jp_rifle_jp_enemy_rifle_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/jp_shield/jp_enemy_shield.png") #if display private #end class __ASSET__assets_images_enemies_jp_shield_jp_enemy_shield_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/melee/enemy_melee.png") #if display private #end class __ASSET__assets_images_enemies_melee_enemy_melee_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/minotarous/abc.png") #if display private #end class __ASSET__assets_images_enemies_minotarous_abc_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/rifle/enemy_rifle.png") #if display private #end class __ASSET__assets_images_enemies_rifle_enemy_rifle_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/shield/enemy_shield.png") #if display private #end class __ASSET__assets_images_enemies_shield_enemy_shield_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/truck/enemy_truck.png") #if display private #end class __ASSET__assets_images_enemies_truck_enemy_truck_png extends lime.graphics.Image {}
@:image("assets/images/enemybullet.png") #if display private #end class __ASSET__assets_images_enemybullet_png extends lime.graphics.Image {}
@:image("assets/images/gohome.png") #if display private #end class __ASSET__assets_images_gohome_png extends lime.graphics.Image {}
@:image("assets/images/head.png") #if display private #end class __ASSET__assets_images_head_png extends lime.graphics.Image {}
@:image("assets/images/health.png") #if display private #end class __ASSET__assets_images_health_png extends lime.graphics.Image {}
@:image("assets/images/healthPotion.png") #if display private #end class __ASSET__assets_images_healthpotion_png extends lime.graphics.Image {}
@:image("assets/images/home.png") #if display private #end class __ASSET__assets_images_home_png extends lime.graphics.Image {}
@:image("assets/images/iceblock.jpg") #if display private #end class __ASSET__assets_images_iceblock_jpg extends lime.graphics.Image {}
@:image("assets/images/IceBox.png") #if display private #end class __ASSET__assets_images_icebox_png extends lime.graphics.Image {}
@:image("assets/images/iceburg.jpg") #if display private #end class __ASSET__assets_images_iceburg_jpg extends lime.graphics.Image {}
@:image("assets/images/keyboard.png") #if display private #end class __ASSET__assets_images_keyboard_png extends lime.graphics.Image {}
@:image("assets/images/kiLeft.png") #if display private #end class __ASSET__assets_images_kileft_png extends lime.graphics.Image {}
@:image("assets/images/kiRight.png") #if display private #end class __ASSET__assets_images_kiright_png extends lime.graphics.Image {}
@:image("assets/images/level1BG.png") #if display private #end class __ASSET__assets_images_level1bg_png extends lime.graphics.Image {}
@:image("assets/images/levelmap.png") #if display private #end class __ASSET__assets_images_levelmap_png extends lime.graphics.Image {}
@:image("assets/images/map_icon.png") #if display private #end class __ASSET__assets_images_map_icon_png extends lime.graphics.Image {}
@:image("assets/images/menu.png") #if display private #end class __ASSET__assets_images_menu_png extends lime.graphics.Image {}
@:image("assets/images/menuBG.png") #if display private #end class __ASSET__assets_images_menubg_png extends lime.graphics.Image {}
@:image("assets/images/newgame.png") #if display private #end class __ASSET__assets_images_newgame_png extends lime.graphics.Image {}
@:image("assets/images/next.png") #if display private #end class __ASSET__assets_images_next_png extends lime.graphics.Image {}
@:image("assets/images/oneStar.png") #if display private #end class __ASSET__assets_images_onestar_png extends lime.graphics.Image {}
@:image("assets/images/oneStar2.png") #if display private #end class __ASSET__assets_images_onestar2_png extends lime.graphics.Image {}
@:image("assets/images/player.png") #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:image("assets/images/resume.png") #if display private #end class __ASSET__assets_images_resume_png extends lime.graphics.Image {}
@:image("assets/images/revolver.png") #if display private #end class __ASSET__assets_images_revolver_png extends lime.graphics.Image {}
@:image("assets/images/revolverbm.png") #if display private #end class __ASSET__assets_images_revolverbm_png extends lime.graphics.Image {}
@:image("assets/images/revolverBullet.png") #if display private #end class __ASSET__assets_images_revolverbullet_png extends lime.graphics.Image {}
@:image("assets/images/revolverButton.png") #if display private #end class __ASSET__assets_images_revolverbutton_png extends lime.graphics.Image {}
@:image("assets/images/rifle.png") #if display private #end class __ASSET__assets_images_rifle_png extends lime.graphics.Image {}
@:image("assets/images/riflebm.png") #if display private #end class __ASSET__assets_images_riflebm_png extends lime.graphics.Image {}
@:image("assets/images/rifleButton.png") #if display private #end class __ASSET__assets_images_riflebutton_png extends lime.graphics.Image {}
@:image("assets/images/shield.png") #if display private #end class __ASSET__assets_images_shield_png extends lime.graphics.Image {}
@:image("assets/images/shield_imageicon.png") #if display private #end class __ASSET__assets_images_shield_imageicon_png extends lime.graphics.Image {}
@:image("assets/images/shieldbm.png") #if display private #end class __ASSET__assets_images_shieldbm_png extends lime.graphics.Image {}
@:image("assets/images/shieldButton.png") #if display private #end class __ASSET__assets_images_shieldbutton_png extends lime.graphics.Image {}
@:image("assets/images/shotgun.png") #if display private #end class __ASSET__assets_images_shotgun_png extends lime.graphics.Image {}
@:image("assets/images/shotgunbm.png") #if display private #end class __ASSET__assets_images_shotgunbm_png extends lime.graphics.Image {}
@:image("assets/images/shotgunBullet.png") #if display private #end class __ASSET__assets_images_shotgunbullet_png extends lime.graphics.Image {}
@:image("assets/images/shotgunButton.png") #if display private #end class __ASSET__assets_images_shotgunbutton_png extends lime.graphics.Image {}
@:image("assets/images/sky1.jpg") #if display private #end class __ASSET__assets_images_sky1_jpg extends lime.graphics.Image {}
@:image("assets/images/star_red.png") #if display private #end class __ASSET__assets_images_star_red_png extends lime.graphics.Image {}
@:image("assets/images/star_red_lock.png") #if display private #end class __ASSET__assets_images_star_red_lock_png extends lime.graphics.Image {}
@:image("assets/images/star_yellow.png") #if display private #end class __ASSET__assets_images_star_yellow_png extends lime.graphics.Image {}
@:image("assets/images/star_yellow_lock.png") #if display private #end class __ASSET__assets_images_star_yellow_lock_png extends lime.graphics.Image {}
@:image("assets/images/sword.png") #if display private #end class __ASSET__assets_images_sword_png extends lime.graphics.Image {}
@:image("assets/images/swordbm.png") #if display private #end class __ASSET__assets_images_swordbm_png extends lime.graphics.Image {}
@:image("assets/images/swordButton.png") #if display private #end class __ASSET__assets_images_swordbutton_png extends lime.graphics.Image {}
@:image("assets/images/threeStar.png") #if display private #end class __ASSET__assets_images_threestar_png extends lime.graphics.Image {}
@:image("assets/images/threeStar2.png") #if display private #end class __ASSET__assets_images_threestar2_png extends lime.graphics.Image {}
@:image("assets/images/tryagain.png") #if display private #end class __ASSET__assets_images_tryagain_png extends lime.graphics.Image {}
@:image("assets/images/tutorialBG.png") #if display private #end class __ASSET__assets_images_tutorialbg_png extends lime.graphics.Image {}
@:image("assets/images/twoStar.png") #if display private #end class __ASSET__assets_images_twostar_png extends lime.graphics.Image {}
@:image("assets/images/twoStar2.png") #if display private #end class __ASSET__assets_images_twostar2_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/chargingcolt.png") #if display private #end class __ASSET__assets_images_upgrade_chargingcolt_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/damage.png") #if display private #end class __ASSET__assets_images_upgrade_damage_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/daze.png") #if display private #end class __ASSET__assets_images_upgrade_daze_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/dualproficiency.png") #if display private #end class __ASSET__assets_images_upgrade_dualproficiency_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/fuelefficiency.png") #if display private #end class __ASSET__assets_images_upgrade_fuelefficiency_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/juggernaut.png") #if display private #end class __ASSET__assets_images_upgrade_juggernaut_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/kimaster.png") #if display private #end class __ASSET__assets_images_upgrade_kimaster_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/lifesaver.png") #if display private #end class __ASSET__assets_images_upgrade_lifesaver_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/magazineSize.png") #if display private #end class __ASSET__assets_images_upgrade_magazinesize_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/rateoffire.png") #if display private #end class __ASSET__assets_images_upgrade_rateoffire_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/reflectiveshield.png") #if display private #end class __ASSET__assets_images_upgrade_reflectiveshield_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/reloadspeed.png") #if display private #end class __ASSET__assets_images_upgrade_reloadspeed_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/spikedshield.png") #if display private #end class __ASSET__assets_images_upgrade_spikedshield_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/tiarmor.png") #if display private #end class __ASSET__assets_images_upgrade_tiarmor_png extends lime.graphics.Image {}
@:image("assets/images/upgrade/whirlwind.png") #if display private #end class __ASSET__assets_images_upgrade_whirlwind_png extends lime.graphics.Image {}
@:image("assets/images/workshop.png") #if display private #end class __ASSET__assets_images_workshop_png extends lime.graphics.Image {}
@:file("assets/music/boss.mp3") #if display private #end class __ASSET__assets_music_boss_mp3 extends lime.utils.Bytes {}
@:file("assets/music/dramatic.mp3") #if display private #end class __ASSET__assets_music_dramatic_mp3 extends lime.utils.Bytes {}
@:file("assets/music/fighting.mp3") #if display private #end class __ASSET__assets_music_fighting_mp3 extends lime.utils.Bytes {}
@:file("assets/music/introspection.mp3") #if display private #end class __ASSET__assets_music_introspection_mp3 extends lime.utils.Bytes {}
@:file("assets/music/theme.mp3") #if display private #end class __ASSET__assets_music_theme_mp3 extends lime.utils.Bytes {}
@:file("assets/sounds/coin_pickup.wav") #if display private #end class __ASSET__assets_sounds_coin_pickup_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Hit/hit_human1.wav") #if display private #end class __ASSET__assets_sounds_hit_hit_human1_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Hit/hit_human2.wav") #if display private #end class __ASSET__assets_sounds_hit_hit_human2_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Hit/hit_human3.wav") #if display private #end class __ASSET__assets_sounds_hit_hit_human3_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Hit/hit_monster1.wav") #if display private #end class __ASSET__assets_sounds_hit_hit_monster1_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Hit/hit_monster2.wav") #if display private #end class __ASSET__assets_sounds_hit_hit_monster2_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Hit/hit_monster3.wav") #if display private #end class __ASSET__assets_sounds_hit_hit_monster3_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Jetpack/jetpack.wav") #if display private #end class __ASSET__assets_sounds_jetpack_jetpack_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Laser/laser_charge1.wav") #if display private #end class __ASSET__assets_sounds_laser_laser_charge1_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Laser/laser_charge2.wav") #if display private #end class __ASSET__assets_sounds_laser_laser_charge2_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Laser/laser_charge3.wav") #if display private #end class __ASSET__assets_sounds_laser_laser_charge3_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Laser/laser_fire1.wav") #if display private #end class __ASSET__assets_sounds_laser_laser_fire1_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Laser/laser_fire2.wav") #if display private #end class __ASSET__assets_sounds_laser_laser_fire2_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Laser/laser_fire3.wav") #if display private #end class __ASSET__assets_sounds_laser_laser_fire3_wav extends lime.utils.Bytes {}
@:file("assets/sounds/potion.wav") #if display private #end class __ASSET__assets_sounds_potion_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Rifle/rifle_fire1.wav") #if display private #end class __ASSET__assets_sounds_rifle_rifle_fire1_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Rifle/rifle_fire2.wav") #if display private #end class __ASSET__assets_sounds_rifle_rifle_fire2_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Rifle/rifle_reload.wav") #if display private #end class __ASSET__assets_sounds_rifle_rifle_reload_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Shield/shield.wav") #if display private #end class __ASSET__assets_sounds_shield_shield_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Shotgun/shotgun_fire1.wav") #if display private #end class __ASSET__assets_sounds_shotgun_shotgun_fire1_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Shotgun/shotgun_fire2.wav") #if display private #end class __ASSET__assets_sounds_shotgun_shotgun_fire2_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Shotgun/shotgun_reload.wav") #if display private #end class __ASSET__assets_sounds_shotgun_shotgun_reload_wav extends lime.utils.Bytes {}
@:file("assets/sounds/sounds-go-here.txt") #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends lime.utils.Bytes {}
@:file("assets/sounds/Sword/sword_slash0.wav") #if display private #end class __ASSET__assets_sounds_sword_sword_slash0_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Sword/sword_slash1.wav") #if display private #end class __ASSET__assets_sounds_sword_sword_slash1_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Sword/sword_slash2.wav") #if display private #end class __ASSET__assets_sounds_sword_sword_slash2_wav extends lime.utils.Bytes {}
@:file("assets/sounds/Sword/sword_slash3.wav") #if display private #end class __ASSET__assets_sounds_sword_sword_slash3_wav extends lime.utils.Bytes {}
@:file("/usr/local/lib/haxe/lib/flixel/4,2,1/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends lime.utils.Bytes {}
@:file("/usr/local/lib/haxe/lib/flixel/4,2,1/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends lime.utils.Bytes {}
@:font("/usr/local/lib/haxe/lib/flixel/4,2,1/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("/usr/local/lib/haxe/lib/flixel/4,2,1/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:image("/usr/local/lib/haxe/lib/flixel/4,2,1/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:image("/usr/local/lib/haxe/lib/flixel/4,2,1/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__assets_data_day_roman_dayrom_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_data_day_roman_dayrom_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_monsterrat_ttf (); src = font.src; name = font.name; super (); }}

#end

#end