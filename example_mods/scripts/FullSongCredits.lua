local songTimeShowData = {
	['Love Driven'] = '69',

	['Star Festival'] = '69',
	['Toad Brigade'] = '69',
	['Hey There'] = '69',
	['Gusty Garden'] = '69',

	['Funky Factory'] = '5',
	['Cosmic Battle'] = '69',
	['Hell Prominence'] = '5',
	['Purple Comet'] = '5',

	['Luminous Swing'] = '8',

	['Panic Club'] = '69',
	['Revolution'] = '10',
	['Sports Mix'] = '5',
	['Rooftop Shame'] = '69',
	['Wii Modder'] = '5',
	['Sexy Luigi'] = '5',
	['Deluded Sensation'] = '5',
	['Chuckster'] = '69',
	['Starship Mario'] = '5',
	['Hell Valley'] = '69',
	['Astronomical'] = '5',

	['Prankster Club'] = '4.25',
	['Toad Brigade Erect'] = '7',
	['Gusty Garden Erect'] = '69',
	['Cosmic Battle Erect'] = '7',
	['Hell Valley Erect'] = '69',

	['The Wish'] = '5',

	['Toad Brigade Old'] = '69',
	['Cosmic Battle Old'] = '5',
	['Sexy Luigi Old'] = '5',

	['Toad Brigade 2'] = '5',

}

local offsetX = 10
local offsetY = 500
local objWidth = 500
function onCreate()

	if downscroll then
		offsetY = 80
	end

	if songName == 'Love Driven' then
		objWidth = 300
	end
	if songName == 'Star Festival' then
		objWidth = 435
	end
	if songName == 'Toad Brigade' then
		objWidth = 385
	end
	if songName == 'Hey There' then
		objWidth = 490
	end
	if songName == 'Gusty Garden' then
		objWidth = 460
	end
	if songName == 'Funky Factory' then
		objWidth = 550
	end
	if songName == 'Cosmic Battle' then
		objWidth = 450
	end
	if songName == 'Hell Prominence' then
		objWidth = 390
	end
	if songName == 'Purple Comet' then
		objWidth = 400
	end
	if songName == 'Luminous Swing' then
		objWidth = 575
	end
	if songName == 'Panic Club' then
		objWidth = 400
	end
	if songName == 'Revolution' then
		objWidth = 635
	end
	if songName == 'Sports Mix' then
		objWidth = 475
	end
	if songName == 'Rooftop Shame' then
		objWidth = 460
	end
	if songName == 'Wii Modder' then
		objWidth = 575
	end
	if songName == 'Sexy Luigi' then
		objWidth = 650
	end
	if songName == 'Deluded Sensation' then
		objWidth = 450
	end
	if songName == 'Chuckster' then
		objWidth = 345
	end
	if songName == 'Starship Mario' then
		objWidth = 385
	end
	if songName == 'Hell Valley' then
		objWidth = 470
	end
	if songName == 'Astronomical' then
		objWidth = 380
	end
	if songName == 'Prankster Club' then
		objWidth = 435
	end
	if songName == 'Toad Brigade Erect' then
		objWidth = 480
	end
	if songName == 'Gusty Garden Erect' then
		objWidth = 555
	end
	if songName == 'Cosmic Battle Erect' then
		objWidth = 525
	end
	if songName == 'Hell Valley Erect' then
		objWidth = 770
	end
	if songName == 'The Wish' then
		objWidth = 515
	end
	if songName == 'Toad Brigade Old' then
		objWidth = 415
	end
	if songName == 'Cosmic Battle Old' then
		objWidth = 575
	end
	if songName == 'Sexy Luigi Old' then
		objWidth = 650
	end
	if songName == 'Toad Brigade 2' then
		objWidth = 520
	end
end


function ifExists(table, valuecheck) -- This stupid function stops your game from throwing up errors when you play a main week song thats not in the Song Data Folder
	if table[valuecheck] then
		return true
	else
		return false
	end
end

