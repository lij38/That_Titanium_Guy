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
    private var _name:FlxText;

    public function new(_smallboss:Enemy)
     {
         super();

         //health bar
        _healthbar = new FlxBar(120, 550, 600, 20, _smallboss, "health", 0, _smallboss.health);
        _healthbar.createFilledBar(FlxColor.TRANSPARENT, FlxColor.PURPLE, true, FlxColor.BLACK);

         //add(_sprHealth);
         add(_healthbar);
         
         //name
         _name = new FlxText(280, 500, 0);
         _name.text = _smallboss.name;
         _name.setFormat(AssetPaths.FONT, 35);
         add(_name);

         forEach(function(spr:FlxSprite)
         {
             spr.scrollFactor.set(0, 0);
         });
     }
}