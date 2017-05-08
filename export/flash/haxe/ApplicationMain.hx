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
		
		
		urls.push ("assets/data/data-goes-here.txt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/first_level.oel");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/first_map.oep");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/data/tutorial.tmx");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/images/ballbullet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/001.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/002.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/003.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/004.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/005.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/006.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/007.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/008.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/009.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/010.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/011.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/012.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/013.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/014.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/016.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/018.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/019.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/020.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/021.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/022.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/023.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/024.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/025.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/026.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/027.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/028.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/029.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/030.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/031.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/032.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/033.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/034.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/035.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/036.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/037.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/038.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/039.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/040.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/041.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/042.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/043.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/044.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/045.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/046.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/047.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/048.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/049.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/050.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/051.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/052.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/054.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/055.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/056.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/057.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/058.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/059.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/060.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/061.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/062.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/063.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/064.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/065.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/066.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/067.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/068.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/069.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/070.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/071.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/072.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/073.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/074.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/075.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/076.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/077.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/078.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/079.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/080.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/081.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/082.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/083.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/084.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/085.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/086.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/087.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/088.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/089.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/090.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/091.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/092.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/093.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/094.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/095.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/096.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/097.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/098.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/099.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/100.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/101.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/102.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/103.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/104.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/105.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/106.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/107.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/108.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/char/main.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/coin.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/j.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/n.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/p.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/s.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t.png.txt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/images/Enemies/t_01.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t_02.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t_03.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t_04.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t_05.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t_06.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t_07.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t_08.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t_09.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t_10.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/t_11.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/Enemies/v.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/enemybullet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/green.jpg");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/health.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/home_rough (lighten).png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_01.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_02.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_03.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_04.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_05.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_06.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_07.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_08.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_09.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_10.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_100.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_101.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_11.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_12.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_13.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_14.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_15.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_16.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_17.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_18.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_19.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_20.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_21.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_22.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_23.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_24.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_25.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_26.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_27.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_28.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_29.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_30.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_31.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_32.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_33.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_34.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_35.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_36.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_37.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_38.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_39.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_40.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_41.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_42.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_44.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_45.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_46.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_47.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_48.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_49.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_50.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_51.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_52.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_53.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_54.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_55.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_56.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_57.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_58.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_59.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_60.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_61.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_62.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_63.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_64.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_65.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_66.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_67.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_68.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_69.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_70.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_71.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_73.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_74.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_75.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_76.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_77.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_78.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_79.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_80.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_81.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_82.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_83.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_84.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_85.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_86.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_87.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_88.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_89.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_90.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_91.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_92.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_93.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_94.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_95.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_96.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_97.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_98.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/a_99.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/New folder/b.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/player.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/playerhead.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/q.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/r.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/revolverbullet.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/rifle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/shield.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/sword.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/images/tutorialBG.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("assets/music/music-goes-here.txt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
		urls.push ("assets/sounds/sounds-go-here.txt");
		types.push (lime.Assets.AssetType.TEXT);
		
		
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
			
			build: "3",
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
