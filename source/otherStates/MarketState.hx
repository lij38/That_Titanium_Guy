package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import items.*;

class MarketState extends FlxState {
    private var title:FlxText;
    private var coin:FlxSprite;
    private var coinCount:FlxText;
    private var confirm:ImageButton;
    private var tCancel:ImageButton;
    private var inTrans:Bool;
    private var confirmButtons:FlxTypedGroup<ImageButton>;
    private var texts:FlxTypedGroup<FlxText>;

    //player
    private var head:FlxSprite;
    private var maxH:ImageButton;
    private var maxHConfirm:ImageButton;
    private var maxHtext:FlxText;
    private var maxHcost:Int;
    private var maxHnum:Int;
    private var maxHcc:FlxText;
    private var jetFuel:ImageButton;
    private var jfConfirm:ImageButton;
    private var jfcost:Int;
    private var jfnum:Int;
    private var jfcc:FlxText;
    private var jfText:FlxText;
    private var potion:ImageButton;
    private var pConfirm:ImageButton;
    private var pText:FlxText;
    private var pcost:Int;
    private var pnum:Int;
    private var pcc:FlxText;

    //rifle
    private var rifle:FlxSprite;
    private var rDmg:ImageButton;
    private var rDmgT:FlxText;
    private var rDmgCost:Int;
    private var rDmgNum:Int;
    private var rDmgCC:FlxText;
    private var rRtime:ImageButton;
    private var rRtimeCost:Int;
    private var rRtimeNum:Int;
    private var rRtimeCC:FlxText;
    private var rMag:ImageButton;
    private var rMagCost:Int;
    private var rMagNum:Int;
    private var rMagCC:FlxText;
    private var rRate:ImageButton;
    private var rRateCost:Int;
    private var rRateNum:Int;
    private var rRateCC:FlxText;

    //Sword
    private var sword:FlxSprite;
    private var swDmg:ImageButton;
    private var swDmgT:FlxText;
    private var swDmgCost:Int;
    private var swDmgNum:Int;
    private var swDmgCC:FlxText;
    private var ds:ImageButton;
    private var dsT:FlxText;
    private var dsCost:Int;
    private var dsNum:Int;
    private var dsCC:FlxText;
    private var ki:ImageButton;
    private var kiT:FlxText;
    private var kiCost:Int;
    private var kiNum:Int;
    private var kiCC:FlxText;
    private var ww:ImageButton;
    private var wwT:FlxText;
    private var wwCost:Int;
    private var wwNum:Int;
    private var wwCC:FlxText;

    //shield
    private var shield:FlxSprite;
    private var spike:ImageButton;
    private var spikeT:FlxText;
    private var spikeCost:Int;
    private var spikeNum:Int;
    private var spikeCC:FlxText;
    private var reflect:ImageButton;
    private var reflectT:FlxText;
    private var reflectCost:Int;
    private var reflectNum:Int;
    private var reflectCC:FlxText;
    private var daze:ImageButton;
    private var dazeT:FlxText;
    private var dazeCost:Int;
    private var dazeNum:Int;
    private var dazeCC:FlxText;

    //shotgun
    private var shotgun:FlxSprite;
    private var sgDmg:ImageButton;
    private var sgDmgT:FlxText;
    private var sgDmgCost:Int;
    private var sgDmgNum:Int;
    private var sgDmgCC:FlxText;
    private var sgRtime:ImageButton;
    private var sgRtimeCost:Int;
    private var sgRtimeNum:Int;
    private var sgRtimeCC:FlxText;
    private var sgMag:ImageButton;
    private var sgMagCost:Int;
    private var sgMagNum:Int;
    private var sgMagCC:FlxText;
    private var sgRate:ImageButton;
    private var sgRateCost:Int;
    private var sgRateNum:Int;
    private var sgRateCC:FlxText;
    private var pushBack:ImageButton;
    private var pushBackCost:Int;
    private var pushBackNum:Int;
    private var pushBackCC:FlxText;

