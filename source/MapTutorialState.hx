package;

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

class MapTutorialState extends FlxState
{
    private var _map:TiledMap;
    private var _bg:FlxTilemap;
    private var _tutorial:LevelIcon;
    private var _level1:LevelIcon;
    private var _level1boss:LevelIcon;
    private var _level2:LevelIcon;
    private var _level3:LevelIcon;
    private var _level4:LevelIcon;
    private var _level5:LevelIcon;
    private var _home:HomeIcon;
    private var _levelarr:Array<LevelIcon>;
    private var _level_index:Int;
    private var _arrow:Arrow;

    // stage1 is home button
    private var _stage1:Bool;
    // stage2 is tutorial level button
    private var _stage2:Bool;
    // stage3 is new level button
    private var _stage3:Bool;
    // stage4 is boss level button
    private var _stage4:Bool;
    // stage5 is finish tutorial
    private var _stage5:Bool;
    private var _text:FlxText;

    override public function create():Void
    {

        _map = new TiledMap(AssetPaths.levelmap_tutorial__tmx);
        _bg = new FlxTilemap();
        _bg.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width, _map.height, 
            AssetPaths.levelmap__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
        add(_bg);
        _bg.follow();
        _bg.color = 0x777777;

        _levelarr = new Array<LevelIcon>();
        _tutorial = new LevelIcon(0, 0, false, false);
        _level1 = new LevelIcon(0, 0, false, false);
        _level1boss = new LevelIcon(0, 0, true, true);
        _level2 = new LevelIcon(0, 0, false, true);
        _level3 = new LevelIcon(0, 0, false, true);
        _level4 = new LevelIcon(0, 0, false, true);
        _level5 = new LevelIcon(0, 0, false, true);
        _home = new HomeIcon(0, 0);
        _levelarr.push(_tutorial);
        _levelarr.push(_level1);
        _levelarr.push(_level1boss);
        _levelarr.push(_level2);
        _levelarr.push(_level3);
        _levelarr.push(_level4);
        _levelarr.push(_level5);
        _level_index = 0;
        _arrow = new Arrow();

        _text = new FlxText(0, 0, 300, 15);
        _text.text = "Congradulations! You just passed the tutorial level! Here is the map. " + 
            "This is your home, where you can configure your weapons and get equipped. (Click Anywhere to continue)";
        _text.setFormat(AssetPaths.FONT, 15);

        for (i in 3...7) {
            _levelarr[i].color = 0x777777;
        }

        for (level in _levelarr) {
            add(level);
        }
        add(_home);
        add(_arrow);
        add(_text);


        var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
         for (e in tmpMap.objects)
         {
             placeEntities(e.type, e.xmlData.x);
         }

         _stage1 = true;
         _stage2 = false;
         _stage3 = false;
         _stage4 = false;

        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        var click:Bool = false;
        if (FlxG.mouse.justPressed) {
            click = true;
        }
        if (_stage1) {
            if (click) {
                _stage1 = false;
                _stage2 = true;
                _arrow.x = 86;
                _arrow.y = 178;
                _text.x = 139;
                _text.y = 172;
                _text.text = "This is the tutorial level you just finished. You can re-do any finished level " +
                    "with new weapons to achieve higher scores. (Click Anywhere to continue)";
            }
        } else if (_stage2) {
            if (click) {
                _stage2 = false;
                _stage3 = true;
                _arrow.x = 86;
                _arrow.y = 291;
                _text.x = 133;
                _text.y = 282;
                _text.text = "This is an unlocked new level. Once you finish a level, a new level will be unlocked. " +
                    "(Click Anywhere to continue)";
            }
        } else if (_stage3) {
            if (click) {
                _stage3 = false;
                _stage4 = true;
                _arrow.x = 174;
                _arrow.y = 242;
                _text.x = 223;
                _text.y = 233;
                _text.text = "The red star is a boss level. Better be well-equipped before challanging those levels. " +
                    "It is currently locked, to unlock, you need to finish previous level. (Click Anywhere to continue)";
            }
        } else if (_stage4) {
            if (click) {
                _stage4 = false;
                _stage5 = true;
                _arrow.visible = false;
                _text.x = 236;
                _text.y = 76;
                _text.text = "Congradulations! You finish the tutorial. Now you are free to either challange a new level "
                 + " or go home. (Click Anywhere to continue)";
            }
        } else if (_stage5) {
            if (click) {
                _stage5 = false;
                _arrow.visible = false;
                _text.visible = false;
                _bg.color = 0xffffff;
                for (i in 3...7) {
                    _levelarr[i].color = 0xffffff;
                }
                _home._onclick = switchHomeState;
                
            }
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
        }else {
            var icon:LevelIcon = _levelarr[_level_index];
            _level_index++;
            icon.x = x;
            icon.y = y;
        }
    }

    private function switchHomeState():Void {
        FlxG.switchState(new HomeState());
    }
}