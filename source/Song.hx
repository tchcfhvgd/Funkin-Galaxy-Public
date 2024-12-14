package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef SwagSong =
{
	var song:String;
	var sections:Array<SwagSection>;
	var events:Array<Dynamic>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var boyfriend:String;
	var opponent:String;
	var gfVersion:String;
	var stage:String;

	var arrowSkin:String;
	var splashSkin:String;
	var validScore:Bool;

	var flippedHealth:Bool;
	var flippedNotes:Bool;
	var hideCombo:Bool;
	var songComposer:String;
	var songCharter:String;
	var songArtist:String;
}

class Song
{
	public var song:String;
	public var sections:Array<SwagSection>;
	public var events:Array<Dynamic>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var arrowSkin:String;
	public var splashSkin:String;
	public var speed:Float = 1;
	public var stage:String;
	public var boyfriend:String = 'bf';
	public var opponent:String = 'dad';
	public var gfVersion:String = 'gf';
	public var flippedHealth:Bool = false;
	public var flippedNotes:Bool = false;
	public var hideCombo:Bool = false;
	public var songComposer:String = "Composer";
	public var songCharter:String = "Charter";

	public static final fallbackSong:SwagSong = {
		gfVersion: "gf-nospeaker",
		events: [],
		boyfriend: "bf-car",
		hideCombo: true,
		song: "Love Driven",
		opponent: "gf-nospeaker",
		needsVoices: true,
		stage: "driving",
		sections: [],
		validScore: false,
		speed: 2.7,
		bpm: 120,
		arrowSkin: "",
		splashSkin: "noteSplashes",
		flippedHealth: false,
		flippedNotes: false,
		songComposer: "Composer",
		songCharter: "Charter",
		songArtist: "Artist",
	};

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.sections = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
	{
		try {
		var rawJson = null;
		
		var formattedFolder:String = Paths.formatToSongPath(folder);
		var formattedSong:String = Paths.formatToSongPath(jsonInput);
		#if MODS_ALLOWED
		var moddyFile:String = Paths.modsJson(formattedFolder + '/' + formattedSong);
		if(FileSystem.exists(moddyFile)) {
			rawJson = File.getContent(moddyFile).trim();
		}
		#end

		if(rawJson == null) {
			#if sys
			rawJson = File.getContent(Paths.json(formattedFolder + '/' + formattedSong)).trim();
			#else
			rawJson = Assets.getText(Paths.json(formattedFolder + '/' + formattedSong)).trim();
			#end
		}

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
			// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
		}

		// FIX THE CASTING ON WINDOWS/NATIVE
		// Windows???
		// trace(songData);

		// trace('LOADED FROM JSON: ' + songData.notes);
		/* 
			for (i in 0...songData.notes.length)
			{
				trace('LOADED FROM JSON: ' + songData.notes[i].sectionNotes);
				// songData.notes[i].sectionNotes = songData.notes[i].sectionNotes
			}

				daNotes = songData.notes;
				daSong = songData.song;
				daBpm = songData.bpm; */

		var songJson:Dynamic = parseJSONshit(rawJson);
		if(jsonInput != 'events') StageData.loadDirectory(songJson);
		return songJson;
		} catch(e) {
			lime.app.Application.current.window.alert("It seems the chart from this song doesn't exist!", "Uh Oh!");
			return fallbackSong;
		}
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var swagShit:SwagSong = cast Json.parse(rawJson);
		var jsonCheck = Json.parse(rawJson);
		if ((jsonCheck.song != null && jsonCheck.song.song != null) || (jsonCheck.song != null && jsonCheck.song.notes != null))
		{
			lime.app.Application.current.window.alert("It seems the chart from this song is not using the ModernCF Format.\nPlease format the chart in the chart editor!", "Uh Oh!");
			return fallbackSong;
		}
		swagShit.validScore = true;
		return swagShit;
	}
}
