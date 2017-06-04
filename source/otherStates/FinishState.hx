package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import levelStates.*;
import flixel.util.FlxColor;
import items.*;

class FinishState extends FlxState
{
	private var _btnPlay:ImageButton;
    private var _btnHome:ImageButton;
    private var text:FlxText;
    private var timeNum:Int;
    private var time:FlxText;
    private var timeRating:FlxSprite;
    private var killNum:Int;
    private var killed:FlxText;
    private var killedRating:FlxSprite;
    private var dmgNum:Int;
    private var dmg:FlxText;
    private var dmgRating:FlxSprite;
    private var overall:FlxText;
    private var overallRating:FlxSprite;
    private var ending:FlxText;
    private var _level:Int;

    //money
    private var reward:FlxText;

    override public function create():Void
    {   
        _level = Main.SAVE.data.curLevel;
        text = new FlxText(290, 25, 0, "Victory!", 50);
        text.setFormat(AssetPaths.FONT, text.size);
        add(text);
        // rating = new FlxText(320, 200, 0, "Rating: Gold", 25);
        // rating.setFormat(AssetPaths.FONT, rating.size);
        // add(rating);
        //time rating
        timeNum = RatingCalc.getTimeRating(_level);
        time = new FlxText(200, 150, 0, "Time Used: ", 35);
        time.setFormat(AssetPaths.FONT, time.size);
        timeRating = new FlxSprite(450, 140);
        if(timeNum == 3) {
            timeRating.loadGraphic(AssetPaths.threeStar__png);
        } else if(timeNum == 2) {
            timeRating.loadGraphic(AssetPaths.twoStar__png);
        } else {
            timeRating.loadGraphic(AssetPaths.oneStar__png);
        }

        //dmg rating
        dmgNum = RatingCalc.getDmgRating(_level);
        dmg = new FlxText(200, 200, 0, "Damage Taken: ", 35);
        dmg.setFormat(AssetPaths.FONT, dmg.size);
        dmgRating = new FlxSprite(450, 190);
        if(dmgNum == 3) {
            dmgRating.loadGraphic(AssetPaths.threeStar__png);
        } else if(dmgNum == 2) {
            dmgRating.loadGraphic(AssetPaths.twoStar__png);
        } else {
            dmgRating.loadGraphic(AssetPaths.oneStar__png);
        }

        //enemies killed
        killed = new FlxText(200, 250, 0, "Enemies Killed: ", 35);
        killed.setFormat(AssetPaths.FONT, killed.size);
        killedRating = new FlxSprite(450, 240);
        if(Main.SAVE.data.enemiesKilled - 1 == Main.SAVE.data.numEnemies) {
            killNum = 3;
        } else if(Main.SAVE.data.enemiesKilled >= Main.SAVE.data.numEnemies / 2) {
            killNum = 2;
        } else {
            killNum = 1;
        }

        if(killNum == 3) {
            killedRating.loadGraphic(AssetPaths.threeStar__png);
        } else if(killNum == 2) {
            killedRating.loadGraphic(AssetPaths.twoStar__png);
        } else {
            killedRating.loadGraphic(AssetPaths.oneStar__png);
        }

        //overall
        var avg:Int = cast(Math.fround((killNum * 1.0 + dmgNum + timeNum) / 3), Int);
        overall = new FlxText(200, 300, 0, "Overall: ", 35);
        overall.setFormat(AssetPaths.FONT, overall.size);
        overallRating = new FlxSprite(450, 290);

        if(avg == 3) {
            overallRating.loadGraphic(AssetPaths.threeStar__png);
        } else if(avg == 2) {
            overallRating.loadGraphic(AssetPaths.twoStar__png);
        } else {
            overallRating.loadGraphic(AssetPaths.oneStar__png);
        }

        var currentAvg:Int = avg;
        if (Main.SAVE.data.stararr[_level - 1] != null) {
            currentAvg = cast(Math.max(cast(Main.SAVE.data.stararr[_level - 1], Float), cast(currentAvg, Float)), Int);
        }
        trace(currentAvg);
        Main.SAVE.data.stararr[_level - 1] = currentAvg;

        add(time);
        add(timeRating);
        add(dmg);
        add(dmgRating);
        add(killed);
        add(killedRating);
        add(overall);
        add(overallRating);
		_btnPlay = new ImageButton(300, 500, "Next", clickPlay);
        _btnPlay.loadGraphic(AssetPaths.next__png, false, 200, 40);
        add(_btnPlay);
        _btnHome = new ImageButton(300, 550, "Go Home", clickHome);
        _btnHome.loadGraphic(AssetPaths.gohome__png, false, 200, 40);
        if(Main.SAVE.data.wsTut != null) {
            add(_btnHome);
        }
        ending = new FlxText(100, 450, 600, "Thanks for playing! You've beat all of the levels we have so far but more levels are coming soon!", 20);
        ending.setFormat(AssetPaths.FONT, ending.size);
        if(Main.SAVE.data.end != null) {
            add(ending);
        }
		
        //Money
        var percent:Int = timeNum + killNum + dmgNum;
        reward = new FlxText(200, 350, 0);
        var money:Int = Main.SAVE.data.levelMoney;
        money = cast(money * percent / 10.0, Int);
        Main.SAVE.data.money += money;
        reward.text = "Star Reward Coins: +" + Std.string(money);
        reward.setFormat(AssetPaths.FONT, 35);
        Main.SAVE.flush();
        add(reward);

        FlxG.sound.playMusic(AssetPaths.victory__mp3);
		FlxG.camera.fade(FlxColor.BLACK, .25, true);
        super.create();
    }

    override public function update(elapsed:Float):Void
    {   
        if (FlxG.keys.anyJustPressed([ENTER])) {
				clickPlay();
		}
        super.update(elapsed);
    }
	
	private function clickPlay():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.sound.music.destroy();
			switch _level {
                case 1: FlxG.switchState(new Level1State());
                case 4: FlxG.switchState(new Level3State());
                case 5: FlxG.switchState(new Boss2State());
                case 6: FlxG.switchState(new CreditState());
            }
            if( _level == 2) {
                if(Main.SAVE.data.wsTut == null) {
                    FlxG.switchState(new WorkshopState());
                } else {
                    FlxG.switchState(new Boss1State());
                }
            }
            if(_level == 3) {
                if(Main.SAVE.data.bmTut == null) {
                    FlxG.switchState(new MarketState());
                } else {
                    FlxG.switchState(new Level2State());
                }
            }
		});
	}

    private function clickHome():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.sound.music.destroy();
            if(_level == 3 && Main.SAVE.data.bmTut == null) {
                FlxG.switchState(new MarketState());
            } else {
                FlxG.switchState(new HomeState());
            }
		});
    }
}