    //revolver
    private var revolver:FlxSprite;
    private var rvDmg:ImageButton;
    private var rvDmgT:FlxText;
    private var rvDmgCost:Int;
    private var rvDmgNum:Int;
    private var rvDmgCC:FlxText;
    private var rvRtime:ImageButton;
    private var rvRtimeCost:Int;
    private var rvRtimeNum:Int;
    private var rvRtimeCC:FlxText;
    private var rvMag:ImageButton;
    private var rvMagCost:Int;
    private var rvMagNum:Int;
    private var rvMagCC:FlxText;
    private var rvRate:ImageButton;
    private var rvRateCost:Int;
    private var rvRateNum:Int;
    private var rvRateCC:FlxText;
    private var charge:ImageButton;
    private var chargeCost:Int;
    private var chargeNum:Int;
    private var chargeCC:FlxText;

    //tutorial
    private var wMask:FlxSprite;
    private var tWindow:FlxSprite;
    private var tText:FlxText;
    private var tButton:ImageButton;
    private var inTut:Bool;

    override public function create():Void {
        //title
        title = new FlxText(325, 5, 0, "Black Market", 30);
        title.setFormat(AssetPaths.FONT, title.size);
        add(title);
        wMask = new FlxSprite(0, 0).makeGraphic(800, 600, FlxColor.BLACK);
        wMask.alpha = 0;
        add(wMask);
        //coin count
        coin = new FlxSprite(700, 15).loadGraphic(AssetPaths.coinIcon__png);
        coinCount = new FlxText(730, 10, 0, Std.string(Main.SAVE.data.money), 20);
        coinCount.setFormat(AssetPaths.FONT, coinCount.size);
        add(coin);
        add(coinCount);
        //load the confirm button
        confirm = new ImageButton(300, 550, "CONFIRM", clickPlay);
        confirm.loadGraphic(AssetPaths.confirm__png, false, 200, 40);
        add(confirm);
        //confirm buttons
        confirmButtons = new FlxTypedGroup<ImageButton>();
        inTrans = false;
        //texts
        texts = new FlxTypedGroup<FlxText>();

        loadPlayer();
        //loadRifle();
        //loadSword();
        //loadShield();
        //loadShotgun();
        //loadRevolver();

        //window
        tWindow = new FlxSprite(100, 50).makeGraphic(600, 500, FlxColor.BLACK);
        tWindow.kill();
        add(tWindow);
        add(texts);
        //cancel button in transaction
        tCancel = new ImageButton(300, 500, "cancel", killTrans);
        tCancel.kill();
        add(tCancel);

        //tutorial
        if(Main.SAVE.data.bmTut == null || Main.SAVE.data.bmTut == false) {
            tutorial();
            confirm.kill();
        }
        add(confirmButtons);
        Main.LOGGER.logLevelStart(-1);
        super.create();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        if(FlxG.keys.anyJustPressed([ENTER])) {
            if(inTut) {
                killTut();
            } else {
                clickPlay();
            }
        }
    }