function onBeatHit()
	if songName == 'Love Driven' then
		if curBeat == 24 then
			CreditsShow()
		end
		if curBeat == 36 then
			CreditsHide()
		end
	end

	if songName == 'Star Festival' then
		if curBeat == 40 then
			CreditsShow()
		end
		if curBeat == 72 then
			CreditsHide()
		end
	end

	if songName == 'Toad Brigade' then
		if curBeat == 16 then
			CreditsShow()
		end
		if curBeat == 24 then
			CreditsHide()
		end
	end

	if songName == 'Hey There' then
		if curBeat == 20 then
			CreditsShow()
		end
		if curBeat == 28 then
			CreditsHide()
		end
	end

	if songName == 'Gusty Garden' then 
		if curBeat == 24 then
			CreditsShow()
		end
		if curBeat == 40 then
			CreditsHide()
		end
	end

	if songName == 'Funky Factory' then
		if curBeat == 16 then
			CreditsShow()
		end
		if curBeat == 32 then
			CreditsHide()
		end
	end

	if songName == 'Cosmic Battle' then
		if curBeat == 8 then
			CreditsShow()
		end
		if curBeat == 24 then
			CreditsHide()
		end
	end

	if songName == 'Panic Club' then
		if curBeat == 16 then
			CreditsShow()
		end
		if curBeat == 20 then
			CreditsHide()
		end
	end

	if songName == 'Rooftop Shame' then
		if curBeat == 16 then
			CreditsShow()
		end
		if curBeat == 32 then
			CreditsHide()
		end
	end

	if songName == 'Chuckster' then
		if curBeat == 4 then
			CreditsShow()
		end
		if curBeat == 12 then
			CreditsHide()
		end
	end

	if songName == 'Hell Valley' then
		if curBeat == 72 then
			CreditsShow()
		end
		if curBeat == 84 then
			CreditsHide()
		end
	end

	if songName == 'Toad Brigade Old' then
		if curBeat == 16 then
			CreditsShow()
		end
		if curBeat == 24 then
			CreditsHide()
		end
	end

	if songName == 'Gusty Garden Erect' then 
		if curBeat == 24 then
			CreditsShow()
		end
		if curBeat == 40 then
			CreditsHide()
		end
	end

	if songName == 'Hell Valley Erect' then
		if curBeat == 72 then
			CreditsShow()
		end
		if curBeat == 84 then
			CreditsHide()
		end
	end
end

function CreditsShow()
songExists = ifExists(songTimeShowData, songName) -- Checks to see if song exists
	if songExists == true then
		local chartFile = getPropertyFromClass("PlayState", "SONG");
		setTextString('creditTitle', chartFile.song) -- Sets the actual things
		setTextString('creditComposer', "Song: "..chartFile.songComposer)
		setTextString('creditArtist', "Art: "..chartFile.songArtist)
		setTextString('creditCharter', "Charting: "..chartFile.songCharter)

		--Tweens--
		doTweenX("creditBoxTween", "creditBox", getProperty("creditBox.x") + objWidth, 1, "expoOut")
		doTweenX("creditTitleTween", "creditTitle", getProperty("creditTitle.x") + objWidth, 1, "expoOut")
		doTweenX("creditArtistTween", "creditArtist", getProperty("creditArtist.x") + objWidth, 1, "expoOut")
		doTweenX("creditComposerTween", "creditComposer", getProperty("creditComposer.x") + objWidth, 1, "expoOut")
		doTweenX("creditCharterTween", "creditCharter", getProperty("creditCharter.x") + objWidth, 1, "expoOut")
		runTimer("creditDisplay",songTimeShowData[songName],1)
	end
end

