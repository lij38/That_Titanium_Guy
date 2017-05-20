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
}