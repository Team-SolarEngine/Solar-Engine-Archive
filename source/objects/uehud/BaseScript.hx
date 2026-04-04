package objects.uehud;

class BaseScript extends FlxObject
{
    var game:PlayState;

    public function new(X:Float = 0, Y:Float = 0, gamestate:PlayState = null)
    {
        super(X, Y);
        game = gamestate;
    }

    function getCamera(cam:String = 'hud'):FlxCamera
    {
        if (game == null) return new FlxCamera();
        switch (cam.toLowerCase())
        {
            case "hud": return game.camHUD;
            case "other": return game.camOther;
            default: return game.camGame;
        }
    }

    function add(o:FlxBasic):FlxBasic
    {
        if (game != null)
            return game.add(o);
        else
            return o;
    }

    function remove(o:FlxBasic, splice:Bool = false):FlxBasic
    {
        if (game != null)
            return game.remove(o, splice);
        else
            return o;
    }

    public function updatePost(elapsed:Float) {}
    public function create() {}
    public function createPost() {}
    public function onSongStart() {}
    public function onBeatHit() {}
    public function onStepHit() {}
    public function goodNoteHit(id:Int, direction:Int, noteType:String, isSustainNote:Bool) {}
    public function onNoteMiss(direction:Float, noteType:String) {}
    public function onRating(rating:String) {}
    public function onSectionHit() {} // todo
    public function onPause() {}
    public function onResume() {}
    public function onCountdownTick(tick:Int) {}

    var curBeat(get, null):Int;
    var curStep(get, null):Int;
    var boyfriend(get, null):Character;
    var gf(get, null):Character;
    var dad(get, null):Character;
    var curSection(get, null):Int;
    function get_curBeat():Int return game.curBeat;
    function get_curStep():Int return game.curStep;
    function get_boyfriend():Character return game.boyfriend;
    function get_gf():Character return game.gf;
    function get_dad():Character return game.dad;
    function get_curSection():Int return game.curSection;
}