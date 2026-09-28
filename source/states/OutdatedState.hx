package states;

import openfl.display.BlendMode;
import flixel.util.FlxAxes;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var checker:FlxBackdrop;
	var warnText:FlxText;

	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("aboutMenu", "preload"));
		bg.color = 0xFFFF8C19;
		bg.scale.set(1.1, 1.1);
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg);

		checker = new FlxBackdrop(Paths.image('checker', 'preload'), FlxAxes.XY);
		checker.scale.set(1.4, 1.4);
		checker.color = 0xFF006AFF;
		checker.blend = BlendMode.LAYER;
		add(checker);
		checker.scrollFactor.set(0, 0.07);
		checker.alpha = 0.2;
		checker.updateHitbox();

		warnText = new FlxText(0, 0, FlxG.width, getUpdateText(), 32);
		warnText.setFormat(Paths.font('funkin.ttf'), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		warnText.screenCenter(Y);
		add(warnText);
	}

	function getUpdateText():String
	{
		return #if OLD_UPDMSG "Ay Mate! looks you are using an
			outdated version of Solar Engine ("
			+ MainMenuState.ueVersion
			+ "),
			please update to "
			+ TitleState.updateVersion
			+ "!
			Press ESCAPE/ENTER to proceed anyway.
			
			Thank you for using the Engine!
			You are truly THE epic :D" #else "Hey, looks like you're on an
			older version of Solar Engine ("
			+ MainMenuState.ueVersion
			+ "),
			
			The newest version is"
			+ TitleState.updateVersion
			+ "!
			Press ESCAPE/ENTER to dismiss this message." #end;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (!leftState)
		{
			if (controls.ACCEPT || controls.BACK)
			{
				leftState = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function(twn:FlxTween)
					{
						if (ClientPrefs.data.fm)
						{
							MusicBeatState.switchState(new CoolMenuState());
						}
						else
						{
							MusicBeatState.switchState(new MainMenuState());
						}
					}
				});
			}
		}
	}
}
