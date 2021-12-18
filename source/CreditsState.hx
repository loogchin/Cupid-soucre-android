package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	private static var creditsStuff:Array<Dynamic> = [ //Name - Icon name - Description - Link - BG Color
		['Development Team'],
		['AnInternetsEcho',		'cammy',		'Character design, concept art, dialogue',					'https://twitter.com/AnInternetsEcho?s=09',	0xFFD0233A],
		['CHAOS_FANTAZY',			'chaos',		'Initial concept, scenario, some dialogue',				'https://twitter.com/CF_Switch?s=09',		0xFFD0233A],
		['Philiplol',			'philiplol',		'Music, coding, some background assets',				'https://twitter.com/Philiplolz',		0xFFD0233A],
		['2xPearlymintx2',			'pearl',		'Sprite conversion',				'https://twitter.com/xpearlymintx?t=f1l061FQUML5DPotuLBtPw&s=09',		0xFFD0233A],
		['Audiospawn',			'sudzy',		'Cupid voice actor',				'http://audiospawn.tumblr.com/',		0xFFD0233A],
		['SuperKirbylover',			'skl',		'Cupid artwork and animation, some background assets',				'http://superkirbylover.tumblr.com/',		0xFFD0233A],
		['The3rdComic',			'comic',		'Custom Boyfriend and Girlfriend artwork, helped with Cupid animation',				'https://twitter.com/The3rdComic?s=09',		0xFFD0233A],
		['Sampson373',			'sampson',		'Trailer editor for Candlelight Fight',				'https://twitter.com/Sampson373?s=09',		0xFFD0233A],
		['Offbi',			'offbi',		'Ending cutscene artwork',				'https://twitter.com/Officiallythat2?s=09',		0xFFD0233A],
		['FifLeo',			'fifleo',		'Transformation animation',				'https://twitter.com/fif_leo15?s=09',		0xFFD0233A],
		['Shadowfi',			'shadow',		'Super last minute coding help',				'https://twitter.com/Shadowfi1385?t=uuc1YwyeVMGKMn-nEt5Xug&s=09',		0xFFD0233A],
		[''],
		['Special Thanks'],
		['Romansito',		'roman',		'Biggest Cupid simp, hands down.',					'https://twitter.com/R0mAnsit0?t=4na6xEnyWhjUXHM6eaQD4g&s=09',	0xFFA11123],
		['Rhythmi',		'rhythmi',		'Another Cupid Enjoyer, also playtesting and feedback',					'https://twitter.com/rhy_t_hmi?t=hxeNNxWvRcD9KiCjB7Kh2Q&s=09',	0xFFA11123],
		['Pancakes',		'pancakes',		'Even more Cupid simpery',					'https://twitter.com/CharaFangirl?t=YFCiprvIoFXNxneSN4lOBw&s=09',	0xFFA11123],
		['Starryartis_',		'aike',		"Their art inspired Cupid's design!",					'https://twitter.com/CharaFangirl?t=YFCiprvIoFXNxneSN4lOBw&s=09',	0xFFA11123],
		['Szkraft220',		'kraft',		"Was originally going to help with art but didn't, still awesome though",					'https://twitter.com/szkraft220?s=09',	0xFFA11123],
		['Pip',		'pip',		"Thanks for featuring us in last August's Funkin' Forward!",					'https://twitter.com/DojimaDog?t=W_HXJ39UwBB7fInrHIXrKA&s=09',	0xFFA11123],
		['Basil',		'basil',		'Playtesting and feedback (shoutout to Vs. Omori)',					'https://twitter.com/Springy_4264?t=WOSGQM7u_s5zThHWVJTKfQ&s=09',	0xFFA11123],
		['Fletcher',		'fletcher',		"Silent Cupid Enjoyer (Shoutouts to Byte Funkin')",					'https://twitter.com/FIetcherVHS?t=Fg9bXoq_Dp6hjvdL6CUHNg&s=09',	0xFFA11123],
		['Seyu',		'seyu',		'Made so much Cupid fanart prior to release like what the fuck',					'https://twitter.com/Serizyu?t=Y806_ELsmvyodToJTAyN5A&s=09',	0xFFA11123],
		[''],
		['Cameos'],
		['Aoru Sinklair',		'',		'CHAOS_FANTAZY',					'https://twitter.com/CF_Switch?s=09',	0xFF58232B],
		['Entity',		'',		'The3rdComic',					'https://twitter.com/The3rdComic?s=09',	0xFF58232B],
		['Romansito',		'',		'Romansito',					'https://twitter.com/R0mAnsit0?t=4na6xEnyWhjUXHM6eaQD4g&s=09',	0xFF58232B],
		['Jestine',		'',		"Waffl'M",					'https://twitter.com/Waffl_M?s=09',	0xFF58232B],
		['Audiospawn',		'',		'Audiospawn',					'http://audiospawn.tumblr.com/',	0xFF58232B],
		['ManeaterMildred',		'',		'ManeaterMildred',					'https://twitter.com/ManeaterMild?s=09',	0xFF58232B],
		['Philiplol',		'',		'Philiplol',					'https://twitter.com/Philiplolz',	0xFF58232B],
		['Kala',		'',		'Patwhit01 & LucasPucas',					'https://twitter.com/Patwhit01?s=09',	0xFF58232B],
		['SuperKirbylover',		'',		'SuperKirbylover',					'http://superkirbylover.tumblr.com/',	0xFF58232B],
		['Starryartis_',		'',		'Starryartis_',					'https://twitter.com/starryartis_',	0xFF58232B],
		['BerilTheBookwyrm',		'',		'BerilTheBookwyrm',					'https://twitter.com/lireb13?s=09',	0xFF58232B],
		['Granpris',		'',		'Granpixels',					'https://twitter.com/Granpixels?s=09',	0xFF58232B],
		['Cammy',		'',		'AnInternetsEcho',					'https://twitter.com/AnInternetsEcho?s=09',	0xFF58232B],
		['BananaSplitz',		'',		'BananaSplitz',					'https://bananabandanaz.tumblr.com/',	0xFF58232B],
		['Mikubot',		'',		'Depresso',					'https://twitter.com/DepressoKnows?s=09',	0xFF58232B],
		[''],
		['Psych Engine Team'],
		['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',					'https://twitter.com/Shadow_Mario_',	0xFFFFDD33],
		['RiverOaken',			'riveroaken',		'Main Artist/Animator of Psych Engine',				'https://twitter.com/river_oaken',		0xFFC30085],
		[''],
		['Engine Contributors'],
		['shubs',				'shubs',			'New Input System Programmer',						'https://twitter.com/yoshubs',			0xFF4494E6],
		['PolybiusProxy',		'polybiusproxy',	'.MP4 Video Loader Extension',						'https://twitter.com/polybiusproxy',	0xFFE01F32],
		['gedehari',			'gedehari',			'Chart Editor\'s Sound Waveform base',				'https://twitter.com/gedehari',			0xFFFF9300],
		['Keoiki',				'keoiki',			'Note Splash Animations',							'https://twitter.com/Keoiki_',			0xFFFFFFFF],
		['SandPlanet',			'sandplanet',		'Mascot\'s Owner\nMain Supporter of the Engine',		'https://twitter.com/SandPlanetNG',		0xFFD10616],
		['bubba',				'bubba',		'Guest Composer for "Hot Dilf"',	'https://www.youtube.com/channel/UCxQTnLmv0OAS63yzk9pVfaw',	0xFF61536A],
		[''],
		["Funkin' Crew"],
		['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",				'https://twitter.com/ninja_muffin99',	0xFFF73838],
		['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",					'https://twitter.com/PhantomArcade3K',	0xFFFFBB1B],
		['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",					'https://twitter.com/evilsk8r',			0xFF53E52C],
		['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",					'https://twitter.com/kawaisprite',		0xFF6475F3]
	];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if(isSelectable) {
				if (creditsStuff[i][1] != '') {
					optionText.x -= 70;
				}
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if (creditsStuff[i][1] != '') {
					var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
					icon.xAdd = optionText.width + 10;
					icon.sprTracker = optionText;
	
					// using a FlxGroup is too much fuss!
					iconArray.push(icon);
					add(icon);	
				}

			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = creditsStuff[curSelected][4];
		intendedColor = bg.color;
		changeSelection();

		addVirtualPad(FULL, A_B);
		
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int = creditsStuff[curSelected][4];
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
