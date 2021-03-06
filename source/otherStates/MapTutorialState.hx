package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import levelStates.*;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.FlxG;
import flixel.addons.editors.tiled.TiledMap;
import flixel.FlxSprite;

class MapTutorialState extends FlxState
{
    private var _map:TiledMap;
    private var _bg:FlxTilemap;
    private var _tutorial:FlxButton;
    private var _level1:FlxButton;
    private var _level1boss:FlxButton;
    private var _level2:FlxButton;
    private var _level2boss:FlxButton;
    private var _level3:FlxButton;
    private var _level4:FlxButton;
    private var _level5:FlxButton;
    private var _finalboss:FlxButton;

    private var _home:FlxButton;
    private var _levelarr:Array<FlxButton>;
    private var _level_index:Int;
    private var _arrow:Arrow;
    private var _stararr:Array<FlxSprite>;

    private var _text:FlxText;
    private var _text2:FlxText;
    private var _text3:FlxText;
    private var _arrow2:Arrow;
    private var _arrow3:Arrow;
    private var _helptxt:FlxText;

    override public function create():Void
    {

        _map = new TiledMap(AssetPaths.levelmap_tutorial__tmx);
        _bg = new FlxTilemap();
        _bg.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width, _map.height, 
            AssetPaths.levelmap__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
        add(_bg);
        _bg.follow();
        _bg.color = 0x777777;

        _levelarr = new Array<FlxButton>();
        _tutorial = new FlxButton();
        _level1 = new FlxButton();
        _level1boss = new FlxButton();
        _level2 = new FlxButton();
        _level2boss = new FlxButton();
        _level3 = new FlxButton();
        _level4 = new FlxButton();
        _level5 = new FlxButton();
        _finalboss = new FlxButton();
        _home = new FlxButton();
        _levelarr.push(_tutorial);
        _levelarr.push(_level1);
        _levelarr.push(_level1boss);
        _levelarr.push(_level2);
        _levelarr.push(_level3);
        _levelarr.push(_level2boss);
        _levelarr.push(_level4);
        _levelarr.push(_level5);
        _levelarr.push(_finalboss);
        _level_index = 0;
        _arrow = new Arrow();

        _stararr = new Array<FlxSprite>();
        var tmpMap2:TiledObjectLayer = cast _map.getLayer("stars");
         for (e in tmpMap2.objects)
         {
             placeStars(e.type, e.xmlData.x);
         }

        var level:Int = 3;
         _home.loadGraphic(AssetPaths.shield_imageicon__png, false, 65, 65);

         for (i in 0...(level - 1)) {
            var rating:Int = Main.SAVE.data.stararr[i];
            if (rating == 3) {
                _stararr[i].loadGraphic(AssetPaths.threeStar2__png, false, 80, 30);
            } else if (rating == 2) {
                _stararr[i].loadGraphic(AssetPaths.twoStar2__png, false, 80, 30);
            } else {
                _stararr[i].loadGraphic(AssetPaths.oneStar2__png, false, 80, 30);
            }
            add(_stararr[i]);
         }

        // unlocked states
        for (i in 0...level) {
             _levelarr[i].active = true;
            // BOSS Level
            if (i == 2 || i == 5 || i == 8) {
                _levelarr[i].loadGraphic(AssetPaths.star_red__png, false, 50, 50);
            } else {
                _levelarr[i].loadGraphic(AssetPaths.star_yellow__png, false, 50, 50);
            }
        }

        // locked states
        for (i in level..._levelarr.length) {
            _levelarr[i].active = false;
            if (i == 2 || i == 5 || i == 8) {
                _levelarr[i].loadGraphic(AssetPaths.star_red_lock__png, false, 50, 50);
            } else {
                _levelarr[i].loadGraphic(AssetPaths.star_yellow_lock__png, false, 50, 50);
            }
        }

        _text = new FlxText(0, 0, 330, 18);
        _text.text = "Welcome to the Map! This is your home, where you can upgrade and switch out your"
            + " weapon configurations. ";
        _text.setFormat(AssetPaths.FONT, 18);

        _text2 = new FlxText(179, 424, 330, 18);
        _text2.text = "You can re-do any finished level with new weapons to achieve higher ratings.";
        _text2.setFormat(AssetPaths.FONT, 18);
        _arrow2 = new Arrow(115, 441);

        _text3 = new FlxText(307, 365, 330, 18);
        _text3.text =  "The red star means that this is a boss level.";
        _text3.setFormat(AssetPaths.FONT, 18);
        _arrow3 = new Arrow(251, 376);

        _helptxt = new FlxText(0, 0, 500, 24);
        _helptxt.text = "CLICK Anywhere to CONTINUE. ";
        _helptxt.setFormat(AssetPaths.FONT, 24);

        for (i in 3...9) {
            _levelarr[i].color = 0x777777;
        }

        for (level in _levelarr) {
            add(level);
        }

        add(_home);
        add(_arrow);
        add(_text);
        add(_text2);
        add(_text3);
        add(_arrow2);
        add(_arrow3);
        add(_helptxt);

        var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
         for (e in tmpMap.objects)
         {
             placeEntities(e.type, e.xmlData.x);
         }

        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        var click:Bool = false;
        if (FlxG.mouse.justPressed) {
            click = true;
        }
        if (click) {
            FlxG.switchState(new MapState());
        }
         
        super.update(elapsed);
    }

    private function placeEntities(entityName:String, entityData:Xml):Void
    {
        var x:Int = Std.parseInt(entityData.get("x"));
        var y:Int = Std.parseInt(entityData.get("y"));

        if (entityName == "home") {
            _home.x = x;
            _home.y = y;
        } else if(entityName == "arrow") {
            _arrow.x = x;
            _arrow.y = y;
        } else if (entityName == "text") {
            _text.x = x;
            _text.y = y;
        } else if (entityName == "helptxt") {
            _helptxt.x = x;
            _helptxt.y = y;
        }else {
            var icon:FlxButton = _levelarr[_level_index];
            _level_index++;
            icon.x = x;
            icon.y = y;
        }
    }

    private function placeStars(entityName:String, entityData:Xml):Void
    {
        var x:Int = Std.parseInt(entityData.get("x"));
        var y:Int = Std.parseInt(entityData.get("y"));
        var star:FlxSprite = new FlxSprite(x, y);
        _stararr.push(star);
    }
}