function onCreatePost() -- This creates all the placeholder shit B) ((THIS PART OF THE SCRIPT WAS MADE BY PIGGY))
	luaDebugMode = true

	makeLuaSprite('creditBox', 'empty', 0 - objWidth, offsetY)
	makeGraphic('creditBox', objWidth, 158, '000000')
	setObjectCamera('creditBox', 'other')
	setProperty("creditBox.alpha", 0.5)
	addLuaSprite('creditBox', true)

	makeLuaText('creditTitle', 'PlaceholderTitle', objWidth, offsetX - objWidth, offsetY+0)
	setTextSize('creditTitle', 50)
	setTextFont('creditTitle', 'MarioWii.ttf')
	setTextAlignment('creditTitle', 'left')
	setObjectCamera('creditTitle', 'other')
	addLuaText("creditTitle",true)

	makeLuaText('creditComposer', 'PlaceholderComposer', objWidth, offsetX - objWidth, offsetY+45)
	setTextSize('creditComposer', 30)
	setTextFont('creditComposer', 'Delfino.ttf')
	setTextAlignment('creditComposer', 'left')
	setObjectCamera('creditComposer', 'other')
	addLuaText("creditComposer",true)

	makeLuaText('creditArtist', 'PlaceholderArtist', objWidth, offsetX - objWidth, offsetY+80)
	setTextSize('creditArtist', 30)
	setTextFont('creditArtist', 'Delfino.ttf')
	setTextAlignment('creditArtist', 'left')
	setObjectCamera('creditArtist', 'other')
	addLuaText("creditArtist",true)

	makeLuaText('creditCharter', 'PlaceholderCharter', objWidth, offsetX - objWidth, offsetY+115)
	setTextSize('creditCharter', 30)
	setTextFont('creditCharter', 'Delfino.ttf')
	setTextAlignment('creditCharter', 'left')
	setObjectCamera('creditCharter', 'other')
	addLuaText("creditCharter",true)

	-- If you dont NOT want the art and charter credits (or a mix of two), the value used in the old version is:
	-- offsetY+25 for creditTitle
	-- offsetY+80 for the other credit (be it Composer, Charting, or Art)

	if songName == 'Panic Club' then
		setTextFont('creditTitle', 'pixel.otf')
		setTextFont('creditComposer', 'pixel.otf')
		setTextFont('creditArtist', 'pixel.otf')
		setTextFont('creditCharter', 'pixel.otf')
		setTextSize('creditTitle', 35)
		setTextSize('creditComposer', 25)
		setTextSize('creditArtist', 25)
		setTextSize('creditCharter', 25)
	end

end

function onSongStart()

	if songName == 'Love Driven'
	or songName == 'Star Festival'
	or songName == 'Toad Brigade'
	or songName == 'Hey There'
	or songName == 'Gusty Garden'
	or songName == 'Funky Factory'
	or songName == 'Cosmic Battle'
	or songName == 'Panic Club'
	or songName == 'Rooftop Shame'
	or songName == 'Chuckster'
	or songName == 'Hell Valley'
	or songName == 'Toad Brigade Old'
	or songName == 'Gusty Garden Erect'
	or songName == 'Hell Valley Erect'

	then

	else
	CreditsShow()
	end
end

function onTimerCompleted(timerName)
	if timerName == "creditDisplay" then
		CreditsHide()
	end
end

function CreditsHide()
	doTweenX("creditBoxTween", "creditBox", getProperty("creditBox.x") - objWidth, 0.5, "sineIn")
	doTweenX("creditTitleTween", "creditTitle", getProperty("creditTitle.x") - objWidth, 0.5, "sineIn")
	doTweenX("creditComposerTween", "creditComposer", getProperty("creditComposer.x") - objWidth, 0.5, "sineIn")
	doTweenX("creditArtistTween", "creditArtist", getProperty("creditArtist.x") - objWidth, 0.5, "sineIn")
	doTweenX("creditCharterTween", "creditCharter", getProperty("creditCharter.x") - objWidth, 0.5, "sineIn")
end

--[[
CREDITS :yippee:

omotashi: Made the script (https://twitter.com/omotashii)
legole0: Helped him make the base script when he started from scratch (https://twitter.com/legole0)
Piggyfriend1792: The OG Script from the Monday Night Monsterin' Mod that he used for making the thing show up (https://twitter.com/piggyfriend1792)
DEAD SKULLXX: Requested him to add Artist and Charter Credits 
Flez: Made the file cleaner and easier to read, and added more comments
--]]
