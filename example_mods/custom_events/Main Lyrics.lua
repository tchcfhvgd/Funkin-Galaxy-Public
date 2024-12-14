-- Event notes hooks
function onEvent(name, value1, value2)
	text = (value1)
	length = tonumber(0 + value2)
	if name == "Main Lyrics" then
		if not downscroll then
			y = 615
		else
			y = 75
		end
		makeLuaText('yappin', 'Lyrics go here!', 900, 200, y)
		setTextString('yappin', '' .. text)
		setTextFont('yappin', 'MarioWii.ttf')
		setTextColor('yappin', '0xffffff')
		setTextSize('yappin', 50);
		addLuaText('yappin')
		setTextAlignment('yappin', 'center')
		setObjectCamera("yappin", 'camOther');
		runTimer('lyricalTho', length, 1)
		--removeLuaText('yappin', true)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'lyricalTho' then
		removeLuaText('yappin', true)
	end
end
