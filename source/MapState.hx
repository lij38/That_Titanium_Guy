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

class MapState extends FlxState
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
    override public function create():Void
    {

        _map = new TiledMap(AssetPaths.levelmap__tmx);
        _bg = new FlxTilemap();
        _bg.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width, _map.height, 
            AssetPaths.levelmap__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
        add(_bg);
        _bg.follow();

        _levelarr = new Array<LevelIcon>();
        _tutorial = new LevelIcon(0, 0, false, false, tutorialOnClick);
        _level1 = new LevelIcon(0, 0, false, false);
        _level1boss = new LevelIcon(0, 0, true, true);
        _level2 = new LevelIcon(0, 0, false, true);
        _level3 = new LevelIcon(0, 0, false, true);
        _level4 = new LevelIcon(0, 0, false, true);
        _level5 = new LevelIcon(0, 0, false, true);
        _home = new HomeIcon(0, 0, switchHomeState);
        _levelarr.push(_tutorial);
        _levelarr.push(_level1);
        _levelarr.push(_level1boss);
        _levelarr.push(_level2);
        _levelarr.push(_level3);
        _levelarr.push(_level4);
        _levelarr.push(_level5);
        _level_index = 0;

        for (level in _levelarr) {
            add(level);
        }
        add(_home);


        var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
         for (e in tmpMap.objects)
         {
             placeEntities(e.type, e.xmlData.x);
         }

        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    private function placeEntities(entityName:String, entityData:Xml):Void
    {
        var x:Int = Std.parseInt(entityData.get("x"));
        var y:Int = Std.parseInt(entityData.get("y"));

        if (entityName == "home") {
            _home.x = x;
            _home.y = y;
        } else {
            var icon:LevelIcon = _levelarr[_level_index];
            _level_index++;
            icon.x = x;
            icon.y = y;
        }
    }

    private function tutorialOnClick():Void {
        trace("click");
    }

    private function switchHomeState():Void {
        FlxG.switchState(new HomeState());
    }
}