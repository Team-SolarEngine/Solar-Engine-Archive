package;

import flixel.util.FlxSave;
import lime.app.Application;

using StringTools;

// Runs some shit before launching the game.
class InitState extends FlxState
{
    public override function create() {
        super.create();

        var oldSave:FlxSave = new FlxSave();
        oldSave.bind("funkin", 'universe');

		FlxG.save.bind('funkin', 'solar'); // get the save ready before starting the game.
        if (!oldSave.isEmpty() && FlxG.save.data.wasTransferred == null) // Check if the save exists under the old folder.
        {
            FlxG.save.mergeData(oldSave.data);
            FlxG.save.data.wasTransferred = true; // make sure this can't be run again
            FlxG.save.flush();
        }
        FlxG.signals.postStateSwitch.add(validateTitle);

        PlayerSettings.init();
		ClientPrefs.loadPrefs(); // load the save for fixing potentially invalid options.

        validateSettings();

        FlxG.switchState(new TitleState());
    }

    public static function validateTitle()
    {
        if (!Std.isOfType(FlxG.state, PlayState))
        {
            if (Application.current.window.title.trim().endsWith("Universe Engine")) Application.current.window.title = "Friday Night Funkin: Solar Engine"; // fix for scripts that are before this update.
        }
    }

    public static function validateSettings()
    {
        var validMenuThemes:Array<String> = [
			'Universe',
			#if SILLY_OPTIONS "AAC V4", #end
			'Normal Collections',
			'Daveberry'
		];

        if (!validMenuThemes.contains(ClientPrefs.mmm)) ClientPrefs.mmm = "Universe";
        if (ClientPrefs.moveCreditMods) ClientPrefs.moveCreditMods = false;

        #if !SILLY_OPTIONS
        if (ClientPrefs.cm) ClientPrefs.cm = false;
        if (ClientPrefs.ft) ClientPrefs.ft = false;
        if (ClientPrefs.fm) ClientPrefs.fm = false;
        if (ClientPrefs.sillyBob) ClientPrefs.sillyBob = false;
        if (ClientPrefs.ec) ClientPrefs.ec = false;
        if (ClientPrefs.snm) ClientPrefs.snm = false;
        if (ClientPrefs.tng) ClientPrefs.tng = false;
        if (ClientPrefs.dcm) ClientPrefs.dcm = false;
        if (ClientPrefs.dhb) ClientPrefs.dhb = false;
        if (ClientPrefs.cc) ClientPrefs.cc = false;
        if (ClientPrefs.hudZoomOut) ClientPrefs.hudZoomOut = false;
        if (ClientPrefs.ib) ClientPrefs.ib = false;
        if (ClientPrefs.lhpbgb) ClientPrefs.lhpbgb = false;
        
        var validHitsounds:Array<String> = [
			'Classic',
			'Water',
			'Waterboom',
			'Heartbeat',
			'Universe',
        ];
        if (!validHitsounds.contains(ClientPrefs.ht)) ClientPrefs.ht = "Classic";
        #end
    }
}