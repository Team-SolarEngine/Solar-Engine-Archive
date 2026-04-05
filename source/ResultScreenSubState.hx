package;

typedef ScoreStuff = {
    var score:Int;
    var sicks:Int;
    var goods:Int;
    var bads:Int;
    var shits:Int;
    var misses:Int;
    var totalPlayed:Int;
}

class ResultScreenSubState extends MusicBeatSubstate
{
    public var hsStuff:ScoreStuff;
    public var bg:FlxSprite;
    public var memTweens:Array<FlxTween> = [];
    public var grpTexts:FlxGroup;
    public var bfAnim:FlxSprite;
    public var camResults:FlxCamera;

    public override function create()
    {
        super.create();

        var game:PlayState = PlayState.instance;

        camResults = new FlxCamera();
        camResults.bgColor.alpha = 0;
        FlxG.cameras.add(camResults, false);

        this.cameras = [camResults];
        hsStuff = {
            score: game.songScore,
            sicks: game.sicks,
            goods: game.goods,
            bads: game.bads,
            shits: game.shits,
            misses: game.songMisses,
            totalPlayed: game.totalPlayed
        };

        var finalRatingPercent:Float = calcRating();

        bg = new FlxSprite().loadGraphic(Paths.image("menuBGBlue"));
        bg.scrollFactor.set();
        bg.alpha = 0.6;
        add(bg);

        grpTexts = new FlxGroup();
        add(grpTexts);

        var ipath:String = "result/bfCoolRankLoop";
        var path:String = "resultsEXCELLENT";
        if (finalRatingPercent <= 50)
        {
            path = "resultsSHIT";
            ipath = "result/bfshitresult";
        }
        bfAnim = new FlxSprite().loadGraphic(Paths.image(ipath, "preload"));
        bfAnim.frames = Paths.getSparrowAtlas(ipath, "preload");
        bfAnim.animation.addByPrefix("loop", "rankLoop0", 24, true);
        bfAnim.animation.play("loop");
        bfAnim.x = FlxG.width + bfAnim.width;
        bfAnim.y = FlxG.height - bfAnim.height;
        add(bfAnim);

        memTweens.push(FlxTween.tween(bfAnim, {x: FlxG.width - bfAnim.width}, 3, {startDelay: 1.4, ease:FlxEase.quartOut}));

        FlxG.sound.play(Paths.sound('results/$path-intro'), 1, false, null, true, ()->{FlxG.sound.playMusic(Paths.sound("results/" + path));});

        var funnyArray = [
            game.songScore,
            game.sicks,
            game.goods,
            game.bads,
            game.shits,
            game.songMisses,
            finalRatingPercent
        ];

        var yuhs:Array<String> = [
            "Score:          ",
            "Sicks:           ",
            "Goods:          ",
            "Bads:           ",
            "Shits:           ",
            "Misses:         ",
            "Final Percent: "
        ];
        for (i in 0...7)
        {
            var scoreTxt:FlxText = new FlxText (30, -50, 0, yuhs[i] + Std.string(funnyArray[i]));
            scoreTxt.setFormat(Paths.font("funkin.ttf"), 50, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
            grpTexts.add(scoreTxt);

            memTweens.push(FlxTween.tween(scoreTxt, {y: (100 * i) + 20}, 0.3, {startDelay: 0.2 * i, ease: FlxEase.quartOut, onComplete: (_)->{FlxG.sound.play(Paths.sound("confirmMenu"));}}));
        }

        
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.ACCEPT || controls.BACK)
        {
            for (tween in memTweens)
                tween.cancel();

            end();
        }
    }

    function end()
    {
        PlayState.instance.inCutscene = false;
        close();
        PlayState.instance.endSong();
    }

    function calcRating():Float
    {
        if (hsStuff.totalPlayed == 0) return 100;
        var accuracy = (hsStuff.sicks + hsStuff.goods) / hsStuff.totalPlayed;
        
        return Math.floor(Math.floor((accuracy * 100) * 100) / 100);
    }
}