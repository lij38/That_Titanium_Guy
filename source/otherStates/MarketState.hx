package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import items.*;
import levelStates.*;

class MarketState extends FlxState {
    private var _level:Int;
    private var title:FlxText;
    private var coin:FlxSprite;
    private var coinCount:FlxText;
    private var money:Int;
    private var confirm:ImageButton;
    private var next:ImageButton;
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
    private var rDmgConfirm:ImageButton;
    private var rRtime:ImageButton;
    private var rRtimeT:FlxText;
    private var rRtimeCost:Int;
    private var rRtimeNum:Int;
    private var rRtimeCC:FlxText;
    private var rRtimeConfirm:ImageButton;
    private var rMag:ImageButton;
    private var rMagT:FlxText;
    private var rMagCost:Int;
    private var rMagNum:Int;
    private var rMagCC:FlxText;
    private var rMagConfirm:ImageButton;
    private var rRate:ImageButton;
    private var rRateT:FlxText;
    private var rRateCost:Int;
    private var rRateNum:Int;
    private var rRateCC:FlxText;
    private var rRateConfirm:ImageButton;

    //Sword
    private var sword:FlxSprite;
    private var swDmg:ImageButton;
    private var swDmgT:FlxText;
    private var swDmgCost:Int;
    private var swDmgNum:Int;
    private var swDmgCC:FlxText;
    private var swDmgConfirm:ImageButton;
    private var ds:ImageButton;
    private var dsT:FlxText;
    private var dsCost:Int;
    private var dsNum:Int;
    private var dsCC:FlxText;
    private var dsConfirm:ImageButton;
    private var ki:ImageButton;
    private var kiT:FlxText;
    private var kiCost:Int;
    private var kiNum:Int;
    private var kiCC:FlxText;
    private var kiConfirm:ImageButton;
    private var ww:ImageButton;
    private var wwT:FlxText;
    private var wwCost:Int;
    private var wwNum:Int;
    private var wwCC:FlxText;
    private var wwConfirm:ImageButton;

    //shield
    private var shield:FlxSprite;
    private var spike:ImageButton;
    private var spikeT:FlxText;
    private var spikeCost:Int;
    private var spikeNum:Int;
    private var spikeCC:FlxText;
    private var spikeConfirm:ImageButton;
    private var reflect:ImageButton;
    private var reflectT:FlxText;
    private var reflectCost:Int;
    private var reflectNum:Int;
    private var reflectCC:FlxText;
    private var reflectConfirm:ImageButton;
    private var daze:ImageButton;
    private var dazeT:FlxText;
    private var dazeCost:Int;
    private var dazeNum:Int;
    private var dazeCC:FlxText;
    private var dazeConfirm:ImageButton;

    //shotgun
    private var shotgun:FlxSprite;
    private var sgDmg:ImageButton;
    private var sgDmgT:FlxText;
    private var sgDmgCost:Int;
    private var sgDmgNum:Int;
    private var sgDmgCC:FlxText;
    private var sgDmgConfirm:ImageButton;
    private var sgRtime:ImageButton;
    private var sgRtimeT:FlxText;
    private var sgRtimeCost:Int;
    private var sgRtimeNum:Int;
    private var sgRtimeCC:FlxText;
    private var sgRtimeConfirm:ImageButton;
    private var sgMag:ImageButton;
    private var sgMagT:FlxText;
    private var sgMagCost:Int;
    private var sgMagNum:Int;
    private var sgMagCC:FlxText;
    private var sgMagConfirm:ImageButton;
    private var sgRate:ImageButton;
    private var sgRateT:FlxText;
    private var sgRateCost:Int;
    private var sgRateNum:Int;
    private var sgRateCC:FlxText;
    private var sgRateConfirm:ImageButton;
    private var pushBack:ImageButton;
    private var pushBackT:FlxText;
    private var pushBackCost:Int;
    private var pushBackNum:Int;
    private var pushBackCC:FlxText;
    private var pushBackConfirm:ImageButton;

    //revolver
    private var revolver:FlxSprite;
    private var rvDmg:ImageButton;
    private var rvDmgT:FlxText;
    private var rvDmgCost:Int;
    private var rvDmgNum:Int;
    private var rvDmgCC:FlxText;
    private var rvDmgConfirm:ImageButton;
    private var rvRtime:ImageButton;
    private var rvRtimeT:FlxText;
    private var rvRtimeCost:Int;
    private var rvRtimeNum:Int;
    private var rvRtimeCC:FlxText;
    private var rvRtimeConfirm:ImageButton;
    private var rvMag:ImageButton;
    private var rvMagT:FlxText;
    private var rvMagCost:Int;
    private var rvMagNum:Int;
    private var rvMagCC:FlxText;
    private var rvMagConfirm:ImageButton;
    private var charge:ImageButton;
    private var chargeT:FlxText;
    private var chargeCost:Int;
    private var chargeNum:Int;
    private var chargeCC:FlxText;
    private var chargeConfirm:ImageButton;

    //tutorial
    private var wMask:FlxSprite;
    private var tWindow:FlxSprite;
    private var tText:FlxText;
    private var tButton:ImageButton;
    private var inTut:Bool;

