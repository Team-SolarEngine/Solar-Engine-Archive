#if !macro
import backend.Paths;
import backend.MusicBeatState;
import backend.MusicBeatSubstate;
import backend.ClientPrefs;
import backend.Controls;
import backend.Conductor;
import backend.InputFormatter;
import objects.Character;
import objects.Boyfriend;
import objects.Note;
import objects.StrumNote;
import objects.NoteSplash;
import objects.HealthIcon;
import objects.AttachedSprite;
import objects.Alphabet;
import objects.TypedAlphabet;
import objects.AttachedText;
import objects.BGSprite;
import objects.FlxUIDropDownMenuCustom;
import objects.CheckboxThingie;
import backend.CoolUtil;
import backend.WeekData;
import backend.Song;
import backend.Highscore;
import backend.Song.SwagSong;
import backend.PlayerSettings;
import substates.CustomFadeTransition;
import substates.GameOverSubstate;
import substates.GameplayChangersSubstate;
import states.PlayState;
import states.PauseSubState;
import states.LoadingState;
import backend.StageData;
#if desktop
import backend.Discord.DiscordClient;
#end
#if VIDEOS_ALLOWED 
	#if (hxCodec <= "2.5.1") // hxcodec fix *yay sound effect*
	import vlc.MP4Handler;
	#elseif (hxCodec <= "2.6.1")
	import hxcodec.VideoHandler as MP4Handler;
	#else
	import hxCodec.flixel.FlxVideo as MP4Handler;
	#end
#end
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxObject;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
#if (flixel >= "6.0.0")
import flixel.sound.FlxSound;
#else
import flixel.system.FlxSound;
#end
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

using StringTools;
#end