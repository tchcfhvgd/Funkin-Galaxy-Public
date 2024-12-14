
function onCreate()
	makeLuaText('yappin', 'Lyrics go here!', 1200, 64, 250) --whats in this paragraph is literally ripped out of the lyrics script
	setTextString('yappin',  'Thanks for playing!') --the text that shows up
	setTextFont('yappin', 'vcr.ttf') --the font used
	setTextColor('yappin', '0xffffff') --the color of the text
	setTextSize('yappin', 84); --the size of the text
	setTextBorder('yappin', 3.5, '15227a') --the color of the border of the text (here it's purple)
	addLuaText('yappin') --actually adding the text on screen

	setTextAlignment('yappin', 'center') --make the text be centered to itself (like when u type smthn the middle will stay the same and the left and right side will move)
	setObjectCamera('yappin', 'other') --make text not be on UI, but on "other" (since a hide UI event is used right before text shows up)
	setProperty('yappin.alpha', 0); --make the text be invisible
	screenCenter('yappin', 'X') --center the text on the X axis
	screenCenter('yappin', 'Y') --center the text on the Y axis
end

function onStepHit() --there are 16 steps in 1 section I think so using steps is more precise that using beats (there are 4 beats per section)
	if curStep == 863 then
		doTweenAlpha('TextFadeIn', 'yappin', 0.6, 2, 'cubeInOut'); --make the text fade in in 1 second
		doTweenAlpha('GUItween', 'camHUD', 0, 1.75, 'linear');
	end
	if curStep == 888 then
		doTweenAlpha('TextFadeOut', 'yappin', 0, 2, 'cubeInOut'); --make the text fade out in 1 second
	end
end