package enemies;
 import flixel.FlxBasic;
 import flixel.FlxG;
 import flixel.FlxSprite;
 import flixel.group.FlxGroup.FlxTypedGroup;
 import flixel.text.FlxText;
 import flixel.util.FlxColor;
 import flixel.ui.FlxBar;
 using flixel.util.FlxSpriteUtil;

class Boss1HUD extends FlxTypedGroup<FlxSprite>
{
    private var _sprHealth:FlxSprite;
    private var _healthbar:FlxBar;

    public function new(_smallboss:Boss1)
     {
         super();

         //health icon
         //_sprHealth = new FlxSprite(320, 4, AssetPaths.health__png);

         //health bar
        _healthbar = new FlxBar(120, 500, 600, 15, _smallboss, "health", 0, _smallboss.health);
        _healthbar.createFilledBar(FlxColor.TRANSPARENT, FlxColor.BLUE, true, FlxColor.BLACK);

         //add(_sprHealth);
         add(_healthbar);
         
         forEach(function(spr:FlxSprite)
         {
             spr.scrollFactor.set(0, 0);
         });
     }

/*
     public function updateHUD(jAmmo:Int=0, kAmmo:Int=0, jReloading:Bool, kReloading:Bool, jName:String, kName:String):Void
     {  
        if(jName != "") {
            _jWeapon.loadGraphic(AssetPaths.IMAGE + jName + ".png");
        } else {
            _jWeapon.makeGraphic(1, 1, FlxColor.TRANSPARENT);
        }
        if(kName != "") {
            _kWeapon.loadGraphic(AssetPaths.IMAGE + kName + ".png");
        } else {
            _kWeapon.makeGraphic(1, 1, FlxColor.TRANSPARENT);
        }
        if(jReloading) {
            _txtjAmmo.text = "RELOADING";
            _txtjAmmo.size = 16;
        } else if(jAmmo < 0) {
            _txtjAmmo.text = "";
            _txtjAmmo.size = 24;
        } else {
            _txtjAmmo.text = Std.string(jAmmo);
            _txtjAmmo.size = 24;
        }
        if(kReloading) {
            _txtkAmmo.text = "RELOADING";
            _txtkAmmo.size = 16;
        } else if(kAmmo < 0) {
            _txtkAmmo.text = "";
            _txtkAmmo.size = 24;
        } else {
            _txtkAmmo.text = Std.string(kAmmo);
            _txtkAmmo.size = 24;
        }
     }
     */
}