package ;
 import flixel.FlxBasic;
 import flixel.FlxG;
 import flixel.FlxSprite;
 import flixel.group.FlxGroup.FlxTypedGroup;
 import flixel.text.FlxText;
 import flixel.util.FlxColor;
 import flixel.ui.FlxBar;
 using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
    private var _sprHealth:FlxSprite;
    private var _sprHead:FlxSprite;
    private var _txtjAmmo:FlxText;
    private var _txtkAmmo:FlxText;
    private var _healthbar:FlxBar;
    private var _jWeapon:FlxSprite;
    private var _kWeapon:FlxSprite;

    public function new(_player:Player)
     {
         super();
         
        //ammo
        _txtjAmmo = new FlxText(55, FlxG.height - 30, 0, "", 24);
        _txtkAmmo = new FlxText(FlxG.width - 110, FlxG.height - 30, 0, "", 24);

         //player head icon
         _sprHead = new FlxSprite(4, 2, AssetPaths.playerhead__png);

         //health icon
         _sprHealth = new FlxSprite(80, 4, AssetPaths.health__png);

         //health bar
        _healthbar = new FlxBar(120, 4, 200, 15, _player, "health");
        _healthbar.createFilledBar(FlxColor.TRANSPARENT, FlxColor.RED, true, FlxColor.BLACK);

        //weapons
        _jWeapon = new FlxSprite(50, FlxG.height - 80);
        _kWeapon = new FlxSprite(_txtkAmmo.x - 5, FlxG.height - 80);

         add(_sprHead);
         add(_sprHealth);
         add(_txtjAmmo);
         add(_txtkAmmo);
         add(_healthbar);
         add(_jWeapon);
         add(_kWeapon);
         forEach(function(spr:FlxSprite)
         {
             spr.scrollFactor.set(0, 0);
         });
     }

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
}