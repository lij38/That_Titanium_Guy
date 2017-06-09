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
    private var timer:FlxText;
    private var _boss:Enemy;

    public function new(boss:Enemy)
     {
         super();

         _boss = boss;
         //health bar
        _healthbar = new FlxBar(120, 550, 600, 20, boss, "health", 0, boss.health);
        _healthbar.createFilledBar(FlxColor.TRANSPARENT, FlxColor.PURPLE, true, FlxColor.BLACK);

         //add(_sprHealth);
         add(_healthbar);
         
         //name
         _name = new FlxText(280, 500, 0);
         _name.text = boss.name;
         _name.setFormat(AssetPaths.FONT, 35);
         add(_name);

         //count down timer
         if(boss.type == BOSS3) {
            _name.x = 200;
            timer = new FlxText(360, 50, 0, "60", 50);
            timer.setFormat(AssetPaths.FONT, timer.size);
            add(timer);
         }
         forEach(function(spr:FlxSprite)
         {
             spr.scrollFactor.set(0, 0);
         });
     }

     public function updateTimer():Void {
         timer.text = Std.string(Math.fround(cast(_boss, FinalBoss).getTime()));
         /*if(timer.text.length > 2) {
             timer.text = timer.text.substring(0, 2);
         }*/
     }
}