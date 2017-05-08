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
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		
		
		#end
		
		#if flash
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/data/first_level.oel", __ASSET__assets_data_first_level_oel);
		type.set ("assets/data/first_level.oel", AssetType.TEXT);
		className.set ("assets/data/first_map.oep", __ASSET__assets_data_first_map_oep);
		type.set ("assets/data/first_map.oep", AssetType.TEXT);
		className.set ("assets/data/tutorial.tmx", __ASSET__assets_data_tutorial_tmx);
		type.set ("assets/data/tutorial.tmx", AssetType.TEXT);
		className.set ("assets/images/ballbullet.png", __ASSET__assets_images_ballbullet_png);
		type.set ("assets/images/ballbullet.png", AssetType.IMAGE);
		className.set ("assets/images/char/001.png", __ASSET__assets_images_char_001_png);
		type.set ("assets/images/char/001.png", AssetType.IMAGE);
		className.set ("assets/images/char/002.png", __ASSET__assets_images_char_002_png);
		type.set ("assets/images/char/002.png", AssetType.IMAGE);
		className.set ("assets/images/char/003.png", __ASSET__assets_images_char_003_png);
		type.set ("assets/images/char/003.png", AssetType.IMAGE);
		className.set ("assets/images/char/004.png", __ASSET__assets_images_char_004_png);
		type.set ("assets/images/char/004.png", AssetType.IMAGE);
		className.set ("assets/images/char/005.png", __ASSET__assets_images_char_005_png);
		type.set ("assets/images/char/005.png", AssetType.IMAGE);
		className.set ("assets/images/char/006.png", __ASSET__assets_images_char_006_png);
		type.set ("assets/images/char/006.png", AssetType.IMAGE);
		className.set ("assets/images/char/007.png", __ASSET__assets_images_char_007_png);
		type.set ("assets/images/char/007.png", AssetType.IMAGE);
		className.set ("assets/images/char/008.png", __ASSET__assets_images_char_008_png);
		type.set ("assets/images/char/008.png", AssetType.IMAGE);
		className.set ("assets/images/char/009.png", __ASSET__assets_images_char_009_png);
		type.set ("assets/images/char/009.png", AssetType.IMAGE);
		className.set ("assets/images/char/010.png", __ASSET__assets_images_char_010_png);
		type.set ("assets/images/char/010.png", AssetType.IMAGE);
		className.set ("assets/images/char/011.png", __ASSET__assets_images_char_011_png);
		type.set ("assets/images/char/011.png", AssetType.IMAGE);
		className.set ("assets/images/char/012.png", __ASSET__assets_images_char_012_png);
		type.set ("assets/images/char/012.png", AssetType.IMAGE);
		className.set ("assets/images/char/013.png", __ASSET__assets_images_char_013_png);
		type.set ("assets/images/char/013.png", AssetType.IMAGE);
		className.set ("assets/images/char/014.png", __ASSET__assets_images_char_014_png);
		type.set ("assets/images/char/014.png", AssetType.IMAGE);
		className.set ("assets/images/char/016.png", __ASSET__assets_images_char_016_png);
		type.set ("assets/images/char/016.png", AssetType.IMAGE);
		className.set ("assets/images/char/018.png", __ASSET__assets_images_char_018_png);
		type.set ("assets/images/char/018.png", AssetType.IMAGE);
		className.set ("assets/images/char/019.png", __ASSET__assets_images_char_019_png);
		type.set ("assets/images/char/019.png", AssetType.IMAGE);
		className.set ("assets/images/char/020.png", __ASSET__assets_images_char_020_png);
		type.set ("assets/images/char/020.png", AssetType.IMAGE);
		className.set ("assets/images/char/021.png", __ASSET__assets_images_char_021_png);
		type.set ("assets/images/char/021.png", AssetType.IMAGE);
		className.set ("assets/images/char/022.png", __ASSET__assets_images_char_022_png);
		type.set ("assets/images/char/022.png", AssetType.IMAGE);
		className.set ("assets/images/char/023.png", __ASSET__assets_images_char_023_png);
		type.set ("assets/images/char/023.png", AssetType.IMAGE);
		className.set ("assets/images/char/024.png", __ASSET__assets_images_char_024_png);
		type.set ("assets/images/char/024.png", AssetType.IMAGE);
		className.set ("assets/images/char/025.png", __ASSET__assets_images_char_025_png);
		type.set ("assets/images/char/025.png", AssetType.IMAGE);
		className.set ("assets/images/char/026.png", __ASSET__assets_images_char_026_png);
		type.set ("assets/images/char/026.png", AssetType.IMAGE);
		className.set ("assets/images/char/027.png", __ASSET__assets_images_char_027_png);
		type.set ("assets/images/char/027.png", AssetType.IMAGE);
		className.set ("assets/images/char/028.png", __ASSET__assets_images_char_028_png);
		type.set ("assets/images/char/028.png", AssetType.IMAGE);
		className.set ("assets/images/char/029.png", __ASSET__assets_images_char_029_png);
		type.set ("assets/images/char/029.png", AssetType.IMAGE);
		className.set ("assets/images/char/030.png", __ASSET__assets_images_char_030_png);
		type.set ("assets/images/char/030.png", AssetType.IMAGE);
		className.set ("assets/images/char/031.png", __ASSET__assets_images_char_031_png);
		type.set ("assets/images/char/031.png", AssetType.IMAGE);
		className.set ("assets/images/char/032.png", __ASSET__assets_images_char_032_png);
		type.set ("assets/images/char/032.png", AssetType.IMAGE);
		className.set ("assets/images/char/033.png", __ASSET__assets_images_char_033_png);
		type.set ("assets/images/char/033.png", AssetType.IMAGE);
		className.set ("assets/images/char/034.png", __ASSET__assets_images_char_034_png);
		type.set ("assets/images/char/034.png", AssetType.IMAGE);
		className.set ("assets/images/char/035.png", __ASSET__assets_images_char_035_png);
		type.set ("assets/images/char/035.png", AssetType.IMAGE);
		className.set ("assets/images/char/036.png", __ASSET__assets_images_char_036_png);
		type.set ("assets/images/char/036.png", AssetType.IMAGE);
		className.set ("assets/images/char/037.png", __ASSET__assets_images_char_037_png);
		type.set ("assets/images/char/037.png", AssetType.IMAGE);
		className.set ("assets/images/char/038.png", __ASSET__assets_images_char_038_png);
		type.set ("assets/images/char/038.png", AssetType.IMAGE);
		className.set ("assets/images/char/039.png", __ASSET__assets_images_char_039_png);
		type.set ("assets/images/char/039.png", AssetType.IMAGE);
		className.set ("assets/images/char/040.png", __ASSET__assets_images_char_040_png);
		type.set ("assets/images/char/040.png", AssetType.IMAGE);
		className.set ("assets/images/char/041.png", __ASSET__assets_images_char_041_png);
		type.set ("assets/images/char/041.png", AssetType.IMAGE);
		className.set ("assets/images/char/042.png", __ASSET__assets_images_char_042_png);
		type.set ("assets/images/char/042.png", AssetType.IMAGE);
		className.set ("assets/images/char/043.png", __ASSET__assets_images_char_043_png);
		type.set ("assets/images/char/043.png", AssetType.IMAGE);
		className.set ("assets/images/char/044.png", __ASSET__assets_images_char_044_png);
		type.set ("assets/images/char/044.png", AssetType.IMAGE);
		className.set ("assets/images/char/045.png", __ASSET__assets_images_char_045_png);
		type.set ("assets/images/char/045.png", AssetType.IMAGE);
		className.set ("assets/images/char/046.png", __ASSET__assets_images_char_046_png);
		type.set ("assets/images/char/046.png", AssetType.IMAGE);
		className.set ("assets/images/char/047.png", __ASSET__assets_images_char_047_png);
		type.set ("assets/images/char/047.png", AssetType.IMAGE);
		className.set ("assets/images/char/048.png", __ASSET__assets_images_char_048_png);
		type.set ("assets/images/char/048.png", AssetType.IMAGE);
		className.set ("assets/images/char/049.png", __ASSET__assets_images_char_049_png);
		type.set ("assets/images/char/049.png", AssetType.IMAGE);
		className.set ("assets/images/char/050.png", __ASSET__assets_images_char_050_png);
		type.set ("assets/images/char/050.png", AssetType.IMAGE);
		className.set ("assets/images/char/051.png", __ASSET__assets_images_char_051_png);
		type.set ("assets/images/char/051.png", AssetType.IMAGE);
		className.set ("assets/images/char/052.png", __ASSET__assets_images_char_052_png);
		type.set ("assets/images/char/052.png", AssetType.IMAGE);
		className.set ("assets/images/char/054.png", __ASSET__assets_images_char_054_png);
		type.set ("assets/images/char/054.png", AssetType.IMAGE);
		className.set ("assets/images/char/055.png", __ASSET__assets_images_char_055_png);
		type.set ("assets/images/char/055.png", AssetType.IMAGE);
		className.set ("assets/images/char/056.png", __ASSET__assets_images_char_056_png);
		type.set ("assets/images/char/056.png", AssetType.IMAGE);
		className.set ("assets/images/char/057.png", __ASSET__assets_images_char_057_png);
		type.set ("assets/images/char/057.png", AssetType.IMAGE);
		className.set ("assets/images/char/058.png", __ASSET__assets_images_char_058_png);
		type.set ("assets/images/char/058.png", AssetType.IMAGE);
		className.set ("assets/images/char/059.png", __ASSET__assets_images_char_059_png);
		type.set ("assets/images/char/059.png", AssetType.IMAGE);
		className.set ("assets/images/char/060.png", __ASSET__assets_images_char_060_png);
		type.set ("assets/images/char/060.png", AssetType.IMAGE);
		className.set ("assets/images/char/061.png", __ASSET__assets_images_char_061_png);
		type.set ("assets/images/char/061.png", AssetType.IMAGE);
		className.set ("assets/images/char/062.png", __ASSET__assets_images_char_062_png);
		type.set ("assets/images/char/062.png", AssetType.IMAGE);
		className.set ("assets/images/char/063.png", __ASSET__assets_images_char_063_png);
		type.set ("assets/images/char/063.png", AssetType.IMAGE);
		className.set ("assets/images/char/064.png", __ASSET__assets_images_char_064_png);
		type.set ("assets/images/char/064.png", AssetType.IMAGE);
		className.set ("assets/images/char/065.png", __ASSET__assets_images_char_065_png);
		type.set ("assets/images/char/065.png", AssetType.IMAGE);
		className.set ("assets/images/char/066.png", __ASSET__assets_images_char_066_png);
		type.set ("assets/images/char/066.png", AssetType.IMAGE);
		className.set ("assets/images/char/067.png", __ASSET__assets_images_char_067_png);
		type.set ("assets/images/char/067.png", AssetType.IMAGE);
		className.set ("assets/images/char/068.png", __ASSET__assets_images_char_068_png);
		type.set ("assets/images/char/068.png", AssetType.IMAGE);
		className.set ("assets/images/char/069.png", __ASSET__assets_images_char_069_png);
		type.set ("assets/images/char/069.png", AssetType.IMAGE);
		className.set ("assets/images/char/070.png", __ASSET__assets_images_char_070_png);
		type.set ("assets/images/char/070.png", AssetType.IMAGE);
		className.set ("assets/images/char/071.png", __ASSET__assets_images_char_071_png);
		type.set ("assets/images/char/071.png", AssetType.IMAGE);
		className.set ("assets/images/char/072.png", __ASSET__assets_images_char_072_png);
		type.set ("assets/images/char/072.png", AssetType.IMAGE);
		className.set ("assets/images/char/073.png", __ASSET__assets_images_char_073_png);
		type.set ("assets/images/char/073.png", AssetType.IMAGE);
		className.set ("assets/images/char/074.png", __ASSET__assets_images_char_074_png);
		type.set ("assets/images/char/074.png", AssetType.IMAGE);
		className.set ("assets/images/char/075.png", __ASSET__assets_images_char_075_png);
		type.set ("assets/images/char/075.png", AssetType.IMAGE);
		className.set ("assets/images/char/076.png", __ASSET__assets_images_char_076_png);
		type.set ("assets/images/char/076.png", AssetType.IMAGE);
		className.set ("assets/images/char/077.png", __ASSET__assets_images_char_077_png);
		type.set ("assets/images/char/077.png", AssetType.IMAGE);
		className.set ("assets/images/char/078.png", __ASSET__assets_images_char_078_png);
		type.set ("assets/images/char/078.png", AssetType.IMAGE);
		className.set ("assets/images/char/079.png", __ASSET__assets_images_char_079_png);
		type.set ("assets/images/char/079.png", AssetType.IMAGE);
		className.set ("assets/images/char/080.png", __ASSET__assets_images_char_080_png);
		type.set ("assets/images/char/080.png", AssetType.IMAGE);
		className.set ("assets/images/char/081.png", __ASSET__assets_images_char_081_png);
		type.set ("assets/images/char/081.png", AssetType.IMAGE);
		className.set ("assets/images/char/082.png", __ASSET__assets_images_char_082_png);
		type.set ("assets/images/char/082.png", AssetType.IMAGE);
		className.set ("assets/images/char/083.png", __ASSET__assets_images_char_083_png);
		type.set ("assets/images/char/083.png", AssetType.IMAGE);
		className.set ("assets/images/char/084.png", __ASSET__assets_images_char_084_png);
		type.set ("assets/images/char/084.png", AssetType.IMAGE);
		className.set ("assets/images/char/085.png", __ASSET__assets_images_char_085_png);
		type.set ("assets/images/char/085.png", AssetType.IMAGE);
		className.set ("assets/images/char/086.png", __ASSET__assets_images_char_086_png);
		type.set ("assets/images/char/086.png", AssetType.IMAGE);
		className.set ("assets/images/char/087.png", __ASSET__assets_images_char_087_png);
		type.set ("assets/images/char/087.png", AssetType.IMAGE);
		className.set ("assets/images/char/088.png", __ASSET__assets_images_char_088_png);
		type.set ("assets/images/char/088.png", AssetType.IMAGE);
		className.set ("assets/images/char/089.png", __ASSET__assets_images_char_089_png);
		type.set ("assets/images/char/089.png", AssetType.IMAGE);
		className.set ("assets/images/char/090.png", __ASSET__assets_images_char_090_png);
		type.set ("assets/images/char/090.png", AssetType.IMAGE);
		className.set ("assets/images/char/091.png", __ASSET__assets_images_char_091_png);
		type.set ("assets/images/char/091.png", AssetType.IMAGE);
		className.set ("assets/images/char/092.png", __ASSET__assets_images_char_092_png);
		type.set ("assets/images/char/092.png", AssetType.IMAGE);
		className.set ("assets/images/char/093.png", __ASSET__assets_images_char_093_png);
		type.set ("assets/images/char/093.png", AssetType.IMAGE);
		className.set ("assets/images/char/094.png", __ASSET__assets_images_char_094_png);
		type.set ("assets/images/char/094.png", AssetType.IMAGE);
		className.set ("assets/images/char/095.png", __ASSET__assets_images_char_095_png);
		type.set ("assets/images/char/095.png", AssetType.IMAGE);
		className.set ("assets/images/char/096.png", __ASSET__assets_images_char_096_png);
		type.set ("assets/images/char/096.png", AssetType.IMAGE);
		className.set ("assets/images/char/097.png", __ASSET__assets_images_char_097_png);
		type.set ("assets/images/char/097.png", AssetType.IMAGE);
		className.set ("assets/images/char/098.png", __ASSET__assets_images_char_098_png);
		type.set ("assets/images/char/098.png", AssetType.IMAGE);
		className.set ("assets/images/char/099.png", __ASSET__assets_images_char_099_png);
		type.set ("assets/images/char/099.png", AssetType.IMAGE);
		className.set ("assets/images/char/100.png", __ASSET__assets_images_char_100_png);
		type.set ("assets/images/char/100.png", AssetType.IMAGE);
		className.set ("assets/images/char/101.png", __ASSET__assets_images_char_101_png);
		type.set ("assets/images/char/101.png", AssetType.IMAGE);
		className.set ("assets/images/char/102.png", __ASSET__assets_images_char_102_png);
		type.set ("assets/images/char/102.png", AssetType.IMAGE);
		className.set ("assets/images/char/103.png", __ASSET__assets_images_char_103_png);
		type.set ("assets/images/char/103.png", AssetType.IMAGE);
		className.set ("assets/images/char/104.png", __ASSET__assets_images_char_104_png);
		type.set ("assets/images/char/104.png", AssetType.IMAGE);
		className.set ("assets/images/char/105.png", __ASSET__assets_images_char_105_png);
		type.set ("assets/images/char/105.png", AssetType.IMAGE);
		className.set ("assets/images/char/106.png", __ASSET__assets_images_char_106_png);
		type.set ("assets/images/char/106.png", AssetType.IMAGE);
		className.set ("assets/images/char/107.png", __ASSET__assets_images_char_107_png);
		type.set ("assets/images/char/107.png", AssetType.IMAGE);
		className.set ("assets/images/char/108.png", __ASSET__assets_images_char_108_png);
		type.set ("assets/images/char/108.png", AssetType.IMAGE);
		className.set ("assets/images/char/main.png", __ASSET__assets_images_char_main_png);
		type.set ("assets/images/char/main.png", AssetType.IMAGE);
		className.set ("assets/images/coin.png", __ASSET__assets_images_coin_png);
		type.set ("assets/images/coin.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/j.png", __ASSET__assets_images_enemies_j_png);
		type.set ("assets/images/Enemies/j.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/n.png", __ASSET__assets_images_enemies_n_png);
		type.set ("assets/images/Enemies/n.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/p.png", __ASSET__assets_images_enemies_p_png);
		type.set ("assets/images/Enemies/p.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/s.png", __ASSET__assets_images_enemies_s_png);
		type.set ("assets/images/Enemies/s.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t.png", __ASSET__assets_images_enemies_t_png);
		type.set ("assets/images/Enemies/t.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t.png.txt", __ASSET__assets_images_enemies_t_png_txt);
		type.set ("assets/images/Enemies/t.png.txt", AssetType.TEXT);
		className.set ("assets/images/Enemies/t_01.png", __ASSET__assets_images_enemies_t_01_png);
		type.set ("assets/images/Enemies/t_01.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t_02.png", __ASSET__assets_images_enemies_t_02_png);
		type.set ("assets/images/Enemies/t_02.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t_03.png", __ASSET__assets_images_enemies_t_03_png);
		type.set ("assets/images/Enemies/t_03.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t_04.png", __ASSET__assets_images_enemies_t_04_png);
		type.set ("assets/images/Enemies/t_04.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t_05.png", __ASSET__assets_images_enemies_t_05_png);
		type.set ("assets/images/Enemies/t_05.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t_06.png", __ASSET__assets_images_enemies_t_06_png);
		type.set ("assets/images/Enemies/t_06.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t_07.png", __ASSET__assets_images_enemies_t_07_png);
		type.set ("assets/images/Enemies/t_07.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t_08.png", __ASSET__assets_images_enemies_t_08_png);
		type.set ("assets/images/Enemies/t_08.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t_09.png", __ASSET__assets_images_enemies_t_09_png);
		type.set ("assets/images/Enemies/t_09.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t_10.png", __ASSET__assets_images_enemies_t_10_png);
		type.set ("assets/images/Enemies/t_10.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/t_11.png", __ASSET__assets_images_enemies_t_11_png);
		type.set ("assets/images/Enemies/t_11.png", AssetType.IMAGE);
		className.set ("assets/images/Enemies/v.png", __ASSET__assets_images_enemies_v_png);
		type.set ("assets/images/Enemies/v.png", AssetType.IMAGE);
		className.set ("assets/images/enemybullet.png", __ASSET__assets_images_enemybullet_png);
		type.set ("assets/images/enemybullet.png", AssetType.IMAGE);
		className.set ("assets/images/green.jpg", __ASSET__assets_images_green_jpg);
		type.set ("assets/images/green.jpg", AssetType.IMAGE);
		className.set ("assets/images/health.png", __ASSET__assets_images_health_png);
		type.set ("assets/images/health.png", AssetType.IMAGE);
		className.set ("assets/images/home_rough (lighten).png", __ASSET__assets_images_home_rough__lighten__png);
		type.set ("assets/images/home_rough (lighten).png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a.png", __ASSET__assets_images_new_folder_a_png);
		type.set ("assets/images/New folder/a.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_01.png", __ASSET__assets_images_new_folder_a_01_png);
		type.set ("assets/images/New folder/a_01.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_02.png", __ASSET__assets_images_new_folder_a_02_png);
		type.set ("assets/images/New folder/a_02.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_03.png", __ASSET__assets_images_new_folder_a_03_png);
		type.set ("assets/images/New folder/a_03.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_04.png", __ASSET__assets_images_new_folder_a_04_png);
		type.set ("assets/images/New folder/a_04.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_05.png", __ASSET__assets_images_new_folder_a_05_png);
		type.set ("assets/images/New folder/a_05.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_06.png", __ASSET__assets_images_new_folder_a_06_png);
		type.set ("assets/images/New folder/a_06.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_07.png", __ASSET__assets_images_new_folder_a_07_png);
		type.set ("assets/images/New folder/a_07.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_08.png", __ASSET__assets_images_new_folder_a_08_png);
		type.set ("assets/images/New folder/a_08.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_09.png", __ASSET__assets_images_new_folder_a_09_png);
		type.set ("assets/images/New folder/a_09.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_10.png", __ASSET__assets_images_new_folder_a_10_png);
		type.set ("assets/images/New folder/a_10.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_100.png", __ASSET__assets_images_new_folder_a_100_png);
		type.set ("assets/images/New folder/a_100.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_101.png", __ASSET__assets_images_new_folder_a_101_png);
		type.set ("assets/images/New folder/a_101.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_11.png", __ASSET__assets_images_new_folder_a_11_png);
		type.set ("assets/images/New folder/a_11.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_12.png", __ASSET__assets_images_new_folder_a_12_png);
		type.set ("assets/images/New folder/a_12.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_13.png", __ASSET__assets_images_new_folder_a_13_png);
		type.set ("assets/images/New folder/a_13.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_14.png", __ASSET__assets_images_new_folder_a_14_png);
		type.set ("assets/images/New folder/a_14.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_15.png", __ASSET__assets_images_new_folder_a_15_png);
		type.set ("assets/images/New folder/a_15.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_16.png", __ASSET__assets_images_new_folder_a_16_png);
		type.set ("assets/images/New folder/a_16.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_17.png", __ASSET__assets_images_new_folder_a_17_png);
		type.set ("assets/images/New folder/a_17.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_18.png", __ASSET__assets_images_new_folder_a_18_png);
		type.set ("assets/images/New folder/a_18.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_19.png", __ASSET__assets_images_new_folder_a_19_png);
		type.set ("assets/images/New folder/a_19.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_20.png", __ASSET__assets_images_new_folder_a_20_png);
		type.set ("assets/images/New folder/a_20.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_21.png", __ASSET__assets_images_new_folder_a_21_png);
		type.set ("assets/images/New folder/a_21.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_22.png", __ASSET__assets_images_new_folder_a_22_png);
		type.set ("assets/images/New folder/a_22.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_23.png", __ASSET__assets_images_new_folder_a_23_png);
		type.set ("assets/images/New folder/a_23.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_24.png", __ASSET__assets_images_new_folder_a_24_png);
		type.set ("assets/images/New folder/a_24.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_25.png", __ASSET__assets_images_new_folder_a_25_png);
		type.set ("assets/images/New folder/a_25.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_26.png", __ASSET__assets_images_new_folder_a_26_png);
		type.set ("assets/images/New folder/a_26.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_27.png", __ASSET__assets_images_new_folder_a_27_png);
		type.set ("assets/images/New folder/a_27.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_28.png", __ASSET__assets_images_new_folder_a_28_png);
		type.set ("assets/images/New folder/a_28.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_29.png", __ASSET__assets_images_new_folder_a_29_png);
		type.set ("assets/images/New folder/a_29.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_30.png", __ASSET__assets_images_new_folder_a_30_png);
		type.set ("assets/images/New folder/a_30.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_31.png", __ASSET__assets_images_new_folder_a_31_png);
		type.set ("assets/images/New folder/a_31.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_32.png", __ASSET__assets_images_new_folder_a_32_png);
		type.set ("assets/images/New folder/a_32.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_33.png", __ASSET__assets_images_new_folder_a_33_png);
		type.set ("assets/images/New folder/a_33.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_34.png", __ASSET__assets_images_new_folder_a_34_png);
		type.set ("assets/images/New folder/a_34.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_35.png", __ASSET__assets_images_new_folder_a_35_png);
		type.set ("assets/images/New folder/a_35.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_36.png", __ASSET__assets_images_new_folder_a_36_png);
		type.set ("assets/images/New folder/a_36.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_37.png", __ASSET__assets_images_new_folder_a_37_png);
		type.set ("assets/images/New folder/a_37.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_38.png", __ASSET__assets_images_new_folder_a_38_png);
		type.set ("assets/images/New folder/a_38.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_39.png", __ASSET__assets_images_new_folder_a_39_png);
		type.set ("assets/images/New folder/a_39.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_40.png", __ASSET__assets_images_new_folder_a_40_png);
		type.set ("assets/images/New folder/a_40.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_41.png", __ASSET__assets_images_new_folder_a_41_png);
		type.set ("assets/images/New folder/a_41.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_42.png", __ASSET__assets_images_new_folder_a_42_png);
		type.set ("assets/images/New folder/a_42.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_44.png", __ASSET__assets_images_new_folder_a_44_png);
		type.set ("assets/images/New folder/a_44.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_45.png", __ASSET__assets_images_new_folder_a_45_png);
		type.set ("assets/images/New folder/a_45.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_46.png", __ASSET__assets_images_new_folder_a_46_png);
		type.set ("assets/images/New folder/a_46.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_47.png", __ASSET__assets_images_new_folder_a_47_png);
		type.set ("assets/images/New folder/a_47.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_48.png", __ASSET__assets_images_new_folder_a_48_png);
		type.set ("assets/images/New folder/a_48.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_49.png", __ASSET__assets_images_new_folder_a_49_png);
		type.set ("assets/images/New folder/a_49.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_50.png", __ASSET__assets_images_new_folder_a_50_png);
		type.set ("assets/images/New folder/a_50.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_51.png", __ASSET__assets_images_new_folder_a_51_png);
		type.set ("assets/images/New folder/a_51.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_52.png", __ASSET__assets_images_new_folder_a_52_png);
		type.set ("assets/images/New folder/a_52.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_53.png", __ASSET__assets_images_new_folder_a_53_png);
		type.set ("assets/images/New folder/a_53.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_54.png", __ASSET__assets_images_new_folder_a_54_png);
		type.set ("assets/images/New folder/a_54.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_55.png", __ASSET__assets_images_new_folder_a_55_png);
		type.set ("assets/images/New folder/a_55.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_56.png", __ASSET__assets_images_new_folder_a_56_png);
		type.set ("assets/images/New folder/a_56.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_57.png", __ASSET__assets_images_new_folder_a_57_png);
		type.set ("assets/images/New folder/a_57.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_58.png", __ASSET__assets_images_new_folder_a_58_png);
		type.set ("assets/images/New folder/a_58.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_59.png", __ASSET__assets_images_new_folder_a_59_png);
		type.set ("assets/images/New folder/a_59.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_60.png", __ASSET__assets_images_new_folder_a_60_png);
		type.set ("assets/images/New folder/a_60.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_61.png", __ASSET__assets_images_new_folder_a_61_png);
		type.set ("assets/images/New folder/a_61.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_62.png", __ASSET__assets_images_new_folder_a_62_png);
		type.set ("assets/images/New folder/a_62.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_63.png", __ASSET__assets_images_new_folder_a_63_png);
		type.set ("assets/images/New folder/a_63.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_64.png", __ASSET__assets_images_new_folder_a_64_png);
		type.set ("assets/images/New folder/a_64.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_65.png", __ASSET__assets_images_new_folder_a_65_png);
		type.set ("assets/images/New folder/a_65.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_66.png", __ASSET__assets_images_new_folder_a_66_png);
		type.set ("assets/images/New folder/a_66.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_67.png", __ASSET__assets_images_new_folder_a_67_png);
		type.set ("assets/images/New folder/a_67.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_68.png", __ASSET__assets_images_new_folder_a_68_png);
		type.set ("assets/images/New folder/a_68.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_69.png", __ASSET__assets_images_new_folder_a_69_png);
		type.set ("assets/images/New folder/a_69.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_70.png", __ASSET__assets_images_new_folder_a_70_png);
		type.set ("assets/images/New folder/a_70.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_71.png", __ASSET__assets_images_new_folder_a_71_png);
		type.set ("assets/images/New folder/a_71.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_73.png", __ASSET__assets_images_new_folder_a_73_png);
		type.set ("assets/images/New folder/a_73.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_74.png", __ASSET__assets_images_new_folder_a_74_png);
		type.set ("assets/images/New folder/a_74.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_75.png", __ASSET__assets_images_new_folder_a_75_png);
		type.set ("assets/images/New folder/a_75.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_76.png", __ASSET__assets_images_new_folder_a_76_png);
		type.set ("assets/images/New folder/a_76.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_77.png", __ASSET__assets_images_new_folder_a_77_png);
		type.set ("assets/images/New folder/a_77.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_78.png", __ASSET__assets_images_new_folder_a_78_png);
		type.set ("assets/images/New folder/a_78.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_79.png", __ASSET__assets_images_new_folder_a_79_png);
		type.set ("assets/images/New folder/a_79.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_80.png", __ASSET__assets_images_new_folder_a_80_png);
		type.set ("assets/images/New folder/a_80.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_81.png", __ASSET__assets_images_new_folder_a_81_png);
		type.set ("assets/images/New folder/a_81.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_82.png", __ASSET__assets_images_new_folder_a_82_png);
		type.set ("assets/images/New folder/a_82.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_83.png", __ASSET__assets_images_new_folder_a_83_png);
		type.set ("assets/images/New folder/a_83.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_84.png", __ASSET__assets_images_new_folder_a_84_png);
		type.set ("assets/images/New folder/a_84.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_85.png", __ASSET__assets_images_new_folder_a_85_png);
		type.set ("assets/images/New folder/a_85.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_86.png", __ASSET__assets_images_new_folder_a_86_png);
		type.set ("assets/images/New folder/a_86.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_87.png", __ASSET__assets_images_new_folder_a_87_png);
		type.set ("assets/images/New folder/a_87.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_88.png", __ASSET__assets_images_new_folder_a_88_png);
		type.set ("assets/images/New folder/a_88.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_89.png", __ASSET__assets_images_new_folder_a_89_png);
		type.set ("assets/images/New folder/a_89.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_90.png", __ASSET__assets_images_new_folder_a_90_png);
		type.set ("assets/images/New folder/a_90.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_91.png", __ASSET__assets_images_new_folder_a_91_png);
		type.set ("assets/images/New folder/a_91.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_92.png", __ASSET__assets_images_new_folder_a_92_png);
		type.set ("assets/images/New folder/a_92.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_93.png", __ASSET__assets_images_new_folder_a_93_png);
		type.set ("assets/images/New folder/a_93.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_94.png", __ASSET__assets_images_new_folder_a_94_png);
		type.set ("assets/images/New folder/a_94.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_95.png", __ASSET__assets_images_new_folder_a_95_png);
		type.set ("assets/images/New folder/a_95.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_96.png", __ASSET__assets_images_new_folder_a_96_png);
		type.set ("assets/images/New folder/a_96.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_97.png", __ASSET__assets_images_new_folder_a_97_png);
		type.set ("assets/images/New folder/a_97.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_98.png", __ASSET__assets_images_new_folder_a_98_png);
		type.set ("assets/images/New folder/a_98.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/a_99.png", __ASSET__assets_images_new_folder_a_99_png);
		type.set ("assets/images/New folder/a_99.png", AssetType.IMAGE);
		className.set ("assets/images/New folder/b.png", __ASSET__assets_images_new_folder_b_png);
		type.set ("assets/images/New folder/b.png", AssetType.IMAGE);
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		className.set ("assets/images/playerhead.png", __ASSET__assets_images_playerhead_png);
		type.set ("assets/images/playerhead.png", AssetType.IMAGE);
		className.set ("assets/images/q.png", __ASSET__assets_images_q_png);
		type.set ("assets/images/q.png", AssetType.IMAGE);
		className.set ("assets/images/r.png", __ASSET__assets_images_r_png);
		type.set ("assets/images/r.png", AssetType.IMAGE);
		className.set ("assets/images/revolverbullet.png", __ASSET__assets_images_revolverbullet_png);
		type.set ("assets/images/revolverbullet.png", AssetType.IMAGE);
		className.set ("assets/images/rifle.png", __ASSET__assets_images_rifle_png);
		type.set ("assets/images/rifle.png", AssetType.IMAGE);
		className.set ("assets/images/shield.png", __ASSET__assets_images_shield_png);
		type.set ("assets/images/shield.png", AssetType.IMAGE);
		className.set ("assets/images/sword.png", __ASSET__assets_images_sword_png);
		type.set ("assets/images/sword.png", AssetType.IMAGE);
		className.set ("assets/images/tiles.png", __ASSET__assets_images_tiles_png);
		type.set ("assets/images/tiles.png", AssetType.IMAGE);
		className.set ("assets/images/tutorialBG.png", __ASSET__assets_images_tutorialbg_png);
		type.set ("assets/images/tutorialBG.png", AssetType.IMAGE);
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
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
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/first_level.oel";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/first_map.oep";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/data/tutorial.tmx";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/ballbullet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/001.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/002.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/003.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/004.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/005.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/006.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/007.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/008.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/009.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/010.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/011.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/012.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/013.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/014.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/016.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/018.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/019.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/020.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/021.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/022.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/023.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/024.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/025.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/026.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/027.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/028.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/029.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/030.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/031.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/032.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/033.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/034.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/035.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/036.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/037.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/038.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/039.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/040.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/041.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/042.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/043.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/044.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/045.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/046.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/047.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/048.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/049.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/050.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/051.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/052.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/054.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/055.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/056.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/057.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/058.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/059.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/060.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/061.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/062.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/063.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/064.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/065.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/066.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/067.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/068.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/069.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/070.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/071.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/072.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/073.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/074.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/075.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/076.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/077.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/078.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/079.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/080.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/081.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/082.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/083.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/084.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/085.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/086.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/087.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/088.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/089.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/090.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/091.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/092.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/093.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/094.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/095.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/096.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/097.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/098.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/099.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/100.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/101.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/102.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/103.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/104.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/105.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/106.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/107.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/108.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/char/main.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/coin.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/j.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/n.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/p.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/s.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t.png.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/images/Enemies/t_01.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t_02.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t_03.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t_04.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t_05.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t_06.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t_07.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t_08.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t_09.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t_10.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/t_11.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Enemies/v.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/enemybullet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/green.jpg";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/health.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/home_rough (lighten).png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_01.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_02.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_03.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_04.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_05.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_06.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_07.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_08.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_09.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_10.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_100.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_101.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_11.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_12.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_13.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_14.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_15.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_16.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_17.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_18.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_19.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_20.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_21.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_22.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_23.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_24.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_25.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_26.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_27.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_28.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_29.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_30.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_31.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_32.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_33.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_34.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_35.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_36.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_37.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_38.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_39.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_40.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_41.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_42.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_44.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_45.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_46.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_47.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_48.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_49.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_50.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_51.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_52.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_53.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_54.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_55.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_56.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_57.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_58.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_59.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_60.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_61.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_62.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_63.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_64.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_65.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_66.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_67.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_68.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_69.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_70.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_71.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_73.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_74.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_75.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_76.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_77.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_78.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_79.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_80.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_81.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_82.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_83.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_84.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_85.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_86.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_87.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_88.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_89.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_90.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_91.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_92.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_93.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_94.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_95.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_96.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_97.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_98.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/a_99.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/New folder/b.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/player.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/playerhead.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/q.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/r.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/revolverbullet.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/rifle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/shield.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/sword.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tutorialBG.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/sounds-go-here.txt";
		path.set (id, id);
		
		type.set (id, AssetType.TEXT);
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
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/data/first_level.oel", __ASSET__assets_data_first_level_oel);
		type.set ("assets/data/first_level.oel", AssetType.TEXT);
		
		className.set ("assets/data/first_map.oep", __ASSET__assets_data_first_map_oep);
		type.set ("assets/data/first_map.oep", AssetType.TEXT);
		
		className.set ("assets/data/tutorial.tmx", __ASSET__assets_data_tutorial_tmx);
		type.set ("assets/data/tutorial.tmx", AssetType.TEXT);
		
		className.set ("assets/images/ballbullet.png", __ASSET__assets_images_ballbullet_png);
		type.set ("assets/images/ballbullet.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/001.png", __ASSET__assets_images_char_001_png);
		type.set ("assets/images/char/001.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/002.png", __ASSET__assets_images_char_002_png);
		type.set ("assets/images/char/002.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/003.png", __ASSET__assets_images_char_003_png);
		type.set ("assets/images/char/003.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/004.png", __ASSET__assets_images_char_004_png);
		type.set ("assets/images/char/004.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/005.png", __ASSET__assets_images_char_005_png);
		type.set ("assets/images/char/005.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/006.png", __ASSET__assets_images_char_006_png);
		type.set ("assets/images/char/006.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/007.png", __ASSET__assets_images_char_007_png);
		type.set ("assets/images/char/007.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/008.png", __ASSET__assets_images_char_008_png);
		type.set ("assets/images/char/008.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/009.png", __ASSET__assets_images_char_009_png);
		type.set ("assets/images/char/009.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/010.png", __ASSET__assets_images_char_010_png);
		type.set ("assets/images/char/010.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/011.png", __ASSET__assets_images_char_011_png);
		type.set ("assets/images/char/011.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/012.png", __ASSET__assets_images_char_012_png);
		type.set ("assets/images/char/012.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/013.png", __ASSET__assets_images_char_013_png);
		type.set ("assets/images/char/013.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/014.png", __ASSET__assets_images_char_014_png);
		type.set ("assets/images/char/014.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/016.png", __ASSET__assets_images_char_016_png);
		type.set ("assets/images/char/016.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/018.png", __ASSET__assets_images_char_018_png);
		type.set ("assets/images/char/018.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/019.png", __ASSET__assets_images_char_019_png);
		type.set ("assets/images/char/019.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/020.png", __ASSET__assets_images_char_020_png);
		type.set ("assets/images/char/020.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/021.png", __ASSET__assets_images_char_021_png);
		type.set ("assets/images/char/021.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/022.png", __ASSET__assets_images_char_022_png);
		type.set ("assets/images/char/022.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/023.png", __ASSET__assets_images_char_023_png);
		type.set ("assets/images/char/023.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/024.png", __ASSET__assets_images_char_024_png);
		type.set ("assets/images/char/024.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/025.png", __ASSET__assets_images_char_025_png);
		type.set ("assets/images/char/025.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/026.png", __ASSET__assets_images_char_026_png);
		type.set ("assets/images/char/026.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/027.png", __ASSET__assets_images_char_027_png);
		type.set ("assets/images/char/027.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/028.png", __ASSET__assets_images_char_028_png);
		type.set ("assets/images/char/028.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/029.png", __ASSET__assets_images_char_029_png);
		type.set ("assets/images/char/029.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/030.png", __ASSET__assets_images_char_030_png);
		type.set ("assets/images/char/030.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/031.png", __ASSET__assets_images_char_031_png);
		type.set ("assets/images/char/031.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/032.png", __ASSET__assets_images_char_032_png);
		type.set ("assets/images/char/032.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/033.png", __ASSET__assets_images_char_033_png);
		type.set ("assets/images/char/033.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/034.png", __ASSET__assets_images_char_034_png);
		type.set ("assets/images/char/034.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/035.png", __ASSET__assets_images_char_035_png);
		type.set ("assets/images/char/035.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/036.png", __ASSET__assets_images_char_036_png);
		type.set ("assets/images/char/036.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/037.png", __ASSET__assets_images_char_037_png);
		type.set ("assets/images/char/037.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/038.png", __ASSET__assets_images_char_038_png);
		type.set ("assets/images/char/038.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/039.png", __ASSET__assets_images_char_039_png);
		type.set ("assets/images/char/039.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/040.png", __ASSET__assets_images_char_040_png);
		type.set ("assets/images/char/040.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/041.png", __ASSET__assets_images_char_041_png);
		type.set ("assets/images/char/041.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/042.png", __ASSET__assets_images_char_042_png);
		type.set ("assets/images/char/042.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/043.png", __ASSET__assets_images_char_043_png);
		type.set ("assets/images/char/043.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/044.png", __ASSET__assets_images_char_044_png);
		type.set ("assets/images/char/044.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/045.png", __ASSET__assets_images_char_045_png);
		type.set ("assets/images/char/045.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/046.png", __ASSET__assets_images_char_046_png);
		type.set ("assets/images/char/046.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/047.png", __ASSET__assets_images_char_047_png);
		type.set ("assets/images/char/047.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/048.png", __ASSET__assets_images_char_048_png);
		type.set ("assets/images/char/048.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/049.png", __ASSET__assets_images_char_049_png);
		type.set ("assets/images/char/049.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/050.png", __ASSET__assets_images_char_050_png);
		type.set ("assets/images/char/050.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/051.png", __ASSET__assets_images_char_051_png);
		type.set ("assets/images/char/051.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/052.png", __ASSET__assets_images_char_052_png);
		type.set ("assets/images/char/052.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/054.png", __ASSET__assets_images_char_054_png);
		type.set ("assets/images/char/054.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/055.png", __ASSET__assets_images_char_055_png);
		type.set ("assets/images/char/055.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/056.png", __ASSET__assets_images_char_056_png);
		type.set ("assets/images/char/056.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/057.png", __ASSET__assets_images_char_057_png);
		type.set ("assets/images/char/057.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/058.png", __ASSET__assets_images_char_058_png);
		type.set ("assets/images/char/058.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/059.png", __ASSET__assets_images_char_059_png);
		type.set ("assets/images/char/059.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/060.png", __ASSET__assets_images_char_060_png);
		type.set ("assets/images/char/060.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/061.png", __ASSET__assets_images_char_061_png);
		type.set ("assets/images/char/061.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/062.png", __ASSET__assets_images_char_062_png);
		type.set ("assets/images/char/062.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/063.png", __ASSET__assets_images_char_063_png);
		type.set ("assets/images/char/063.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/064.png", __ASSET__assets_images_char_064_png);
		type.set ("assets/images/char/064.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/065.png", __ASSET__assets_images_char_065_png);
		type.set ("assets/images/char/065.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/066.png", __ASSET__assets_images_char_066_png);
		type.set ("assets/images/char/066.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/067.png", __ASSET__assets_images_char_067_png);
		type.set ("assets/images/char/067.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/068.png", __ASSET__assets_images_char_068_png);
		type.set ("assets/images/char/068.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/069.png", __ASSET__assets_images_char_069_png);
		type.set ("assets/images/char/069.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/070.png", __ASSET__assets_images_char_070_png);
		type.set ("assets/images/char/070.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/071.png", __ASSET__assets_images_char_071_png);
		type.set ("assets/images/char/071.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/072.png", __ASSET__assets_images_char_072_png);
		type.set ("assets/images/char/072.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/073.png", __ASSET__assets_images_char_073_png);
		type.set ("assets/images/char/073.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/074.png", __ASSET__assets_images_char_074_png);
		type.set ("assets/images/char/074.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/075.png", __ASSET__assets_images_char_075_png);
		type.set ("assets/images/char/075.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/076.png", __ASSET__assets_images_char_076_png);
		type.set ("assets/images/char/076.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/077.png", __ASSET__assets_images_char_077_png);
		type.set ("assets/images/char/077.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/078.png", __ASSET__assets_images_char_078_png);
		type.set ("assets/images/char/078.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/079.png", __ASSET__assets_images_char_079_png);
		type.set ("assets/images/char/079.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/080.png", __ASSET__assets_images_char_080_png);
		type.set ("assets/images/char/080.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/081.png", __ASSET__assets_images_char_081_png);
		type.set ("assets/images/char/081.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/082.png", __ASSET__assets_images_char_082_png);
		type.set ("assets/images/char/082.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/083.png", __ASSET__assets_images_char_083_png);
		type.set ("assets/images/char/083.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/084.png", __ASSET__assets_images_char_084_png);
		type.set ("assets/images/char/084.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/085.png", __ASSET__assets_images_char_085_png);
		type.set ("assets/images/char/085.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/086.png", __ASSET__assets_images_char_086_png);
		type.set ("assets/images/char/086.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/087.png", __ASSET__assets_images_char_087_png);
		type.set ("assets/images/char/087.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/088.png", __ASSET__assets_images_char_088_png);
		type.set ("assets/images/char/088.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/089.png", __ASSET__assets_images_char_089_png);
		type.set ("assets/images/char/089.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/090.png", __ASSET__assets_images_char_090_png);
		type.set ("assets/images/char/090.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/091.png", __ASSET__assets_images_char_091_png);
		type.set ("assets/images/char/091.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/092.png", __ASSET__assets_images_char_092_png);
		type.set ("assets/images/char/092.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/093.png", __ASSET__assets_images_char_093_png);
		type.set ("assets/images/char/093.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/094.png", __ASSET__assets_images_char_094_png);
		type.set ("assets/images/char/094.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/095.png", __ASSET__assets_images_char_095_png);
		type.set ("assets/images/char/095.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/096.png", __ASSET__assets_images_char_096_png);
		type.set ("assets/images/char/096.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/097.png", __ASSET__assets_images_char_097_png);
		type.set ("assets/images/char/097.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/098.png", __ASSET__assets_images_char_098_png);
		type.set ("assets/images/char/098.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/099.png", __ASSET__assets_images_char_099_png);
		type.set ("assets/images/char/099.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/100.png", __ASSET__assets_images_char_100_png);
		type.set ("assets/images/char/100.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/101.png", __ASSET__assets_images_char_101_png);
		type.set ("assets/images/char/101.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/102.png", __ASSET__assets_images_char_102_png);
		type.set ("assets/images/char/102.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/103.png", __ASSET__assets_images_char_103_png);
		type.set ("assets/images/char/103.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/104.png", __ASSET__assets_images_char_104_png);
		type.set ("assets/images/char/104.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/105.png", __ASSET__assets_images_char_105_png);
		type.set ("assets/images/char/105.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/106.png", __ASSET__assets_images_char_106_png);
		type.set ("assets/images/char/106.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/107.png", __ASSET__assets_images_char_107_png);
		type.set ("assets/images/char/107.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/108.png", __ASSET__assets_images_char_108_png);
		type.set ("assets/images/char/108.png", AssetType.IMAGE);
		
		className.set ("assets/images/char/main.png", __ASSET__assets_images_char_main_png);
		type.set ("assets/images/char/main.png", AssetType.IMAGE);
		
		className.set ("assets/images/coin.png", __ASSET__assets_images_coin_png);
		type.set ("assets/images/coin.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/j.png", __ASSET__assets_images_enemies_j_png);
		type.set ("assets/images/Enemies/j.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/n.png", __ASSET__assets_images_enemies_n_png);
		type.set ("assets/images/Enemies/n.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/p.png", __ASSET__assets_images_enemies_p_png);
		type.set ("assets/images/Enemies/p.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/s.png", __ASSET__assets_images_enemies_s_png);
		type.set ("assets/images/Enemies/s.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t.png", __ASSET__assets_images_enemies_t_png);
		type.set ("assets/images/Enemies/t.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t.png.txt", __ASSET__assets_images_enemies_t_png_txt);
		type.set ("assets/images/Enemies/t.png.txt", AssetType.TEXT);
		
		className.set ("assets/images/Enemies/t_01.png", __ASSET__assets_images_enemies_t_01_png);
		type.set ("assets/images/Enemies/t_01.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t_02.png", __ASSET__assets_images_enemies_t_02_png);
		type.set ("assets/images/Enemies/t_02.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t_03.png", __ASSET__assets_images_enemies_t_03_png);
		type.set ("assets/images/Enemies/t_03.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t_04.png", __ASSET__assets_images_enemies_t_04_png);
		type.set ("assets/images/Enemies/t_04.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t_05.png", __ASSET__assets_images_enemies_t_05_png);
		type.set ("assets/images/Enemies/t_05.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t_06.png", __ASSET__assets_images_enemies_t_06_png);
		type.set ("assets/images/Enemies/t_06.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t_07.png", __ASSET__assets_images_enemies_t_07_png);
		type.set ("assets/images/Enemies/t_07.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t_08.png", __ASSET__assets_images_enemies_t_08_png);
		type.set ("assets/images/Enemies/t_08.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t_09.png", __ASSET__assets_images_enemies_t_09_png);
		type.set ("assets/images/Enemies/t_09.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t_10.png", __ASSET__assets_images_enemies_t_10_png);
		type.set ("assets/images/Enemies/t_10.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/t_11.png", __ASSET__assets_images_enemies_t_11_png);
		type.set ("assets/images/Enemies/t_11.png", AssetType.IMAGE);
		
		className.set ("assets/images/Enemies/v.png", __ASSET__assets_images_enemies_v_png);
		type.set ("assets/images/Enemies/v.png", AssetType.IMAGE);
		
		className.set ("assets/images/enemybullet.png", __ASSET__assets_images_enemybullet_png);
		type.set ("assets/images/enemybullet.png", AssetType.IMAGE);
		
		className.set ("assets/images/green.jpg", __ASSET__assets_images_green_jpg);
		type.set ("assets/images/green.jpg", AssetType.IMAGE);
		
		className.set ("assets/images/health.png", __ASSET__assets_images_health_png);
		type.set ("assets/images/health.png", AssetType.IMAGE);
		
		className.set ("assets/images/home_rough (lighten).png", __ASSET__assets_images_home_rough__lighten__png);
		type.set ("assets/images/home_rough (lighten).png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a.png", __ASSET__assets_images_new_folder_a_png);
		type.set ("assets/images/New folder/a.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_01.png", __ASSET__assets_images_new_folder_a_01_png);
		type.set ("assets/images/New folder/a_01.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_02.png", __ASSET__assets_images_new_folder_a_02_png);
		type.set ("assets/images/New folder/a_02.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_03.png", __ASSET__assets_images_new_folder_a_03_png);
		type.set ("assets/images/New folder/a_03.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_04.png", __ASSET__assets_images_new_folder_a_04_png);
		type.set ("assets/images/New folder/a_04.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_05.png", __ASSET__assets_images_new_folder_a_05_png);
		type.set ("assets/images/New folder/a_05.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_06.png", __ASSET__assets_images_new_folder_a_06_png);
		type.set ("assets/images/New folder/a_06.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_07.png", __ASSET__assets_images_new_folder_a_07_png);
		type.set ("assets/images/New folder/a_07.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_08.png", __ASSET__assets_images_new_folder_a_08_png);
		type.set ("assets/images/New folder/a_08.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_09.png", __ASSET__assets_images_new_folder_a_09_png);
		type.set ("assets/images/New folder/a_09.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_10.png", __ASSET__assets_images_new_folder_a_10_png);
		type.set ("assets/images/New folder/a_10.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_100.png", __ASSET__assets_images_new_folder_a_100_png);
		type.set ("assets/images/New folder/a_100.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_101.png", __ASSET__assets_images_new_folder_a_101_png);
		type.set ("assets/images/New folder/a_101.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_11.png", __ASSET__assets_images_new_folder_a_11_png);
		type.set ("assets/images/New folder/a_11.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_12.png", __ASSET__assets_images_new_folder_a_12_png);
		type.set ("assets/images/New folder/a_12.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_13.png", __ASSET__assets_images_new_folder_a_13_png);
		type.set ("assets/images/New folder/a_13.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_14.png", __ASSET__assets_images_new_folder_a_14_png);
		type.set ("assets/images/New folder/a_14.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_15.png", __ASSET__assets_images_new_folder_a_15_png);
		type.set ("assets/images/New folder/a_15.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_16.png", __ASSET__assets_images_new_folder_a_16_png);
		type.set ("assets/images/New folder/a_16.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_17.png", __ASSET__assets_images_new_folder_a_17_png);
		type.set ("assets/images/New folder/a_17.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_18.png", __ASSET__assets_images_new_folder_a_18_png);
		type.set ("assets/images/New folder/a_18.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_19.png", __ASSET__assets_images_new_folder_a_19_png);
		type.set ("assets/images/New folder/a_19.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_20.png", __ASSET__assets_images_new_folder_a_20_png);
		type.set ("assets/images/New folder/a_20.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_21.png", __ASSET__assets_images_new_folder_a_21_png);
		type.set ("assets/images/New folder/a_21.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_22.png", __ASSET__assets_images_new_folder_a_22_png);
		type.set ("assets/images/New folder/a_22.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_23.png", __ASSET__assets_images_new_folder_a_23_png);
		type.set ("assets/images/New folder/a_23.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_24.png", __ASSET__assets_images_new_folder_a_24_png);
		type.set ("assets/images/New folder/a_24.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_25.png", __ASSET__assets_images_new_folder_a_25_png);
		type.set ("assets/images/New folder/a_25.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_26.png", __ASSET__assets_images_new_folder_a_26_png);
		type.set ("assets/images/New folder/a_26.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_27.png", __ASSET__assets_images_new_folder_a_27_png);
		type.set ("assets/images/New folder/a_27.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_28.png", __ASSET__assets_images_new_folder_a_28_png);
		type.set ("assets/images/New folder/a_28.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_29.png", __ASSET__assets_images_new_folder_a_29_png);
		type.set ("assets/images/New folder/a_29.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_30.png", __ASSET__assets_images_new_folder_a_30_png);
		type.set ("assets/images/New folder/a_30.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_31.png", __ASSET__assets_images_new_folder_a_31_png);
		type.set ("assets/images/New folder/a_31.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_32.png", __ASSET__assets_images_new_folder_a_32_png);
		type.set ("assets/images/New folder/a_32.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_33.png", __ASSET__assets_images_new_folder_a_33_png);
		type.set ("assets/images/New folder/a_33.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_34.png", __ASSET__assets_images_new_folder_a_34_png);
		type.set ("assets/images/New folder/a_34.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_35.png", __ASSET__assets_images_new_folder_a_35_png);
		type.set ("assets/images/New folder/a_35.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_36.png", __ASSET__assets_images_new_folder_a_36_png);
		type.set ("assets/images/New folder/a_36.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_37.png", __ASSET__assets_images_new_folder_a_37_png);
		type.set ("assets/images/New folder/a_37.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_38.png", __ASSET__assets_images_new_folder_a_38_png);
		type.set ("assets/images/New folder/a_38.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_39.png", __ASSET__assets_images_new_folder_a_39_png);
		type.set ("assets/images/New folder/a_39.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_40.png", __ASSET__assets_images_new_folder_a_40_png);
		type.set ("assets/images/New folder/a_40.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_41.png", __ASSET__assets_images_new_folder_a_41_png);
		type.set ("assets/images/New folder/a_41.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_42.png", __ASSET__assets_images_new_folder_a_42_png);
		type.set ("assets/images/New folder/a_42.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_44.png", __ASSET__assets_images_new_folder_a_44_png);
		type.set ("assets/images/New folder/a_44.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_45.png", __ASSET__assets_images_new_folder_a_45_png);
		type.set ("assets/images/New folder/a_45.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_46.png", __ASSET__assets_images_new_folder_a_46_png);
		type.set ("assets/images/New folder/a_46.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_47.png", __ASSET__assets_images_new_folder_a_47_png);
		type.set ("assets/images/New folder/a_47.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_48.png", __ASSET__assets_images_new_folder_a_48_png);
		type.set ("assets/images/New folder/a_48.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_49.png", __ASSET__assets_images_new_folder_a_49_png);
		type.set ("assets/images/New folder/a_49.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_50.png", __ASSET__assets_images_new_folder_a_50_png);
		type.set ("assets/images/New folder/a_50.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_51.png", __ASSET__assets_images_new_folder_a_51_png);
		type.set ("assets/images/New folder/a_51.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_52.png", __ASSET__assets_images_new_folder_a_52_png);
		type.set ("assets/images/New folder/a_52.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_53.png", __ASSET__assets_images_new_folder_a_53_png);
		type.set ("assets/images/New folder/a_53.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_54.png", __ASSET__assets_images_new_folder_a_54_png);
		type.set ("assets/images/New folder/a_54.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_55.png", __ASSET__assets_images_new_folder_a_55_png);
		type.set ("assets/images/New folder/a_55.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_56.png", __ASSET__assets_images_new_folder_a_56_png);
		type.set ("assets/images/New folder/a_56.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_57.png", __ASSET__assets_images_new_folder_a_57_png);
		type.set ("assets/images/New folder/a_57.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_58.png", __ASSET__assets_images_new_folder_a_58_png);
		type.set ("assets/images/New folder/a_58.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_59.png", __ASSET__assets_images_new_folder_a_59_png);
		type.set ("assets/images/New folder/a_59.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_60.png", __ASSET__assets_images_new_folder_a_60_png);
		type.set ("assets/images/New folder/a_60.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_61.png", __ASSET__assets_images_new_folder_a_61_png);
		type.set ("assets/images/New folder/a_61.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_62.png", __ASSET__assets_images_new_folder_a_62_png);
		type.set ("assets/images/New folder/a_62.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_63.png", __ASSET__assets_images_new_folder_a_63_png);
		type.set ("assets/images/New folder/a_63.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_64.png", __ASSET__assets_images_new_folder_a_64_png);
		type.set ("assets/images/New folder/a_64.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_65.png", __ASSET__assets_images_new_folder_a_65_png);
		type.set ("assets/images/New folder/a_65.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_66.png", __ASSET__assets_images_new_folder_a_66_png);
		type.set ("assets/images/New folder/a_66.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_67.png", __ASSET__assets_images_new_folder_a_67_png);
		type.set ("assets/images/New folder/a_67.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_68.png", __ASSET__assets_images_new_folder_a_68_png);
		type.set ("assets/images/New folder/a_68.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_69.png", __ASSET__assets_images_new_folder_a_69_png);
		type.set ("assets/images/New folder/a_69.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_70.png", __ASSET__assets_images_new_folder_a_70_png);
		type.set ("assets/images/New folder/a_70.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_71.png", __ASSET__assets_images_new_folder_a_71_png);
		type.set ("assets/images/New folder/a_71.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_73.png", __ASSET__assets_images_new_folder_a_73_png);
		type.set ("assets/images/New folder/a_73.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_74.png", __ASSET__assets_images_new_folder_a_74_png);
		type.set ("assets/images/New folder/a_74.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_75.png", __ASSET__assets_images_new_folder_a_75_png);
		type.set ("assets/images/New folder/a_75.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_76.png", __ASSET__assets_images_new_folder_a_76_png);
		type.set ("assets/images/New folder/a_76.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_77.png", __ASSET__assets_images_new_folder_a_77_png);
		type.set ("assets/images/New folder/a_77.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_78.png", __ASSET__assets_images_new_folder_a_78_png);
		type.set ("assets/images/New folder/a_78.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_79.png", __ASSET__assets_images_new_folder_a_79_png);
		type.set ("assets/images/New folder/a_79.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_80.png", __ASSET__assets_images_new_folder_a_80_png);
		type.set ("assets/images/New folder/a_80.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_81.png", __ASSET__assets_images_new_folder_a_81_png);
		type.set ("assets/images/New folder/a_81.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_82.png", __ASSET__assets_images_new_folder_a_82_png);
		type.set ("assets/images/New folder/a_82.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_83.png", __ASSET__assets_images_new_folder_a_83_png);
		type.set ("assets/images/New folder/a_83.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_84.png", __ASSET__assets_images_new_folder_a_84_png);
		type.set ("assets/images/New folder/a_84.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_85.png", __ASSET__assets_images_new_folder_a_85_png);
		type.set ("assets/images/New folder/a_85.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_86.png", __ASSET__assets_images_new_folder_a_86_png);
		type.set ("assets/images/New folder/a_86.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_87.png", __ASSET__assets_images_new_folder_a_87_png);
		type.set ("assets/images/New folder/a_87.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_88.png", __ASSET__assets_images_new_folder_a_88_png);
		type.set ("assets/images/New folder/a_88.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_89.png", __ASSET__assets_images_new_folder_a_89_png);
		type.set ("assets/images/New folder/a_89.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_90.png", __ASSET__assets_images_new_folder_a_90_png);
		type.set ("assets/images/New folder/a_90.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_91.png", __ASSET__assets_images_new_folder_a_91_png);
		type.set ("assets/images/New folder/a_91.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_92.png", __ASSET__assets_images_new_folder_a_92_png);
		type.set ("assets/images/New folder/a_92.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_93.png", __ASSET__assets_images_new_folder_a_93_png);
		type.set ("assets/images/New folder/a_93.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_94.png", __ASSET__assets_images_new_folder_a_94_png);
		type.set ("assets/images/New folder/a_94.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_95.png", __ASSET__assets_images_new_folder_a_95_png);
		type.set ("assets/images/New folder/a_95.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_96.png", __ASSET__assets_images_new_folder_a_96_png);
		type.set ("assets/images/New folder/a_96.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_97.png", __ASSET__assets_images_new_folder_a_97_png);
		type.set ("assets/images/New folder/a_97.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_98.png", __ASSET__assets_images_new_folder_a_98_png);
		type.set ("assets/images/New folder/a_98.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/a_99.png", __ASSET__assets_images_new_folder_a_99_png);
		type.set ("assets/images/New folder/a_99.png", AssetType.IMAGE);
		
		className.set ("assets/images/New folder/b.png", __ASSET__assets_images_new_folder_b_png);
		type.set ("assets/images/New folder/b.png", AssetType.IMAGE);
		
		className.set ("assets/images/player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/player.png", AssetType.IMAGE);
		
		className.set ("assets/images/playerhead.png", __ASSET__assets_images_playerhead_png);
		type.set ("assets/images/playerhead.png", AssetType.IMAGE);
		
		className.set ("assets/images/q.png", __ASSET__assets_images_q_png);
		type.set ("assets/images/q.png", AssetType.IMAGE);
		
		className.set ("assets/images/r.png", __ASSET__assets_images_r_png);
		type.set ("assets/images/r.png", AssetType.IMAGE);
		
		className.set ("assets/images/revolverbullet.png", __ASSET__assets_images_revolverbullet_png);
		type.set ("assets/images/revolverbullet.png", AssetType.IMAGE);
		
		className.set ("assets/images/rifle.png", __ASSET__assets_images_rifle_png);
		type.set ("assets/images/rifle.png", AssetType.IMAGE);
		
		className.set ("assets/images/shield.png", __ASSET__assets_images_shield_png);
		type.set ("assets/images/shield.png", AssetType.IMAGE);
		
		className.set ("assets/images/sword.png", __ASSET__assets_images_sword_png);
		type.set ("assets/images/sword.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles.png", __ASSET__assets_images_tiles_png);
		type.set ("assets/images/tiles.png", AssetType.IMAGE);
		
		className.set ("assets/images/tutorialBG.png", __ASSET__assets_images_tutorialbg_png);
		type.set ("assets/images/tutorialBG.png", AssetType.IMAGE);
		
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/sounds-go-here.txt", __ASSET__assets_sounds_sounds_go_here_txt);
		type.set ("assets/sounds/sounds-go-here.txt", AssetType.TEXT);
		
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