    override public function create():Void {
        //title
        _level = Main.SAVE.data.curLevel;
        title = new FlxText(325, 1, 0, "Black Market", 26);
        title.setFormat(AssetPaths.FONT, title.size);
        add(title);
        wMask = new FlxSprite(0, 0).makeGraphic(800, 600, FlxColor.BLACK);
        wMask.alpha = 0;
        //coin count
        money = Main.SAVE.data.money;
        coin = new FlxSprite(700, 15).loadGraphic(AssetPaths.coinIcon__png);
        coinCount = new FlxText(730, 10, 0);
        coinCount.text = Std.string(money);
        coinCount.setFormat(AssetPaths.FONT, 20);
        
        add(coin);
        add(coinCount);
        //load the confirm button
        confirm = new ImageButton(200, 550, "CONFIRM", clickPlay);
        confirm.loadGraphic(AssetPaths.confirm__png, false, 200, 40);
        add(confirm);
        //load the next level button
        next = new ImageButton(400, 550, "next", clickNext);
        next.loadGraphic(AssetPaths.nextlevel__png);
        add(next);
        //confirm buttons
        confirmButtons = new FlxTypedGroup<ImageButton>();
        inTrans = false;
        //texts
        texts = new FlxTypedGroup<FlxText>();

        loadPlayer();
        loadRifle();
        loadSword();
        loadShield();
        if(Main.SAVE.data.shotgunPickup != null) {
            loadShotgun();
        }
        if(Main.SAVE.data.revolverPickup != null) {
            loadRevolver();
        }

        //window
        tWindow = new FlxSprite(100, 50).makeGraphic(600, 500, FlxColor.BLACK);
        tWindow.kill();
        add(wMask);
        add(tWindow);
        add(texts);
        //cancel button in transaction
        tCancel = new ImageButton(300, 500,killTrans);
        tCancel.loadGraphic(AssetPaths.cancel__png);
        tCancel.kill();
        add(tCancel);

        //tutorial
        if(Main.SAVE.data.bmTut == null || Main.SAVE.data.bmTut == false) {
            tutorial();
            confirm.kill();
            next.kill();
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
            } else if(inTrans){
                killTrans();
            } else {
                clickPlay();
            }
        }
        updatePrice();
    }

    private function updatePrice() {
        coinCount.text = Std.string(money);

        maxHtext.text = "Enhanced titanium armor allows you to take more damage before you bite the dust.\n"
                    + "Each upgrade grants you 20 extra health\n" + "Cost: $" + maxHcost + "\nUpgrades left: " + maxHnum;
        maxHcc.text = "Cost: $" + maxHcost + "\n# Left: " + maxHnum;
        jfText.text = "Enhanced fusion technology allows the jetpack to fly longer\n"
                    + "Each upgrade grants you 0.5 second extra flying time\n"
                    + "Cost: $" + jfcost + "\nUpgrades left: " + jfnum;
        jfcc.text = "Cost: $" + jfcost + "\n# Left: " + jfnum;
        pText.text = "Purchasing this upgrade will allow you to hold and save potions for emergency use.\n"
                    + "Each subsequent purchase will grant you one extra slot.\n"
                    + "Press \'H\' in game to use a saved health potion.\n"
                    + "Cost: $" + pcost + "\n" + "Upgrades left: " + pnum;
        pcc.text = "Cost: $" + pcost + "\n# Left: " + pnum;
        rRtimeT.text = "Training in your daft hands allows you to reload faster.\n"
                    + "Each Upgrade grants you +10% faster reload speed.\n"
                    + "Cost: $" + rRtimeCost + "\nUpgrades left: " + rRtimeNum;
        rRtimeCC.text = "Cost: $" + rRtimeCost + "\n# Left: " + rRtimeNum;
        rMagT.text = "Extended clips can always come in handy.\n"
                    + "Each upgrade will grant you +5 magazine size.\n"
                    + "Cost: $" + rMagCost + "\n" + "Upgrades left: " + rMagNum;
        rMagCC.text = "Cost: $" + rMagCost + "\n# Left: " + rMagNum;
        rDmgT.text = "Hollow points make the baddies drop just that much faster.\n"
                    + "Each upgrade grants you 10% extra damage\n" + "Cost: $" + rDmgCost + "\nUpgrades left: " + rDmgNum; 
        rDmgCC.text = "Cost: $" + rDmgCost + "\n# Left: " + rDmgNum;
        rRateT.text = "Fast as a hairpin trigger.\n"
                    + "Each upgrade grants you +10% rate of fire\n" + "Cost: $" + rRateCost + "\nUpgrades left: " + rRateNum; 
        rRateCC.text = "Cost: $" + rRateCost + "\n# Left: " + rRateNum;
        dsT.text = "Your training in dual-wielding has made you adept at making two slashing attacks at the same time.\n"
                    + "Each Upgrade grants you +5% chance of making a cross slash while dual wielding.\n"
                    + "Cost: $" + dsCost + "\nUpgrades left: " + dsNum;
        dsCC.text = "Cost: $" + dsCost + "\n# Left: " + dsNum;
        swDmgT.text = "Sharpened edge. Volatile energy.\n"
                    + "Each upgrade will grant you +15% damage.\n"
                    + "Cost: $" + swDmgCost + "\n" + "Upgrades left: " + swDmgNum;
        swDmgCC.text = "Cost: $" + swDmgCost + "\n# Left: " + swDmgNum;
        kiT.text = "Channel your inner ki energy to slice enemies to pieces from a distance.\n"
                    + "Your sword attacks will now unleash ranged ki waves.\n" + "Cost: $" + kiCost + "\nUpgrades left: " + kiNum; 
        kiCC.text = "Cost: $" + kiCost + "\n# Left: " + kiNum;
        wwT.text = "Your dual-wielding mastery now allows you to shred your surrounding enemies to pieces.\n"
                    + "Hold \'J\' and \'K\' together in game to unleash the whirlwinde\n" + "Cost: $" + wwCost + "\nUpgrades left: " + wwNum;
        wwCC.text = "Cost: $" + wwCost + "\n# Left: " + wwNum;
        spikeT.text = "Inspired by a scientist's pet hedgehog.\n"
                    + "First Upgrade grants you 5% damage reflected back to your melee attacker while blocking, each subsequent upgrade grants you +2% damage reflected.\n"
                    + "Cost: $" + spikeCost + "\nUpgrades left: " + spikeNum;
        spikeCC.text = "Cost: $" + spikeCost + "\n# Left: " + spikeNum;
        reflectT.text = "Did you know that mirrors reflect bullets too?\n"
                    + "First Upgrade grants you 5% damage reflected back to your ranged attacker while blocking, each subsequent upgrade grants you +2% damage reflected.\\n"
                    + "Cost: $" + reflectCost + "\n" + "Upgrades left: " + reflectNum;
        reflectCC.text = "Cost: $" + reflectCost + "\n# Left: " + reflectNum;
        dazeT.text = "Enemies are dazed by how good you are at using your shield.\n"
                    + "First upgrade grants you 5% chance of dazing the attacker while blocking, each subsequent"
                    + " upgrade grants you +2% chance.\n" + "Cost: $" + dazeCost + "\nUpgrades left: " + dazeNum;
        dazeCC.text = "Cost: $" + dazeCost + "\n# Left: " + dazeNum;
        if(Main.SAVE.data.shotgunPickup != null) {
            sgRtimeT.text = "Reload like you just missed your daughter's boyfriend.\n"
                        + "Each Upgrade grants you +10% faster reload speed.\n"
                        + "Cost: $" + sgRtimeCost + "\nUpgrades left: " + sgRtimeNum;
            sgRtimeCC.text = "Cost: $" + sgRtimeCost + "\n# Left: " + sgRtimeNum;
            sgMagT.text = "Extra shells around your belt can make you look like a badass.\n"
                        + "Each upgrade will grant you +1 magazine size.\n"
                        + "Cost: $" + sgMagCost + "\n" + "Upgrades left: " + sgMagNum;
            sgMagCC.text = "Cost: $" + sgMagCost + "\n# Left: " + sgMagNum;
            sgDmgT.text = "Practicing on your daughter's boyfriend has had some deadly results.\n"
                        + "Each upgrade grants you 10% extra damage\n" + "Cost: $" + sgDmgCost + "\nUpgrades left: " + sgDmgNum; 
            sgDmgCC.text = "Cost: $" + sgDmgCost + "\n# Left: " + sgDmgNum;
            sgRateT.text = "Ever heard of a fully-automatic shotgun?\n"
                        + "Each upgrade grants you +10% rate of fire\n" + "Cost: $" + sgRateCost + "\nUpgrades left: " + sgRateNum;
            sgRateCC.text = "Cost: $" + sgRateCost + "\n# Left: " + sgRateNum;
            pushBackT.text = "Send your daughter's boyfriend flying.\n"
                        + "Each upgrade grants you +10% enemy knockback\n" + "Cost: $" + pushBackCost + "\nUpgrades left: " + pushBackNum;
            pushBackCC.text = "Cost: $" + pushBackCost + "\n# Left: " + pushBackNum;
        }
        if(Main.SAVE.data.revolverPickup != null) {
            rvRtimeT.text = "Reload like a space cowboy.\n"
                        + "Each Upgrade grants you +10% faster reload speed.\n"
                        + "Cost: $" + rvRtimeCost + "\nUpgrades left: " + rvRtimeNum;
            rvRtimeCC.text = "Cost: $" + rvRtimeCost + "\n# Left: " + rvRtimeNum;
            rvMagT.text = "Can't call it a 6-shooter anymore.\n"
                        + "Each upgrade will grant you +1 magazine size.\n"
                        + "Cost: $" + rvMagCost + "\n" + "Upgrades left: " + rvMagNum;
            rvMagCC.text = "Cost: $" + rvMagCost + "\n# Left: " + rvMagNum;
            rvDmgT.text = ".44 Magnum fused with pure power.\n"
                        + "Each upgrade grants you 15% extra damage\n" + "Cost: $" + rvDmgCost + "\nUpgrades left: " + rvDmgNum;
            rvDmgCC.text = "Cost: $" + rvDmgCost + "\n# Left: " + rvDmgNum;
            chargeT.text = "What's scarier than a .44 magnum? A charged up one.\n"
                        + "Each upgrade grants you +10% charged damage\n" + "Cost: $" + chargeCost + "\nUpgrades left: " + chargeNum;
            chargeCC.text = "Cost: $" + chargeCost + "\n# Left: " + chargeNum;  
        }
    }

    private function loadPlayer() {
        head = new FlxSprite(50, 40).loadGraphic(AssetPaths.head__png);
        //maxHealth
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
        maxHtext = new FlxText(200, 150, 450);
        maxHtext.text = "Enhanced titanium armor allows you to take more damage before you bite the dust.\n"
            + "Each upgrade grants you 20 extra health\n" + "Cost: $" + maxHcost + "\nUpgrades left: " + maxHnum; 
        maxHtext.setFormat(AssetPaths.FONT, 25);
        maxHtext.kill();
        maxHcc = new FlxText(10, 130, 120);
        maxHcc.text = "Cost: $" + maxHcost + "\n# Left: " + maxHnum;
        maxHcc.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        maxHConfirm = new ImageButton(300, 450, maxHConfirmF);
        maxHConfirm.loadGraphic(AssetPaths.confirm__png);
        maxHConfirm.kill();
        confirmButtons.add(maxHConfirm);
        texts.add(maxHtext);
        maxH = new ImageButton(10, 95, trans.bind(maxHtext, maxHConfirm));
        maxH.loadGraphic(AssetPaths.tiarmor__png);

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
        jfText = new FlxText(200, 150, 450);
        jfText.text = "Enhanced fusion technology allows the jetpack to fly longer\n"
            + "Each upgrade grants you 0.5 second extra flying time\n"
            + "Cost: $" + jfcost + "\nUpgrades left: " + jfnum;
        jfText.setFormat(AssetPaths.FONT, 25);
        jfText.kill();
        jfcc = new FlxText(10, 230, 120);
        jfcc.text = "Cost: $" + jfcost + "\n# Left: " + jfnum;
        jfcc.setFormat(AssetPaths.FONT, 20);
        //confirm button
        jfConfirm = new ImageButton(300, 450, jfConfirmF);
        jfConfirm.loadGraphic(AssetPaths.confirm__png);
        jfConfirm.kill();
        confirmButtons.add(jfConfirm);
        texts.add(jfText);
        jetFuel = new ImageButton(10, 195, trans.bind(jfText, jfConfirm));
        jetFuel.loadGraphic(AssetPaths.fuelefficiency__png);

        //potion carrier
        if(Main.SAVE.data.pcost == null) {
            pcost = 300;
        } else {
            pcost = Main.SAVE.data.pcost;
        }
        if(Main.SAVE.data.pnum == null) {
            pnum = 5;
        } else {
            pnum = Main.SAVE.data.pnum;
        }
        pText = new FlxText(200, 150, 450);
        pText.text = "Purchasing this upgrade will allow you to hold and save potions for emergency use.\n"
            + "Each subsequent purchase will grant you one extra slot.\n"
            + "Press \'H\' in game to use a saved health potion.\n"
            + "Cost: $" + pcost + "\n" + "Upgrades left: " + pnum;
        pText.setFormat(AssetPaths.FONT, 25);
        pText.kill();
        pcc = new FlxText(10, 330, 120);
        pcc.text = "Cost: $" + pcost + "\n# Left: " + pnum;
        pcc.setFormat(AssetPaths.FONT, 20);
        //confirm button
        pConfirm = new ImageButton(300, 450, pConfirmF);
        pConfirm.loadGraphic(AssetPaths.confirm__png);
        pConfirm.kill();
        confirmButtons.add(pConfirm);
        texts.add(pText);
        potion = new ImageButton(10, 295, trans.bind(pText, pConfirm));
        potion.loadGraphic(AssetPaths.lifesaver__png);

        add(head);
        add(maxH);
        add(maxHcc);
        add(jetFuel);
        add(jfcc);
        add(potion);
        add(pcc);
    }

    private function loadRifle() {
        rifle = new FlxSprite(180, 40).loadGraphic(AssetPaths.rifle__png);

        //reload time
        if(Main.SAVE.data.rRtimeCost == null) {
            rRtimeCost = 100;
        } else {
            rRtimeCost = Main.SAVE.data.rRtimeCost;
        }
        if(Main.SAVE.data.rRtimeNum == null) {
            rRtimeNum = 10;
        } else {
            rRtimeNum = Main.SAVE.data.rRtimeNum;
        }
        rRtimeT = new FlxText(200, 150, 450);
        rRtimeT.text = "Training in your daft hands allows you to reload faster.\n"
            + "Each Upgrade grants you +10% faster reload speed.\n"
            + "Cost: $" + rRtimeCost + "\nUpgrades left: " + rRtimeNum;
        rRtimeT.setFormat(AssetPaths.FONT, 25);
        rRtimeT.kill();
        rRtimeCC = new FlxText(140, 130, 120);
        rRtimeCC.text = "Cost: $" + rRtimeCost + "\n# Left: " + rRtimeNum;
        rRtimeCC.setFormat(AssetPaths.FONT, 20);
        //confirm button
        rRtimeConfirm = new ImageButton(300, 450, rRtimeConfirmF);
        rRtimeConfirm.loadGraphic(AssetPaths.confirm__png);
        rRtimeConfirm.kill();
        confirmButtons.add(rRtimeConfirm);
        texts.add(rRtimeT);
        rRtime = new ImageButton(140, 95, trans.bind(rRtimeT, rRtimeConfirm));
        rRtime.loadGraphic(AssetPaths.reloadspeed__png);

        //magazine size
        if(Main.SAVE.data.rMagCost == null) {
            rMagCost = 150;
        } else {
            rMagCost = Main.SAVE.data.rMagCost;
        }
        if(Main.SAVE.data.rMagNum == null) {
            rMagNum = 10;
        } else {
            rMagNum = Main.SAVE.data.rMagNum;
        }
        rMagT = new FlxText(200, 150, 450);
        rMagT.text = "Extended clips can always come in handy.\n"
            + "Each upgrade will grant you +5 magazine size.\n"
            + "Cost: $" + rMagCost + "\n" + "Upgrades left: " + rMagNum;
        rMagT.setFormat(AssetPaths.FONT, 25);
        rMagT.kill();
        rMagCC = new FlxText(140, 230, 120);
        rMagCC.text = "Cost: $" + rMagCost + "\n# Left: " + rMagNum;
        rMagCC.setFormat(AssetPaths.FONT, 20);
        //confirm button
        rMagConfirm = new ImageButton(300, 450, rMagConfirmF);
        rMagConfirm.loadGraphic(AssetPaths.confirm__png);
        rMagConfirm.kill();
        confirmButtons.add(rMagConfirm);
        texts.add(rMagT);
        rMag = new ImageButton(140, 195, trans.bind(rMagT, rMagConfirm));
        rMag.loadGraphic(AssetPaths.magazineSize__png);

        //damage
        if(Main.SAVE.data.rDmgCost == null) {
            rDmgCost = 200;
        } else {
            rDmgCost = Main.SAVE.data.rDmgCost;
        }
        if(Main.SAVE.data.rDmgNum == null) {
            rDmgNum = 10;
        } else {
            rDmgNum = Main.SAVE.data.rDmgNum;
        }
        rDmgT = new FlxText(200, 150, 450);
        rDmgT.text = "Hollow points make the baddies drop just that much faster.\n"
            + "Each upgrade grants you 10% extra damage\n" + "Cost: $" + rDmgCost + "\nUpgrades left: " + rDmgNum; 
        rDmgT.setFormat(AssetPaths.FONT, 25);
        rDmgT.kill();
        rDmgCC = new FlxText(140, 330, 120);
        rDmgCC.text = "Cost: $" + rDmgCost + "\n# Left: " + rDmgNum;
        rDmgCC.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        rDmgConfirm = new ImageButton(300, 450, rDmgConfirmF);
        rDmgConfirm.loadGraphic(AssetPaths.confirm__png);
        rDmgConfirm.kill();
        confirmButtons.add(rDmgConfirm);
        texts.add(rDmgT);
        rDmg = new ImageButton(140, 295, trans.bind(rDmgT, rDmgConfirm));
        rDmg.loadGraphic(AssetPaths.damage__png);

        //fire rate
        if(Main.SAVE.data.rRateCost == null) {
            rRateCost = 200;
        } else {
            rRateCost = Main.SAVE.data.rRateCost;
        }
        if(Main.SAVE.data.rRateNum == null) {
            rRateNum = 10;
        } else {
            rRateNum = Main.SAVE.data.rRateNum;
        }
        rRateT = new FlxText(200, 150, 450);
        rRateT.text = "Fast as a hairpin trigger.\n"
            + "Each upgrade grants you +10% rate of fire\n" + "Cost: $" + rRateCost + "\nUpgrades left: " + rRateNum; 
        rRateT.setFormat(AssetPaths.FONT, 25);
        rRateT.kill();
        rRateCC = new FlxText(140, 430, 120);
        rRateCC.text = "Cost: $" + rRateCost + "\n# Left: " + rRateNum;
        rRateCC.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        rRateConfirm = new ImageButton(300, 450, rRateConfirmF);
        rRateConfirm.loadGraphic(AssetPaths.confirm__png);
        rRateConfirm.kill();
        confirmButtons.add(rRateConfirm);
        texts.add(rRateT);
        rRate = new ImageButton(140, 395, trans.bind(rRateT, rRateConfirm));
        rRate.loadGraphic(AssetPaths.rateoffire__png);

        add(rifle);
        add(rRtime);
        add(rRtimeCC);
        add(rMag);
        add(rMagCC);
        add(rDmg);
        add(rDmgCC);
        add(rRate);
        add(rRateCC);
    }

    //sword
    private function loadSword() {
        sword = new FlxSprite(310, 40).loadGraphic(AssetPaths.sword__png);

        //dual proficiency
        if(Main.SAVE.data.dsCost == null) {
            dsCost = 200;
        } else {
            dsCost = Main.SAVE.data.dsCost;
        }
        if(Main.SAVE.data.dsNum == null) {
            dsNum = 5;
        } else {
            dsNum = Main.SAVE.data.dsNum;
        }
        dsT = new FlxText(200, 150, 450);
        dsT.text = "Your training in dual-wielding has made you adept at making two slashing attacks at the same time.\n"
            + "Each Upgrade grants you +5% chance of making a cross slash while dual wielding.\n"
            + "Cost: $" + dsCost + "\nUpgrades left: " + dsNum;
        dsT.setFormat(AssetPaths.FONT, 25);
        dsT.kill();
        dsCC = new FlxText(270, 130, 120);
        dsCC.text = "Cost: $" + dsCost + "\n# Left: " + dsNum;
        dsCC.setFormat(AssetPaths.FONT, 20);
        //confirm button
        dsConfirm = new ImageButton(300, 450, dsConfirmF);
        dsConfirm.loadGraphic(AssetPaths.confirm__png);
        dsConfirm.kill();
        confirmButtons.add(dsConfirm);
        texts.add(dsT);
        ds = new ImageButton(270, 95, trans.bind(dsT, dsConfirm));
        ds.loadGraphic(AssetPaths.dualproficiency__png);

        //sword damage
        if(Main.SAVE.data.swDmgCost == null) {
            swDmgCost = 200;
        } else {
            swDmgCost = Main.SAVE.data.swDmgCost;
        }
        if(Main.SAVE.data.swDmgNum == null) {
            swDmgNum = 10;
        } else {
            swDmgNum = Main.SAVE.data.swDmgNum;
        }
        swDmgT = new FlxText(200, 150, 450);
        swDmgT.text = "Sharpened edge. Volatile energy.\n"
            + "Each upgrade will grant you +15% damage.\n"
            + "Cost: $" + swDmgCost + "\n" + "Upgrades left: " + swDmgNum;
        swDmgT.setFormat(AssetPaths.FONT, 25);
        swDmgT.kill();
        swDmgCC = new FlxText(270, 230, 120);
        swDmgCC.text = "Cost: $" + swDmgCost + "\n# Left: " + swDmgNum;
        swDmgCC.setFormat(AssetPaths.FONT, 20);
        //confirm button
        swDmgConfirm = new ImageButton(300, 450, swDmgConfirmF);
        swDmgConfirm.loadGraphic(AssetPaths.confirm__png);
        swDmgConfirm.kill();
        confirmButtons.add(swDmgConfirm);
        texts.add(swDmgT);
        swDmg = new ImageButton(270, 195, trans.bind(swDmgT, swDmgConfirm));
        swDmg.loadGraphic(AssetPaths.damage__png);

        //ki attack
        if(Main.SAVE.data.kiCost == null) {
            kiCost = 5000;
        } else {
            kiCost = Main.SAVE.data.kiCost;
        }
        if(Main.SAVE.data.kiNum == null) {
            kiNum = 1;
        } else {
            kiNum = Main.SAVE.data.kiNum;
        }
        kiT = new FlxText(200, 150, 450);
        kiT.text = "Channel your inner ki energy to slice enemies to pieces from a distance.\n"
            + "Your sword attacks will now unleash ranged ki waves.\n" + "Cost: $" + kiCost + "\nUpgrades left: " + kiNum; 
        kiT.setFormat(AssetPaths.FONT, 25);
        kiT.kill();
        kiCC = new FlxText(270, 330, 120);
        kiCC.text = "Cost: $" + kiCost + "\n# Left: " + kiNum;
        kiCC.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        kiConfirm = new ImageButton(300, 450, kiConfirmF);
        kiConfirm.loadGraphic(AssetPaths.confirm__png);
        kiConfirm.kill();
        confirmButtons.add(kiConfirm);
        texts.add(kiT);
        ki = new ImageButton(270, 295, trans.bind(kiT, kiConfirm));
        ki.loadGraphic(AssetPaths.kimaster__png);

        //whirlwind
        if(Main.SAVE.data.wwCost == null) {
            wwCost = 8000;
        } else {
            wwCost = Main.SAVE.data.wwCost;
        }
        if(Main.SAVE.data.wwNum == null) {
            wwNum = 1;
        } else {
            wwNum = Main.SAVE.data.wwNum;
        }
        wwT = new FlxText(200, 150, 450);
        wwT.text = "Your dual-wielding mastery now allows you to shred your surrounding enemies to pieces.\n"
            + "Hold \'J\' and \'K\' together in game to unleash the whirlwinde\n" + "Cost: $" + wwCost + "\nUpgrades left: " + wwNum; 
        wwT.setFormat(AssetPaths.FONT, 25);
        wwT.kill();
        wwCC = new FlxText(270, 430, 120);
        wwCC.text = "Cost: $" + wwCost + "\n# Left: " + wwNum;
        wwCC.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        wwConfirm = new ImageButton(300, 450, wwConfirmF);
        wwConfirm.loadGraphic(AssetPaths.confirm__png);
        wwConfirm.kill();
        confirmButtons.add(wwConfirm);
        texts.add(wwT);
        ww = new ImageButton(270, 395, trans.bind(wwT, wwConfirm));
        ww.loadGraphic(AssetPaths.whirlwind__png);

        add(sword);
        add(ds);
        add(dsCC);
        add(swDmg);
        add(swDmgCC);
        add(ki);
        add(kiCC);
        add(ww);
        add(wwCC);
    }

    //shield
    private function loadShield() {
        shield = new FlxSprite(440, 40).loadGraphic(AssetPaths.shield__png);

        //spiked shield
        if(Main.SAVE.data.spikeCost == null) {
            spikeCost = 200;
        } else {
            spikeCost = Main.SAVE.data.spikeCost;
        }
        if(Main.SAVE.data.spikeNum == null) {
            spikeNum = 6;
        } else {
            spikeNum = Main.SAVE.data.spikeNum;
        }
        spikeT = new FlxText(200, 150, 450);
        spikeT.text = "Inspired by a scientist's pet hedgehog.\n"
            + "First Upgrade grants you 5% damage reflected back to your melee attacker while blocking, each subsequent upgrade grants you +2% damage reflected.\n"
            + "Cost: $" + spikeCost + "\nUpgrades left: " + spikeNum;
        spikeT.setFormat(AssetPaths.FONT, 25);
        spikeT.kill();
        spikeCC = new FlxText(400, 130, 120);
        spikeCC.text = "Cost: $" + spikeCost + "\n# Left: " + spikeNum;
        spikeCC.setFormat(AssetPaths.FONT, 20);
        //confirm button
        spikeConfirm = new ImageButton(300, 450, spikeConfirmF);
        spikeConfirm.loadGraphic(AssetPaths.confirm__png);
        spikeConfirm.kill();
        confirmButtons.add(spikeConfirm);
        texts.add(spikeT);
        spike = new ImageButton(400, 95, trans.bind(spikeT, spikeConfirm));
        spike.loadGraphic(AssetPaths.spikedshield__png);

        //reflective shield
        if(Main.SAVE.data.reflectCost == null) {
            reflectCost = 200;
        } else {
            reflectCost = Main.SAVE.data.reflectCost;
        }
        if(Main.SAVE.data.reflectNum == null) {
            reflectNum = 6;
        } else {
            reflectNum = Main.SAVE.data.reflectNum;
        }
        reflectT = new FlxText(200, 150, 450);
        reflectT.text = "Did you know that mirrors reflect bullets too?\n"
            + "First Upgrade grants you 5% damage reflected back to your ranged attacker while blocking, each subsequent upgrade grants you +2% damage reflected.\\n"
            + "Cost: $" + reflectCost + "\n" + "Upgrades left: " + reflectNum;
        reflectT.setFormat(AssetPaths.FONT, 25);
        reflectT.kill();
        reflectCC = new FlxText(400, 230, 120);
        reflectCC.text = "Cost: $" + reflectCost + "\n# Left: " + reflectNum;
        reflectCC.setFormat(AssetPaths.FONT, 20);
        //confirm button
        reflectConfirm = new ImageButton(300, 450, reflectConfirmF);
        reflectConfirm.loadGraphic(AssetPaths.confirm__png);
        reflectConfirm.kill();
        confirmButtons.add(reflectConfirm);
        texts.add(reflectT);
        reflect = new ImageButton(400, 195, trans.bind(reflectT, reflectConfirm));
        reflect.loadGraphic(AssetPaths.reflectiveshield__png);

        //daze
        if(Main.SAVE.data.dazeCost == null) {
            dazeCost = 500;
        } else {
            dazeCost = Main.SAVE.data.dazeCost;
        }
        if(Main.SAVE.data.dazeNum == null) {
            dazeNum = 6;
        } else {
            dazeNum = Main.SAVE.data.dazeNum;
        }
        dazeT = new FlxText(200, 150, 400);
        dazeT.text = "Enemies are dazed by how good you are at using your shield.\n"
            + "First upgrade grants you 5% chance of dazing the attacker while blocking, each subsequent"
            + " upgrade grants you +2% chance.\n" + "Cost: $" + dazeCost + "\nUpgrades left: " + dazeNum; 
        dazeT.setFormat(AssetPaths.FONT, 25);
        dazeT.kill();
        dazeCC = new FlxText(400, 330, 120);
        dazeCC.text = "Cost: $" + dazeCost + "\n# Left: " + dazeNum;
        dazeCC.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        dazeConfirm = new ImageButton(300, 450, dazeConfirmF);
        dazeConfirm.loadGraphic(AssetPaths.confirm__png);
        dazeConfirm.kill();
        confirmButtons.add(dazeConfirm);
        texts.add(dazeT);
        daze = new ImageButton(400, 295, trans.bind(dazeT, dazeConfirm));
        daze.loadGraphic(AssetPaths.daze__png);

        add(shield);
        add(spike);
        add(spikeCC);
        add(reflect);
        add(reflectCC);
        add(daze);
        add(dazeCC);
    }

    //shotgun
    private function loadShotgun() {
        shotgun = new FlxSprite(570, 40).loadGraphic(AssetPaths.shotgun__png);

        //reload time
        if(Main.SAVE.data.sgRtimeCost == null) {
            sgRtimeCost = 100;
        } else {
            sgRtimeCost = Main.SAVE.data.sgRtimeCost;
        }
        if(Main.SAVE.data.sgRtimeNum == null) {
            sgRtimeNum = 10;
        } else {
            sgRtimeNum = Main.SAVE.data.sgRtimeNum;
        }
        sgRtimeT = new FlxText(200, 150, 450);
        sgRtimeT.text = "Reload like you just missed your daughter's boyfriend.\n"
            + "Each Upgrade grants you +10% faster reload speed.\n"
            + "Cost: $" + sgRtimeCost + "\nUpgrades left: " + sgRtimeNum;
        sgRtimeT.setFormat(AssetPaths.FONT, 25);
        sgRtimeT.kill();
        sgRtimeCC = new FlxText(530, 130, 120);
        sgRtimeCC.text = "Cost: $" + sgRtimeCost + "\n# Left: " + sgRtimeNum;
        sgRtimeCC.setFormat(AssetPaths.FONT, 20);
        //confirm button
        sgRtimeConfirm = new ImageButton(300, 450, sgRtimeConfirmF);
        sgRtimeConfirm.loadGraphic(AssetPaths.confirm__png);
        sgRtimeConfirm.kill();
        confirmButtons.add(sgRtimeConfirm);
        texts.add(sgRtimeT);
        sgRtime = new ImageButton(530, 95, trans.bind(sgRtimeT, sgRtimeConfirm));
        sgRtime.loadGraphic(AssetPaths.reloadspeed__png);

        //magazine size
        if(Main.SAVE.data.sgMagCost == null) {
            sgMagCost = 150;
        } else {
            sgMagCost = Main.SAVE.data.sgMagCost;
        }
        if(Main.SAVE.data.sgMagNum == null) {
            sgMagNum = 8;
        } else {
            sgMagNum = Main.SAVE.data.sgMagNum;
        }
        sgMagT = new FlxText(200, 150, 450);
        sgMagT.text = "Extra shells around your belt can make you look like a badass.\n"
            + "Each upgrade will grant you +1 magazine size.\n"
            + "Cost: $" + sgMagCost + "\n" + "Upgrades left: " + sgMagNum;
        sgMagT.setFormat(AssetPaths.FONT, 25);
        sgMagT.kill();
        sgMagCC = new FlxText(530, 230, 120);
        sgMagCC.text = "Cost: $" + sgMagCost + "\n# Left: " + sgMagNum;
        sgMagCC.setFormat(AssetPaths.FONT, 20);
        //confirm button
        sgMagConfirm = new ImageButton(300, 450, sgMagConfirmF);
        sgMagConfirm.loadGraphic(AssetPaths.confirm__png);
        sgMagConfirm.kill();
        confirmButtons.add(sgMagConfirm);
        texts.add(sgMagT);
        sgMag = new ImageButton(530, 195, trans.bind(sgMagT, sgMagConfirm));
        sgMag.loadGraphic(AssetPaths.magazineSize__png);

        //damage
        if(Main.SAVE.data.sgDmgCost == null) {
            sgDmgCost = 200;
        } else {
            sgDmgCost = Main.SAVE.data.sgDmgCost;
        }
        if(Main.SAVE.data.sgDmgNum == null) {
            sgDmgNum = 10;
        } else {
            sgDmgNum = Main.SAVE.data.sgDmgNum;
        }
        sgDmgT = new FlxText(200, 150, 450);
        sgDmgT.text = "Practicing on your daughter's boyfriend has had some deadly results.\n"
            + "Each upgrade grants you 10% extra damage\n" + "Cost: $" + sgDmgCost + "\nUpgrades left: " + sgDmgNum; 
        sgDmgT.setFormat(AssetPaths.FONT, 25);
        sgDmgT.kill();
        sgDmgCC = new FlxText(530, 330, 120);
        sgDmgCC.text = "Cost: $" + sgDmgCost + "\n# Left: " + sgDmgNum;
        sgDmgCC.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        sgDmgConfirm = new ImageButton(300, 450, sgDmgConfirmF);
        sgDmgConfirm.loadGraphic(AssetPaths.confirm__png);
        sgDmgConfirm.kill();
        confirmButtons.add(sgDmgConfirm);
        texts.add(sgDmgT);
        sgDmg = new ImageButton(530, 295, trans.bind(sgDmgT, sgDmgConfirm));
        sgDmg.loadGraphic(AssetPaths.damage__png);

        //fire rate
        if(Main.SAVE.data.sgRateCost == null) {
            sgRateCost = 200;
        } else {
            sgRateCost = Main.SAVE.data.sgRateCost;
        }
        if(Main.SAVE.data.sgRateNum == null) {
            sgRateNum = 10;
        } else {
            sgRateNum = Main.SAVE.data.sgRateNum;
        }
        sgRateT = new FlxText(200, 150, 450);
        sgRateT.text = "Ever heard of a fully-automatic shotgun?\n"
            + "Each upgrade grants you +10% rate of fire\n" + "Cost: $" + sgRateCost + "\nUpgrades left: " + sgRateNum; 
        sgRateT.setFormat(AssetPaths.FONT, 25);
        sgRateT.kill();
        sgRateCC = new FlxText(530, 430, 120);
        sgRateCC.text = "Cost: $" + sgRateCost + "\n# Left: " + sgRateNum;
        sgRateCC.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        sgRateConfirm = new ImageButton(300, 450, sgRateConfirmF);
        sgRateConfirm.loadGraphic(AssetPaths.confirm__png);
        sgRateConfirm.kill();
        confirmButtons.add(sgRateConfirm);
        texts.add(sgRateT);
        sgRate = new ImageButton(530, 395, trans.bind(sgRateT, sgRateConfirm));
        sgRate.loadGraphic(AssetPaths.rateoffire__png);

        //pushback
        if(Main.SAVE.data.pushBackCost == null) {
            pushBackCost = 200;
        } else {
            pushBackCost = Main.SAVE.data.pushBackCost;
        }
        if(Main.SAVE.data.pushBackNum == null) {
            pushBackNum = 10;
        } else {
            pushBackNum = Main.SAVE.data.pushBackNum;
        }
        pushBackT = new FlxText(200, 150, 450);
        pushBackT.text = "Send your daughter's boyfriend flying.\n"
            + "Each upgrade grants you +10% enemy knockback\n" + "Cost: $" + pushBackCost + "\nUpgrades left: " + pushBackNum; 
        pushBackT.setFormat(AssetPaths.FONT, 25);
        pushBackT.kill();
        pushBackCC = new FlxText(530, 530, 120);
        pushBackCC.text = "Cost: $" + pushBackCost + "\n# Left: " + pushBackNum;
        pushBackCC.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        pushBackConfirm = new ImageButton(300, 450, pushBackConfirmF);
        pushBackConfirm.loadGraphic(AssetPaths.confirm__png);
        pushBackConfirm.kill();
        confirmButtons.add(pushBackConfirm);
        texts.add(pushBackT);
        pushBack = new ImageButton(530, 495, trans.bind(pushBackT, pushBackConfirm));
        pushBack.loadGraphic(AssetPaths.juggernaut__png);

        add(shotgun);
        add(sgRtime);
        add(sgRtimeCC);
        add(sgMag);
        add(sgMagCC);
        add(sgDmg);
        add(sgDmgCC);
        add(sgRate);
        add(sgRateCC);
        add(pushBack);
        add(pushBackCC);
    }

    //revolver
    private function loadRevolver() {
        revolver = new FlxSprite(700, 40).loadGraphic(AssetPaths.revolver__png);

        //reload time
        if(Main.SAVE.data.rvRtimeCost == null) {
            rvRtimeCost = 100;
        } else {
            rvRtimeCost = Main.SAVE.data.rvRtimeCost;
        }
        if(Main.SAVE.data.rvRtimeNum == null) {
            rvRtimeNum = 10;
        } else {
            rvRtimeNum = Main.SAVE.data.rvRtimeNum;
        }
        rvRtimeT = new FlxText(200, 150, 450);
        rvRtimeT.text = "Reload like a space cowboy.\n"
            + "Each Upgrade grants you +10% faster reload speed.\n"
            + "Cost: $" + rvRtimeCost + "\nUpgrades left: " + rvRtimeNum;
        rvRtimeT.setFormat(AssetPaths.FONT, 25);
        rvRtimeT.kill();
        rvRtimeCC = new FlxText(660, 130, 120);
        rvRtimeCC.text = "Cost: $" + rvRtimeCost + "\n# Left: " + rvRtimeNum;
        rvRtimeCC.setFormat(AssetPaths.FONT, 20);
        //confirm button
        rvRtimeConfirm = new ImageButton(300, 450, rvRtimeConfirmF);
        rvRtimeConfirm.loadGraphic(AssetPaths.confirm__png);
        rvRtimeConfirm.kill();
        confirmButtons.add(rvRtimeConfirm);
        texts.add(rvRtimeT);
        rvRtime = new ImageButton(660, 95, trans.bind(rvRtimeT, rvRtimeConfirm));
        rvRtime.loadGraphic(AssetPaths.reloadspeed__png);

        //magazine size
        if(Main.SAVE.data.rvMagCost == null) {
            rvMagCost = 150;
        } else {
            rvMagCost = Main.SAVE.data.rvMagCost;
        }
        if(Main.SAVE.data.rvMagNum == null) {
            rvMagNum = 6;
        } else {
            rvMagNum = Main.SAVE.data.rvMagNum;
        }
        rvMagT = new FlxText(200, 150, 450);
        rvMagT.text = "Can't call it a 6-shooter anymore.\n"
            + "Each upgrade will grant you +1 magazine size.\n"
            + "Cost: $" + rvMagCost + "\n" + "Upgrades left: " + rvMagNum;
        rvMagT.setFormat(AssetPaths.FONT, 25);
        rvMagT.kill();
        rvMagCC = new FlxText(660, 230, 120);
        rvMagCC.text = "Cost: $" + rvMagCost + "\n# Left: " + rvMagNum;
        rvMagCC.setFormat(AssetPaths.FONT, 20);
        //confirm button
        rvMagConfirm = new ImageButton(300, 450, rvMagConfirmF);
        rvMagConfirm.loadGraphic(AssetPaths.confirm__png);
        rvMagConfirm.kill();
        confirmButtons.add(rvMagConfirm);
        texts.add(rvMagT);
        rvMag = new ImageButton(660, 195, trans.bind(rvMagT, rvMagConfirm));
        rvMag.loadGraphic(AssetPaths.magazineSize__png);

        //damage
        if(Main.SAVE.data.rvDmgCost == null) {
            rvDmgCost = 200;
        } else {
            rvDmgCost = Main.SAVE.data.rvDmgCost;
        }
        if(Main.SAVE.data.rvDmgNum == null) {
            rvDmgNum = 10;
        } else {
            rvDmgNum = Main.SAVE.data.rvDmgNum;
        }
        rvDmgT = new FlxText(200, 150, 450);
        rvDmgT.text = ".44 Magnum fused with pure power.\n"
            + "Each upgrade grants you 15% extra damage\n" + "Cost: $" + rvDmgCost + "\nUpgrades left: " + rvDmgNum; 
        rvDmgT.setFormat(AssetPaths.FONT, 25);
        rvDmgT.kill();
        rvDmgCC = new FlxText(660, 330, 120);
        rvDmgCC.text = "Cost: $" + rvDmgCost + "\n# Left: " + rvDmgNum;
        rvDmgCC.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        rvDmgConfirm = new ImageButton(300, 450, rvDmgConfirmF);
        rvDmgConfirm.loadGraphic(AssetPaths.confirm__png);
        rvDmgConfirm.kill();
        confirmButtons.add(rvDmgConfirm);
        texts.add(rvDmgT);
        rvDmg = new ImageButton(660, 295, trans.bind(rvDmgT, rvDmgConfirm));
        rvDmg.loadGraphic(AssetPaths.damage__png);

        //charge
        if(Main.SAVE.data.chargeCost == null) {
            chargeCost = 300;
        } else {
            chargeCost = Main.SAVE.data.chargeCost;
        }
        if(Main.SAVE.data.chargeNum == null) {
            chargeNum = 10;
        } else {
            chargeNum = Main.SAVE.data.chargeNum;
        }
        chargeT = new FlxText(200, 150, 450);
        chargeT.text = "What's scarier than a .44 magnum? A charged up one.\n"
            + "Each upgrade grants you +10% charged damage\n" + "Cost: $" + chargeCost + "\nUpgrades left: " + chargeNum; 
        chargeT.setFormat(AssetPaths.FONT, 25);
        chargeT.kill();
        chargeCC = new FlxText(660, 430, 120);
        chargeCC.text = "Cost: $" + chargeCost + "\n# Left: " + chargeNum;
        chargeCC.setFormat(AssetPaths.FONT, 20);
        //load the confirm button in transaction
        chargeConfirm = new ImageButton(300, 450, chargeConfirmF);
        chargeConfirm.loadGraphic(AssetPaths.confirm__png);
        chargeConfirm.kill();
        confirmButtons.add(chargeConfirm);
        texts.add(chargeT);
        charge = new ImageButton(660, 395, trans.bind(chargeT, chargeConfirm));
        charge.loadGraphic(AssetPaths.chargingcolt__png);

        add(revolver);
        add(rvRtime);
        add(rvRtimeCC);
        add(rvMag);
        add(rvMagCC);
        add(rvDmg);
        add(rvDmgCC);
        add(charge);
        add(chargeCC);
    }

    private function trans(t:FlxText, b:ImageButton) {
        if(!inTut && !inTrans) {
            confirm.kill();
            next.kill();
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
        next.revive();
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

    //1
    private function maxHConfirmF() {
        if(money > maxHcost && maxHnum > 0) {
            money -= maxHcost;
            maxHnum--;
            Main.SAVE.data.maxHealth += 20;
            maxHcost = cast(maxHcost * 1.4, Int);
            Main.SAVE.data.maxHcost = maxHcost;
            Main.SAVE.data.maxHnum = maxHnum;
            Main.LOGGER.logLevelAction(1);
        }
        killTrans();
    }

    //2
    private function jfConfirmF() {
        if(money > jfcost && jfnum > 0) {
            money -= jfcost;
            jfnum--;
            Main.SAVE.data.maxFuel += 0.5;
            jfcost = cast(jfcost * 1.5, Int);
            Main.SAVE.data.jfcost = jfcost;
            Main.SAVE.data.jfnum = jfnum;
            Main.LOGGER.logLevelAction(2);
        }
        killTrans();
    }

    //3
    private function pConfirmF() {
        if(money > pcost && pnum > 0) {
            money -= pcost;
            pnum--;
            if(Main.SAVE.data.potionCount != null) {
                Main.SAVE.data.potionCount += 1;
            }
            pcost = cast(pcost * 1.5, Int);
            Main.SAVE.data.pcost = pcost;
            Main.SAVE.data.pnum = pnum;
            Main.LOGGER.logLevelAction(3);
        }
        killTrans();
    }


    //4
    private function rRtimeConfirmF() {
        if(money > rRtimeCost && rRtimeNum > 0) {
            money -= rRtimeCost;
            rRtimeNum--;
            Main.SAVE.data.rRtime *= 0.9;
            rRtimeCost = cast(rRtimeCost * 1.4, Int);
            Main.SAVE.data.rRtimeCost = rRtimeCost;
            Main.SAVE.data.rRtimeNum = rRtimeNum;
            Main.LOGGER.logLevelAction(4);
        }
        killTrans();
    }

    //5
    private function rMagConfirmF() {
        if(money > rMagCost && rMagNum > 0) {
            money -= rMagCost;
            rMagNum--;
            Main.SAVE.data.rMag += 5;
            rMagCost = cast(rMagCost * 1.4, Int);
            Main.SAVE.data.rMagCost = rMagCost;
            Main.SAVE.data.rMagNum = rMagNum;
            Main.LOGGER.logLevelAction(5);
        }
        killTrans();
    }
    //6
    private function rDmgConfirmF() {
        if(money > rDmgCost && rDmgNum > 0) {
            money -= rDmgCost;
            rDmgNum--;
            Main.SAVE.data.rDmg *= 1.1;
            rDmgCost = cast(rDmgCost * 1.4, Int);
            Main.SAVE.data.rDmgCost = rDmgCost;
            Main.SAVE.data.rDmgNum = rDmgNum;
            Main.LOGGER.logLevelAction(6);
        }
        killTrans();
    }
    //7
    private function rRateConfirmF() {
        if(money > rRateCost && rRateNum > 0) {
            money -= rRateCost;
            rRateNum--;
            Main.SAVE.data.rRate *= 0.8;
            rRateCost = cast(rRateCost * 1.5, Int);
            Main.SAVE.data.rRateCost = rRateCost;
            Main.SAVE.data.rRateNum = rRateNum;
            Main.LOGGER.logLevelAction(7);
        }
        killTrans();
    }
    //8
    private function dsConfirmF() {
        if(money > dsCost && dsNum > 0) {
            money -= dsCost;
            dsNum--;
            Main.SAVE.data.ds += 5;
            dsCost = cast(dsCost * 1.5, Int);
            Main.SAVE.data.dsCost = dsCost;
            Main.SAVE.data.dsNum = dsNum;
            Main.LOGGER.logLevelAction(8);
        }
        killTrans();
    }

    //9
    private function swDmgConfirmF() {
        if(money > swDmgCost && swDmgNum > 0) {
            money -= swDmgCost;
            swDmgNum--;
            Main.SAVE.data.swDmg *= 1.15;
            swDmgCost = cast(swDmgCost * 1.5, Int);
            Main.SAVE.data.swDmgCost = swDmgCost;
            Main.SAVE.data.swDmgNum = swDmgNum;
            Main.LOGGER.logLevelAction(9);
        }
        killTrans();
    }
    //10
    private function kiConfirmF() {
        if(money > kiCost && kiNum > 0) {
            money -= kiCost;
            kiNum--;
            Main.SAVE.data.ki = true;
            Main.SAVE.data.kiNum = kiNum;
            Main.LOGGER.logLevelAction(10);
        }
        killTrans();
    }
    //11
    private function wwConfirmF() {
        if(money > wwCost && wwNum > 0) {
            money -= wwCost;
            wwNum--;
            Main.SAVE.data.ww = true;
            Main.SAVE.data.wwNum = wwNum;
            Main.LOGGER.logLevelAction(11);
        }
        killTrans();
    }
    //12
    private function spikeConfirmF() {
        if(money > spikeCost && spikeNum > 0) {
            money -= spikeCost;
            spikeNum--;
            if(Main.SAVE.data.spike == null) {
                Main.SAVE.data.spike = 0.05;
            } else {
                Main.SAVE.data.spike += 0.02;
            }
            spikeCost = cast(spikeCost * 1.4, Int);
            Main.SAVE.data.spikeCost = spikeCost;
            Main.SAVE.data.spikeNum = spikeNum;
            Main.LOGGER.logLevelAction(12);
        }
        killTrans();
    }
    //13
    private function reflectConfirmF() {
        if(money > reflectCost && reflectNum > 0) {
            money -= reflectCost;
            reflectNum--;
            if(Main.SAVE.data.reflect == null) {
                Main.SAVE.data.reflect = 0.05;
            } else {
                Main.SAVE.data.reflect += 0.02;
            }
            reflectCost = cast(reflectCost * 1.4, Int);
            Main.SAVE.data.reflectCost = reflectCost;
            Main.SAVE.data.reflectNum = reflectNum;
            Main.LOGGER.logLevelAction(13);
        }
        killTrans();
    }
    //14
    private function dazeConfirmF() {
        if(money > dazeCost && dazeNum > 0) {
            money -= dazeCost;
            dazeNum--;
            if(Main.SAVE.data.daze == null) {
                Main.SAVE.data.daze = 5;
            } else {
                Main.SAVE.data.daze += 2;
            }
            dazeCost = cast(dazeCost * 1.5, Int);
            Main.SAVE.data.dazeCost = dazeCost;
            Main.SAVE.data.dazeNum = dazeNum;
            Main.LOGGER.logLevelAction(14);
        }
        killTrans();
    }
    //15
    private function sgRtimeConfirmF() {
        if(money > sgRtimeCost && sgRtimeNum > 0) {
            money -= sgRtimeCost;
            sgRtimeNum--;
            Main.SAVE.data.sgRtime *= 0.9;
            sgRtimeCost = cast(sgRtimeCost * 1.4, Int);
            Main.SAVE.data.sgRtimeCost = sgRtimeCost;
            Main.SAVE.data.sgRtimeNum = sgRtimeNum;
            Main.LOGGER.logLevelAction(15);
        }
        killTrans();
    }
    //16
    private function sgMagConfirmF() {
        if(money > sgMagCost && sgMagNum > 0) {
            money -= sgMagCost;
            sgMagNum--;
            Main.SAVE.data.sgMag += 1;
            sgMagCost = cast(sgMagCost * 1.4, Int);
            Main.SAVE.data.sgMagCost = sgMagCost;
            Main.SAVE.data.sgMagNum = sgMagNum;
            Main.LOGGER.logLevelAction(16);
        }
        killTrans();
    }
    //17
    private function sgDmgConfirmF() {
        if(money > sgDmgCost && sgDmgNum > 0) {
            money -= sgDmgCost;
            sgDmgNum--;
            Main.SAVE.data.sgDmg *= 1.1;
            sgDmgCost = cast(sgDmgCost * 1.4, Int);
            Main.SAVE.data.sgDmgCost = sgDmgCost;
            Main.SAVE.data.sgDmgNum = sgDmgNum;
            Main.LOGGER.logLevelAction(17);
        }
        killTrans();
    }
    //18
    private function sgRateConfirmF() {
        if(money > sgRateCost && sgRateNum > 0) {
            money -= sgRateCost;
            sgRateNum--;
            Main.SAVE.data.sgRate *= 0.9;
            sgRateCost = cast(sgRateCost * 1.4, Int);
            Main.SAVE.data.sgRateCost = sgRateCost;
            Main.SAVE.data.sgRateNum = sgRateNum;
            Main.LOGGER.logLevelAction(18);
        }
        killTrans();
    }
    //19
    private function pushBackConfirmF() {
        if(money > pushBackCost && pushBackNum > 0) {
            money -= pushBackCost;
            pushBackNum--;
            Main.SAVE.data.pushBack *= 1.1;
            pushBackCost = cast(pushBackCost * 1.4, Int);
            Main.SAVE.data.pushBackCost = pushBackCost;
            Main.SAVE.data.pushBackNum = pushBackNum;
            Main.LOGGER.logLevelAction(19);
        }
        killTrans();
    }
    //20
    private function rvRtimeConfirmF() {
        if(money > rvRtimeCost && rvRtimeNum > 0) {
            money -= rvRtimeCost;
            rvRtimeNum--;
            Main.SAVE.data.rvRtime *= 0.9;
            rvRtimeCost = cast(rvRtimeCost * 1.4, Int);
            Main.SAVE.data.rvRtimeCost = rvRtimeCost;
            Main.SAVE.data.rvRtimeNum = rvRtimeNum;
            Main.LOGGER.logLevelAction(20);
        }
        killTrans();
    }
    //21
    private function rvMagConfirmF() {
        if(money > rvMagCost && rvMagNum > 0) {
            money -= rvMagCost;
            rvMagNum--;
            Main.SAVE.data.rvMag += 1;
            rvMagCost = cast(rvMagCost * 1.4, Int);
            Main.SAVE.data.rvMagCost = rvMagCost;
            Main.SAVE.data.rvMagNum = rvMagNum;
            Main.LOGGER.logLevelAction(21);
        }
        killTrans();
    }
    //22
    private function rvDmgConfirmF() {
        if(money > rvDmgCost && rvDmgNum > 0) {
            money -= rvDmgCost;
            rvDmgNum--;
            Main.SAVE.data.rvDmg *= 1.15;
            rvDmgCost = cast(rvDmgCost * 1.5, Int);
            Main.SAVE.data.rvDmgCost = rvDmgCost;
            Main.SAVE.data.rvDmgNum = rvDmgNum;
            Main.LOGGER.logLevelAction(22);
        }
        killTrans();
    }
    //23
    private function chargeConfirmF() {
        if(money > chargeCost && chargeNum > 0) {
            money -= chargeCost;
            chargeNum--;
            Main.SAVE.data.charge *= 1.1;
            chargeCost = cast(chargeCost * 1.4, Int);
            Main.SAVE.data.chargeCost = chargeCost;
            Main.SAVE.data.chargeNum = chargeNum;
            Main.LOGGER.logLevelAction(23);
        }
        killTrans();
    }
    
    private function clickPlay() {
        Main.LOGGER.logLevelEnd({won: true});
        Main.SAVE.data.money = money;
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new HomeState());
		});
    }

    private function tutorial() {
        tWindow.revive();
        wMask.alpha = 0.75;
        tText = new FlxText(110, 25, 580);
        tText.text = "Welcome to the black market! Here you can buy upgrades for you and your Weapons. \n"
            + "All the upgrades are listed under the icon for that item, along with the price and how many"
            + " more times you can upgrade it. \n"
            + "Click on an upgrade to show its details and to purchase it. \n"
            + "If you don't have enough money, try to get better ratings on levels for better rewards and "
            + "come back later!";
        tText.setFormat(AssetPaths.FONT, 30);
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
        next.revive();
        inTut = false;
    }

    private function clickNext() {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			if(_level <= Main.SAVE.data.levelCompleted) {
                switch _level {
                    case 1: FlxG.switchState(new Level1State());
                    case 2: FlxG.switchState(new Boss1State());
                    case 4: FlxG.switchState(new Level3State());
                    case 5: FlxG.switchState(new Boss2State());
                    case 6: FlxG.switchState(new CreditState());
                }
            } else {
                switch _level {
                    case 1: FlxG.switchState(new TutorialState());
                    case 2: FlxG.switchState(new Level1State());
                    case 4: FlxG.switchState(new Level2State());
                    case 5: FlxG.switchState(new Level3State());
                    case 6: FlxG.switchState(new Boss2State());
                }
            }

            if(_level == 3) {
                if(Main.SAVE.data.homeTut == null) {
                    FlxG.switchState(new HomeState());
                } else if(Main.SAVE.data.levelCompleted < 3) {
                    FlxG.switchState(new Boss1State());
                } else {
                    FlxG.switchState(new Level2State());
                }
            }
		});
    }
}