    private function loadPlayer() {
        head = new FlxSprite(35, 40).loadGraphic(AssetPaths.head__png);
        //max health
        if(Main.SAVE.data.maxHcost == null) {
            maxHcost = 200;
        } else {
            maxHcost = Main.SAVE.data.maxHcost;
        }
        if(Main.SAVE.data.maxHnum == null) {
            maxHnum = 10;
        } else {
            maxHnum = Main.SAVE.data.maxHnum;
        }
        maxHtext = new FlxText(200, 150, 400);
        maxHtext.text = "Enhanced titanium armor allows you to take more damage before you bite the dust.\n"
            + "Each upgrade grants you 20 extra health\n" + "Cost: " + maxHcost + "\nUpgrades left: " + maxHnum; 
        maxHtext.setFormat(AssetPaths.FONT, 25);
        maxHtext.kill();
        maxHcc = new FlxText(10, 130, 120);
        maxHcc.text = "Cost: " + maxHcost + "\n# Left: " + maxHnum;
        maxHcc.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        maxHConfirm = new ImageButton(300, 450, maxHConfirmF);
        maxHConfirm.loadGraphic(AssetPaths.confirm__png);
        maxHConfirm.kill();
        confirmButtons.add(maxHConfirm);
        texts.add(maxHtext);
        maxH = new ImageButton(10, 95, trans.bind(maxHtext, maxHConfirm));

        //jet fuel
        if(Main.SAVE.data.jfcost == null) {
            jfcost = 200;
        } else {
            jfcost = Main.SAVE.data.jfcost;
        }
        if(Main.SAVE.data.jfnum == null) {
            jfnum = 10;
        } else {
            jfnum = Main.SAVE.data.jfnum;
        }
        jfText = new FlxText(200, 150, 400);
        jfText.text = "Enhanced fusion technology allows the jetpack to fly longer\n"
            + "Each upgrade grants you 0.5 second extra flying time\n"
            + "Cost: " + jfcost + "\nUpgrades left: " + jfnum;
        jfText.setFormat(AssetPaths.FONT, 25);
        jfText.kill();
        jfcc = new FlxText(10, 230, 120);
        jfcc.text = "$" + jfcost + "\n# Left: " + jfnum;
        jfcc.setFormat(AssetPaths.FONT, 20);
        //confirm button
        jfConfirm = new ImageButton(300, 450, jfConfirmF);
        jfConfirm.loadGraphic(AssetPaths.confirm__png);
        jfConfirm.kill();
        confirmButtons.add(jfConfirm);
        texts.add(jfText);
        jetFuel = new ImageButton(10, 195, trans.bind(jfText, jfConfirm));

        //potion carrier
        if(Main.SAVE.data.pcost == null) {
            pcost = 200;
        } else {
            pcost = Main.SAVE.data.pcost;
        }
        if(Main.SAVE.data.pnum == null) {
            pnum = 10;
        } else {
            pnum = Main.SAVE.data.pnum;
        }
        pText = new FlxText(200, 150, 400);
        pText.text = "Purchasing this upgrade will allow you to hold and save potions for emergency use.\n"
            + "Each subsequent purchase will grant you one extra slot.\n"
            + "Press \'H\' in game to use a saved health potion.\n"
            + "Cost: " + pcost + "\n" + "Upgrades left: " + pnum;
        pText.setFormat(AssetPaths.FONT, 25);
        pText.kill();
        pcc = new FlxText(10, 330, 120);
        pcc.text = "$" + pcost + "\n# Left: " + pnum;
        pcc.setFormat(AssetPaths.FONT, 20);
        //confirm button
        pConfirm = new ImageButton(300, 450, pConfirmF);
        pConfirm.loadGraphic(AssetPaths.confirm__png);
        pConfirm.kill();
        confirmButtons.add(pConfirm);
        texts.add(pText);
        potion = new ImageButton(10, 295, trans.bind(pText, pConfirm));

        add(head);
        add(maxH);
        add(maxHcc);
        add(jetFuel);
        add(jfcc);
        add(potion);
        add(pcc);
    }

    private function trans(t:FlxText, b:ImageButton) {
        if(!inTut && !inTrans) {
            confirm.kill();
            wMask.alpha = 0.75;
            tWindow.revive();
            t.revive();
            b.revive();
            tCancel.revive();
            inTrans = true;
        }
    }

    private function killTrans() {
        confirm.revive();
        inTrans = false;
        wMask.alpha = 0;
        tWindow.kill();
        tCancel.kill();
        confirmButtons.forEach(killButtons);
        texts.forEach(killTexts);
    }

    private function killButtons(b:ImageButton) {
        if(b.alive) {
            b.kill();
        }
    }

    private function killTexts(t:FlxText) {
        if(t.alive) {
            t.kill();
        }
    }

    private function maxHConfirmF() {
        killTrans();
    }

    private function jfConfirmF() {
        killTrans();
    }

    private function pConfirmF() {
        killTrans();
    }

    private function clickPlay() {
        Main.LOGGER.logLevelEnd({won: true});
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new HomeState());
		});
    }

    private function tutorial() {
        tWindow.revive();
        wMask.alpha = 0.75;
        tText = new FlxText(110, 50, 580);
        tText.text = "Welcome to the black market! Here you can buy upgrades for you and your Weapons. \n"
            + "All the upgrades are listed under the icon for that item, along with the price and how many"
            + " more times you can upgrade it. \n"
            + "Click on an upgrade to purchase it. \n"
            + "If you don't have enough money, try to get better ratings on levels for better rewards and "
            + "come back later!";
        tText.setFormat(AssetPaths.FONT, 35);
        add(tText);
        inTut = true;
        tButton = new ImageButton(300, 550, killTut);
        tButton.loadGraphic(AssetPaths.next__png, false, 200, 40);
        add(tButton);
        Main.SAVE.data.bmTut = true;
    }

    private function killTut() {
        wMask.alpha = 0.0;
        tWindow.kill();
        tText.destroy();
        tButton.destroy();
        confirm.revive();
        inTut = false;
    }
}