@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_first_level_oel extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_first_map_oep extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tutorial_tmx extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_ballbullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_001_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_002_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_003_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_004_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_005_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_006_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_007_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_008_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_009_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_010_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_011_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_012_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_013_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_014_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_016_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_018_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_019_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_020_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_021_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_022_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_023_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_024_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_025_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_026_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_027_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_028_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_029_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_030_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_031_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_032_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_033_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_034_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_035_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_036_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_037_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_038_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_039_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_040_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_041_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_042_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_043_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_044_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_045_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_046_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_047_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_048_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_049_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_050_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_051_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_052_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_054_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_055_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_056_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_057_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_058_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_059_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_060_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_061_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_062_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_063_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_064_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_065_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_066_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_067_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_068_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_069_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_070_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_071_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_072_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_073_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_074_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_075_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_076_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_077_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_078_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_079_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_080_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_081_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_082_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_083_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_084_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_085_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_086_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_087_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_088_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_089_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_090_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_091_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_092_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_093_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_094_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_095_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_096_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_097_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_098_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_099_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_100_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_101_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_102_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_103_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_104_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_105_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_106_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_107_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_108_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_char_main_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_coin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_j_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_n_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_p_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_s_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_png_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_01_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_02_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_03_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_04_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_05_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_06_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_07_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_08_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_09_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_10_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_t_11_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemies_v_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_enemybullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_green_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_health_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_home_rough__lighten__png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_01_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_02_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_03_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_04_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_05_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_06_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_07_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_08_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_09_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_10_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_100_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_101_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_11_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_12_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_13_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_14_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_15_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_16_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_17_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_18_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_19_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_20_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_21_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_22_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_23_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_24_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_25_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_26_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_27_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_28_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_29_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_30_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_31_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_32_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_33_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_34_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_35_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_36_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_37_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_38_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_39_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_40_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_41_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_42_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_44_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_45_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_46_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_47_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_48_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_49_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_50_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_51_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_52_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_53_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_54_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_55_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_56_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_57_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_58_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_59_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_60_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_61_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_62_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_63_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_64_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_65_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_66_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_67_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_68_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_69_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_70_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_71_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_73_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_74_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_75_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_76_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_77_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_78_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_79_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_80_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_81_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_82_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_83_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_84_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_85_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_86_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_87_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_88_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_89_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_90_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_91_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_92_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_93_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_94_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_95_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_96_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_97_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_98_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_a_99_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_new_folder_b_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_playerhead_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_q_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_r_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_revolverbullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rifle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_shield_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_sword_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_tutorialbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif html5


























































































































































































































































@:keep #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { super (); name = "Nokia Cellphone FC Small"; } } 
@:keep #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { super (); name = "Monsterrat"; } } 




#else



#if (windows || mac || linux || cpp)


@:file("assets/data/data-goes-here.txt") #if display private #end class __ASSET__assets_data_data_goes_here_txt extends lime.utils.Bytes {}
@:file("assets/data/first_level.oel") #if display private #end class __ASSET__assets_data_first_level_oel extends lime.utils.Bytes {}
@:file("assets/data/first_map.oep") #if display private #end class __ASSET__assets_data_first_map_oep extends lime.utils.Bytes {}
@:file("assets/data/tutorial.tmx") #if display private #end class __ASSET__assets_data_tutorial_tmx extends lime.utils.Bytes {}
@:image("assets/images/ballbullet.png") #if display private #end class __ASSET__assets_images_ballbullet_png extends lime.graphics.Image {}
@:image("assets/images/char/001.png") #if display private #end class __ASSET__assets_images_char_001_png extends lime.graphics.Image {}
@:image("assets/images/char/002.png") #if display private #end class __ASSET__assets_images_char_002_png extends lime.graphics.Image {}
@:image("assets/images/char/003.png") #if display private #end class __ASSET__assets_images_char_003_png extends lime.graphics.Image {}
@:image("assets/images/char/004.png") #if display private #end class __ASSET__assets_images_char_004_png extends lime.graphics.Image {}
@:image("assets/images/char/005.png") #if display private #end class __ASSET__assets_images_char_005_png extends lime.graphics.Image {}
@:image("assets/images/char/006.png") #if display private #end class __ASSET__assets_images_char_006_png extends lime.graphics.Image {}
@:image("assets/images/char/007.png") #if display private #end class __ASSET__assets_images_char_007_png extends lime.graphics.Image {}
@:image("assets/images/char/008.png") #if display private #end class __ASSET__assets_images_char_008_png extends lime.graphics.Image {}
@:image("assets/images/char/009.png") #if display private #end class __ASSET__assets_images_char_009_png extends lime.graphics.Image {}
@:image("assets/images/char/010.png") #if display private #end class __ASSET__assets_images_char_010_png extends lime.graphics.Image {}
@:image("assets/images/char/011.png") #if display private #end class __ASSET__assets_images_char_011_png extends lime.graphics.Image {}
@:image("assets/images/char/012.png") #if display private #end class __ASSET__assets_images_char_012_png extends lime.graphics.Image {}
@:image("assets/images/char/013.png") #if display private #end class __ASSET__assets_images_char_013_png extends lime.graphics.Image {}
@:image("assets/images/char/014.png") #if display private #end class __ASSET__assets_images_char_014_png extends lime.graphics.Image {}
@:image("assets/images/char/016.png") #if display private #end class __ASSET__assets_images_char_016_png extends lime.graphics.Image {}
@:image("assets/images/char/018.png") #if display private #end class __ASSET__assets_images_char_018_png extends lime.graphics.Image {}
@:image("assets/images/char/019.png") #if display private #end class __ASSET__assets_images_char_019_png extends lime.graphics.Image {}
@:image("assets/images/char/020.png") #if display private #end class __ASSET__assets_images_char_020_png extends lime.graphics.Image {}
@:image("assets/images/char/021.png") #if display private #end class __ASSET__assets_images_char_021_png extends lime.graphics.Image {}
@:image("assets/images/char/022.png") #if display private #end class __ASSET__assets_images_char_022_png extends lime.graphics.Image {}
@:image("assets/images/char/023.png") #if display private #end class __ASSET__assets_images_char_023_png extends lime.graphics.Image {}
@:image("assets/images/char/024.png") #if display private #end class __ASSET__assets_images_char_024_png extends lime.graphics.Image {}
@:image("assets/images/char/025.png") #if display private #end class __ASSET__assets_images_char_025_png extends lime.graphics.Image {}
@:image("assets/images/char/026.png") #if display private #end class __ASSET__assets_images_char_026_png extends lime.graphics.Image {}
@:image("assets/images/char/027.png") #if display private #end class __ASSET__assets_images_char_027_png extends lime.graphics.Image {}
@:image("assets/images/char/028.png") #if display private #end class __ASSET__assets_images_char_028_png extends lime.graphics.Image {}
@:image("assets/images/char/029.png") #if display private #end class __ASSET__assets_images_char_029_png extends lime.graphics.Image {}
@:image("assets/images/char/030.png") #if display private #end class __ASSET__assets_images_char_030_png extends lime.graphics.Image {}
@:image("assets/images/char/031.png") #if display private #end class __ASSET__assets_images_char_031_png extends lime.graphics.Image {}
@:image("assets/images/char/032.png") #if display private #end class __ASSET__assets_images_char_032_png extends lime.graphics.Image {}
@:image("assets/images/char/033.png") #if display private #end class __ASSET__assets_images_char_033_png extends lime.graphics.Image {}
@:image("assets/images/char/034.png") #if display private #end class __ASSET__assets_images_char_034_png extends lime.graphics.Image {}
@:image("assets/images/char/035.png") #if display private #end class __ASSET__assets_images_char_035_png extends lime.graphics.Image {}
@:image("assets/images/char/036.png") #if display private #end class __ASSET__assets_images_char_036_png extends lime.graphics.Image {}
@:image("assets/images/char/037.png") #if display private #end class __ASSET__assets_images_char_037_png extends lime.graphics.Image {}
@:image("assets/images/char/038.png") #if display private #end class __ASSET__assets_images_char_038_png extends lime.graphics.Image {}
@:image("assets/images/char/039.png") #if display private #end class __ASSET__assets_images_char_039_png extends lime.graphics.Image {}
@:image("assets/images/char/040.png") #if display private #end class __ASSET__assets_images_char_040_png extends lime.graphics.Image {}
@:image("assets/images/char/041.png") #if display private #end class __ASSET__assets_images_char_041_png extends lime.graphics.Image {}
@:image("assets/images/char/042.png") #if display private #end class __ASSET__assets_images_char_042_png extends lime.graphics.Image {}
@:image("assets/images/char/043.png") #if display private #end class __ASSET__assets_images_char_043_png extends lime.graphics.Image {}
@:image("assets/images/char/044.png") #if display private #end class __ASSET__assets_images_char_044_png extends lime.graphics.Image {}
@:image("assets/images/char/045.png") #if display private #end class __ASSET__assets_images_char_045_png extends lime.graphics.Image {}
@:image("assets/images/char/046.png") #if display private #end class __ASSET__assets_images_char_046_png extends lime.graphics.Image {}
@:image("assets/images/char/047.png") #if display private #end class __ASSET__assets_images_char_047_png extends lime.graphics.Image {}
@:image("assets/images/char/048.png") #if display private #end class __ASSET__assets_images_char_048_png extends lime.graphics.Image {}
@:image("assets/images/char/049.png") #if display private #end class __ASSET__assets_images_char_049_png extends lime.graphics.Image {}
@:image("assets/images/char/050.png") #if display private #end class __ASSET__assets_images_char_050_png extends lime.graphics.Image {}
@:image("assets/images/char/051.png") #if display private #end class __ASSET__assets_images_char_051_png extends lime.graphics.Image {}
@:image("assets/images/char/052.png") #if display private #end class __ASSET__assets_images_char_052_png extends lime.graphics.Image {}
@:image("assets/images/char/054.png") #if display private #end class __ASSET__assets_images_char_054_png extends lime.graphics.Image {}
@:image("assets/images/char/055.png") #if display private #end class __ASSET__assets_images_char_055_png extends lime.graphics.Image {}
@:image("assets/images/char/056.png") #if display private #end class __ASSET__assets_images_char_056_png extends lime.graphics.Image {}
@:image("assets/images/char/057.png") #if display private #end class __ASSET__assets_images_char_057_png extends lime.graphics.Image {}
@:image("assets/images/char/058.png") #if display private #end class __ASSET__assets_images_char_058_png extends lime.graphics.Image {}
@:image("assets/images/char/059.png") #if display private #end class __ASSET__assets_images_char_059_png extends lime.graphics.Image {}
@:image("assets/images/char/060.png") #if display private #end class __ASSET__assets_images_char_060_png extends lime.graphics.Image {}
@:image("assets/images/char/061.png") #if display private #end class __ASSET__assets_images_char_061_png extends lime.graphics.Image {}
@:image("assets/images/char/062.png") #if display private #end class __ASSET__assets_images_char_062_png extends lime.graphics.Image {}
@:image("assets/images/char/063.png") #if display private #end class __ASSET__assets_images_char_063_png extends lime.graphics.Image {}
@:image("assets/images/char/064.png") #if display private #end class __ASSET__assets_images_char_064_png extends lime.graphics.Image {}
@:image("assets/images/char/065.png") #if display private #end class __ASSET__assets_images_char_065_png extends lime.graphics.Image {}
@:image("assets/images/char/066.png") #if display private #end class __ASSET__assets_images_char_066_png extends lime.graphics.Image {}
@:image("assets/images/char/067.png") #if display private #end class __ASSET__assets_images_char_067_png extends lime.graphics.Image {}
@:image("assets/images/char/068.png") #if display private #end class __ASSET__assets_images_char_068_png extends lime.graphics.Image {}
@:image("assets/images/char/069.png") #if display private #end class __ASSET__assets_images_char_069_png extends lime.graphics.Image {}
@:image("assets/images/char/070.png") #if display private #end class __ASSET__assets_images_char_070_png extends lime.graphics.Image {}
@:image("assets/images/char/071.png") #if display private #end class __ASSET__assets_images_char_071_png extends lime.graphics.Image {}
@:image("assets/images/char/072.png") #if display private #end class __ASSET__assets_images_char_072_png extends lime.graphics.Image {}
@:image("assets/images/char/073.png") #if display private #end class __ASSET__assets_images_char_073_png extends lime.graphics.Image {}
@:image("assets/images/char/074.png") #if display private #end class __ASSET__assets_images_char_074_png extends lime.graphics.Image {}
@:image("assets/images/char/075.png") #if display private #end class __ASSET__assets_images_char_075_png extends lime.graphics.Image {}
@:image("assets/images/char/076.png") #if display private #end class __ASSET__assets_images_char_076_png extends lime.graphics.Image {}
@:image("assets/images/char/077.png") #if display private #end class __ASSET__assets_images_char_077_png extends lime.graphics.Image {}
@:image("assets/images/char/078.png") #if display private #end class __ASSET__assets_images_char_078_png extends lime.graphics.Image {}
@:image("assets/images/char/079.png") #if display private #end class __ASSET__assets_images_char_079_png extends lime.graphics.Image {}
@:image("assets/images/char/080.png") #if display private #end class __ASSET__assets_images_char_080_png extends lime.graphics.Image {}
@:image("assets/images/char/081.png") #if display private #end class __ASSET__assets_images_char_081_png extends lime.graphics.Image {}
@:image("assets/images/char/082.png") #if display private #end class __ASSET__assets_images_char_082_png extends lime.graphics.Image {}
@:image("assets/images/char/083.png") #if display private #end class __ASSET__assets_images_char_083_png extends lime.graphics.Image {}
@:image("assets/images/char/084.png") #if display private #end class __ASSET__assets_images_char_084_png extends lime.graphics.Image {}
@:image("assets/images/char/085.png") #if display private #end class __ASSET__assets_images_char_085_png extends lime.graphics.Image {}
@:image("assets/images/char/086.png") #if display private #end class __ASSET__assets_images_char_086_png extends lime.graphics.Image {}
@:image("assets/images/char/087.png") #if display private #end class __ASSET__assets_images_char_087_png extends lime.graphics.Image {}
@:image("assets/images/char/088.png") #if display private #end class __ASSET__assets_images_char_088_png extends lime.graphics.Image {}
@:image("assets/images/char/089.png") #if display private #end class __ASSET__assets_images_char_089_png extends lime.graphics.Image {}
@:image("assets/images/char/090.png") #if display private #end class __ASSET__assets_images_char_090_png extends lime.graphics.Image {}
@:image("assets/images/char/091.png") #if display private #end class __ASSET__assets_images_char_091_png extends lime.graphics.Image {}
@:image("assets/images/char/092.png") #if display private #end class __ASSET__assets_images_char_092_png extends lime.graphics.Image {}
@:image("assets/images/char/093.png") #if display private #end class __ASSET__assets_images_char_093_png extends lime.graphics.Image {}
@:image("assets/images/char/094.png") #if display private #end class __ASSET__assets_images_char_094_png extends lime.graphics.Image {}
@:image("assets/images/char/095.png") #if display private #end class __ASSET__assets_images_char_095_png extends lime.graphics.Image {}
@:image("assets/images/char/096.png") #if display private #end class __ASSET__assets_images_char_096_png extends lime.graphics.Image {}
@:image("assets/images/char/097.png") #if display private #end class __ASSET__assets_images_char_097_png extends lime.graphics.Image {}
@:image("assets/images/char/098.png") #if display private #end class __ASSET__assets_images_char_098_png extends lime.graphics.Image {}
@:image("assets/images/char/099.png") #if display private #end class __ASSET__assets_images_char_099_png extends lime.graphics.Image {}
@:image("assets/images/char/100.png") #if display private #end class __ASSET__assets_images_char_100_png extends lime.graphics.Image {}
@:image("assets/images/char/101.png") #if display private #end class __ASSET__assets_images_char_101_png extends lime.graphics.Image {}
@:image("assets/images/char/102.png") #if display private #end class __ASSET__assets_images_char_102_png extends lime.graphics.Image {}
@:image("assets/images/char/103.png") #if display private #end class __ASSET__assets_images_char_103_png extends lime.graphics.Image {}
@:image("assets/images/char/104.png") #if display private #end class __ASSET__assets_images_char_104_png extends lime.graphics.Image {}
@:image("assets/images/char/105.png") #if display private #end class __ASSET__assets_images_char_105_png extends lime.graphics.Image {}
@:image("assets/images/char/106.png") #if display private #end class __ASSET__assets_images_char_106_png extends lime.graphics.Image {}
@:image("assets/images/char/107.png") #if display private #end class __ASSET__assets_images_char_107_png extends lime.graphics.Image {}
@:image("assets/images/char/108.png") #if display private #end class __ASSET__assets_images_char_108_png extends lime.graphics.Image {}
@:image("assets/images/char/main.png") #if display private #end class __ASSET__assets_images_char_main_png extends lime.graphics.Image {}
@:image("assets/images/coin.png") #if display private #end class __ASSET__assets_images_coin_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/j.png") #if display private #end class __ASSET__assets_images_enemies_j_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/n.png") #if display private #end class __ASSET__assets_images_enemies_n_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/p.png") #if display private #end class __ASSET__assets_images_enemies_p_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/s.png") #if display private #end class __ASSET__assets_images_enemies_s_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t.png") #if display private #end class __ASSET__assets_images_enemies_t_png extends lime.graphics.Image {}
@:file("assets/images/Enemies/t.png.txt") #if display private #end class __ASSET__assets_images_enemies_t_png_txt extends lime.utils.Bytes {}
@:image("assets/images/Enemies/t_01.png") #if display private #end class __ASSET__assets_images_enemies_t_01_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t_02.png") #if display private #end class __ASSET__assets_images_enemies_t_02_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t_03.png") #if display private #end class __ASSET__assets_images_enemies_t_03_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t_04.png") #if display private #end class __ASSET__assets_images_enemies_t_04_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t_05.png") #if display private #end class __ASSET__assets_images_enemies_t_05_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t_06.png") #if display private #end class __ASSET__assets_images_enemies_t_06_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t_07.png") #if display private #end class __ASSET__assets_images_enemies_t_07_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t_08.png") #if display private #end class __ASSET__assets_images_enemies_t_08_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t_09.png") #if display private #end class __ASSET__assets_images_enemies_t_09_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t_10.png") #if display private #end class __ASSET__assets_images_enemies_t_10_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/t_11.png") #if display private #end class __ASSET__assets_images_enemies_t_11_png extends lime.graphics.Image {}
@:image("assets/images/Enemies/v.png") #if display private #end class __ASSET__assets_images_enemies_v_png extends lime.graphics.Image {}
@:image("assets/images/enemybullet.png") #if display private #end class __ASSET__assets_images_enemybullet_png extends lime.graphics.Image {}
@:image("assets/images/green.jpg") #if display private #end class __ASSET__assets_images_green_jpg extends lime.graphics.Image {}
@:image("assets/images/health.png") #if display private #end class __ASSET__assets_images_health_png extends lime.graphics.Image {}
@:image("assets/images/home_rough (lighten).png") #if display private #end class __ASSET__assets_images_home_rough__lighten__png extends lime.graphics.Image {}
@:image("assets/images/New folder/a.png") #if display private #end class __ASSET__assets_images_new_folder_a_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_01.png") #if display private #end class __ASSET__assets_images_new_folder_a_01_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_02.png") #if display private #end class __ASSET__assets_images_new_folder_a_02_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_03.png") #if display private #end class __ASSET__assets_images_new_folder_a_03_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_04.png") #if display private #end class __ASSET__assets_images_new_folder_a_04_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_05.png") #if display private #end class __ASSET__assets_images_new_folder_a_05_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_06.png") #if display private #end class __ASSET__assets_images_new_folder_a_06_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_07.png") #if display private #end class __ASSET__assets_images_new_folder_a_07_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_08.png") #if display private #end class __ASSET__assets_images_new_folder_a_08_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_09.png") #if display private #end class __ASSET__assets_images_new_folder_a_09_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_10.png") #if display private #end class __ASSET__assets_images_new_folder_a_10_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_100.png") #if display private #end class __ASSET__assets_images_new_folder_a_100_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_101.png") #if display private #end class __ASSET__assets_images_new_folder_a_101_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_11.png") #if display private #end class __ASSET__assets_images_new_folder_a_11_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_12.png") #if display private #end class __ASSET__assets_images_new_folder_a_12_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_13.png") #if display private #end class __ASSET__assets_images_new_folder_a_13_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_14.png") #if display private #end class __ASSET__assets_images_new_folder_a_14_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_15.png") #if display private #end class __ASSET__assets_images_new_folder_a_15_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_16.png") #if display private #end class __ASSET__assets_images_new_folder_a_16_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_17.png") #if display private #end class __ASSET__assets_images_new_folder_a_17_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_18.png") #if display private #end class __ASSET__assets_images_new_folder_a_18_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_19.png") #if display private #end class __ASSET__assets_images_new_folder_a_19_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_20.png") #if display private #end class __ASSET__assets_images_new_folder_a_20_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_21.png") #if display private #end class __ASSET__assets_images_new_folder_a_21_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_22.png") #if display private #end class __ASSET__assets_images_new_folder_a_22_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_23.png") #if display private #end class __ASSET__assets_images_new_folder_a_23_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_24.png") #if display private #end class __ASSET__assets_images_new_folder_a_24_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_25.png") #if display private #end class __ASSET__assets_images_new_folder_a_25_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_26.png") #if display private #end class __ASSET__assets_images_new_folder_a_26_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_27.png") #if display private #end class __ASSET__assets_images_new_folder_a_27_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_28.png") #if display private #end class __ASSET__assets_images_new_folder_a_28_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_29.png") #if display private #end class __ASSET__assets_images_new_folder_a_29_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_30.png") #if display private #end class __ASSET__assets_images_new_folder_a_30_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_31.png") #if display private #end class __ASSET__assets_images_new_folder_a_31_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_32.png") #if display private #end class __ASSET__assets_images_new_folder_a_32_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_33.png") #if display private #end class __ASSET__assets_images_new_folder_a_33_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_34.png") #if display private #end class __ASSET__assets_images_new_folder_a_34_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_35.png") #if display private #end class __ASSET__assets_images_new_folder_a_35_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_36.png") #if display private #end class __ASSET__assets_images_new_folder_a_36_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_37.png") #if display private #end class __ASSET__assets_images_new_folder_a_37_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_38.png") #if display private #end class __ASSET__assets_images_new_folder_a_38_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_39.png") #if display private #end class __ASSET__assets_images_new_folder_a_39_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_40.png") #if display private #end class __ASSET__assets_images_new_folder_a_40_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_41.png") #if display private #end class __ASSET__assets_images_new_folder_a_41_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_42.png") #if display private #end class __ASSET__assets_images_new_folder_a_42_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_44.png") #if display private #end class __ASSET__assets_images_new_folder_a_44_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_45.png") #if display private #end class __ASSET__assets_images_new_folder_a_45_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_46.png") #if display private #end class __ASSET__assets_images_new_folder_a_46_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_47.png") #if display private #end class __ASSET__assets_images_new_folder_a_47_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_48.png") #if display private #end class __ASSET__assets_images_new_folder_a_48_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_49.png") #if display private #end class __ASSET__assets_images_new_folder_a_49_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_50.png") #if display private #end class __ASSET__assets_images_new_folder_a_50_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_51.png") #if display private #end class __ASSET__assets_images_new_folder_a_51_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_52.png") #if display private #end class __ASSET__assets_images_new_folder_a_52_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_53.png") #if display private #end class __ASSET__assets_images_new_folder_a_53_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_54.png") #if display private #end class __ASSET__assets_images_new_folder_a_54_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_55.png") #if display private #end class __ASSET__assets_images_new_folder_a_55_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_56.png") #if display private #end class __ASSET__assets_images_new_folder_a_56_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_57.png") #if display private #end class __ASSET__assets_images_new_folder_a_57_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_58.png") #if display private #end class __ASSET__assets_images_new_folder_a_58_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_59.png") #if display private #end class __ASSET__assets_images_new_folder_a_59_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_60.png") #if display private #end class __ASSET__assets_images_new_folder_a_60_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_61.png") #if display private #end class __ASSET__assets_images_new_folder_a_61_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_62.png") #if display private #end class __ASSET__assets_images_new_folder_a_62_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_63.png") #if display private #end class __ASSET__assets_images_new_folder_a_63_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_64.png") #if display private #end class __ASSET__assets_images_new_folder_a_64_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_65.png") #if display private #end class __ASSET__assets_images_new_folder_a_65_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_66.png") #if display private #end class __ASSET__assets_images_new_folder_a_66_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_67.png") #if display private #end class __ASSET__assets_images_new_folder_a_67_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_68.png") #if display private #end class __ASSET__assets_images_new_folder_a_68_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_69.png") #if display private #end class __ASSET__assets_images_new_folder_a_69_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_70.png") #if display private #end class __ASSET__assets_images_new_folder_a_70_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_71.png") #if display private #end class __ASSET__assets_images_new_folder_a_71_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_73.png") #if display private #end class __ASSET__assets_images_new_folder_a_73_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_74.png") #if display private #end class __ASSET__assets_images_new_folder_a_74_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_75.png") #if display private #end class __ASSET__assets_images_new_folder_a_75_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_76.png") #if display private #end class __ASSET__assets_images_new_folder_a_76_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_77.png") #if display private #end class __ASSET__assets_images_new_folder_a_77_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_78.png") #if display private #end class __ASSET__assets_images_new_folder_a_78_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_79.png") #if display private #end class __ASSET__assets_images_new_folder_a_79_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_80.png") #if display private #end class __ASSET__assets_images_new_folder_a_80_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_81.png") #if display private #end class __ASSET__assets_images_new_folder_a_81_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_82.png") #if display private #end class __ASSET__assets_images_new_folder_a_82_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_83.png") #if display private #end class __ASSET__assets_images_new_folder_a_83_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_84.png") #if display private #end class __ASSET__assets_images_new_folder_a_84_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_85.png") #if display private #end class __ASSET__assets_images_new_folder_a_85_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_86.png") #if display private #end class __ASSET__assets_images_new_folder_a_86_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_87.png") #if display private #end class __ASSET__assets_images_new_folder_a_87_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_88.png") #if display private #end class __ASSET__assets_images_new_folder_a_88_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_89.png") #if display private #end class __ASSET__assets_images_new_folder_a_89_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_90.png") #if display private #end class __ASSET__assets_images_new_folder_a_90_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_91.png") #if display private #end class __ASSET__assets_images_new_folder_a_91_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_92.png") #if display private #end class __ASSET__assets_images_new_folder_a_92_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_93.png") #if display private #end class __ASSET__assets_images_new_folder_a_93_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_94.png") #if display private #end class __ASSET__assets_images_new_folder_a_94_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_95.png") #if display private #end class __ASSET__assets_images_new_folder_a_95_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_96.png") #if display private #end class __ASSET__assets_images_new_folder_a_96_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_97.png") #if display private #end class __ASSET__assets_images_new_folder_a_97_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_98.png") #if display private #end class __ASSET__assets_images_new_folder_a_98_png extends lime.graphics.Image {}
@:image("assets/images/New folder/a_99.png") #if display private #end class __ASSET__assets_images_new_folder_a_99_png extends lime.graphics.Image {}
@:image("assets/images/New folder/b.png") #if display private #end class __ASSET__assets_images_new_folder_b_png extends lime.graphics.Image {}
@:image("assets/images/player.png") #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:image("assets/images/playerhead.png") #if display private #end class __ASSET__assets_images_playerhead_png extends lime.graphics.Image {}
@:image("assets/images/q.png") #if display private #end class __ASSET__assets_images_q_png extends lime.graphics.Image {}
@:image("assets/images/r.png") #if display private #end class __ASSET__assets_images_r_png extends lime.graphics.Image {}
@:image("assets/images/revolverbullet.png") #if display private #end class __ASSET__assets_images_revolverbullet_png extends lime.graphics.Image {}
@:image("assets/images/rifle.png") #if display private #end class __ASSET__assets_images_rifle_png extends lime.graphics.Image {}
@:image("assets/images/shield.png") #if display private #end class __ASSET__assets_images_shield_png extends lime.graphics.Image {}
@:image("assets/images/sword.png") #if display private #end class __ASSET__assets_images_sword_png extends lime.graphics.Image {}
@:image("assets/images/tiles.png") #if display private #end class __ASSET__assets_images_tiles_png extends lime.graphics.Image {}
@:image("assets/images/tutorialBG.png") #if display private #end class __ASSET__assets_images_tutorialbg_png extends lime.graphics.Image {}
@:file("assets/music/music-goes-here.txt") #if display private #end class __ASSET__assets_music_music_goes_here_txt extends lime.utils.Bytes {}
@:file("assets/sounds/sounds-go-here.txt") #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends lime.utils.Bytes {}
@:file("/Users/NEC/Desktop/CSE484/full-mecha-jacket/flixel/4,2,1/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends lime.utils.Bytes {}
@:file("/Users/NEC/Desktop/CSE484/full-mecha-jacket/flixel/4,2,1/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends lime.utils.Bytes {}
@:font("/Users/NEC/Desktop/CSE484/full-mecha-jacket/flixel/4,2,1/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("/Users/NEC/Desktop/CSE484/full-mecha-jacket/flixel/4,2,1/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:image("/Users/NEC/Desktop/CSE484/full-mecha-jacket/flixel/4,2,1/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:image("/Users/NEC/Desktop/CSE484/full-mecha-jacket/flixel/4,2,1/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}



#end
#end

#if (openfl && !flash)
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_monsterrat_ttf (); src = font.src; name = font.name; super (); }}

#end

#end